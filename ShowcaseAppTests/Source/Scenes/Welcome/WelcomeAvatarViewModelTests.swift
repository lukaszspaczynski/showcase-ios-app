//
//  WelcomeAvatarViewModelTests.swift
//  ShowcaseAppTests
//
//  Created by Lukasz Spaczynski on 14/12/2021.
//

import Nimble
import RxBlocking
import RxCocoa
import RxSwift
import RxTest
import ShowcaseDomain
import ShowcaseDomainMocks
import XCTest

@testable import ShowcaseApp

final class WelcomeAvatarViewModelTests: XCTestCase {
    private enum DummyError: Error {
        case dummy
    }

    func testNextDriver() throws {
        // GIVEN

        var (sut, _, testable, _) = Self.prepareTestComponents()

        // WHEN
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
            testable.nextSubject.onNext(())
        }

        let output: Void? = try sut
            .transform(testable.input)
            .nextDriver
            .toBlocking(timeout: 1)
            .first()

        // THEN
        expect(output).toNot(beNil())
    }

    func testPrevDriver() throws {
        // GIVEN

        var (sut, _, testable, _) = Self.prepareTestComponents()

        // WHEN
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
            testable.prevSubject.onNext(())
        }

        let output: Void? = try sut
            .transform(testable.input)
            .prevDriver
            .toBlocking(timeout: 1)
            .first()

        // THEN
        expect(output).toNot(beNil())
    }

    func testShowViewDriverOnSuccessResult() throws {
        // GIVEN
        var (sut, getAvatarUseCase, testable, scheduler) = Self.prepareTestComponents()
        let disposeBag = DisposeBag()

        getAvatarUseCase.executeInvokedResult = .valid

        let output = sut.transform(testable.input)

        disposeBag.insert(output.disposables)

        output
            .workingDriver
            .drive(testable.workingObserver)
            .disposed(by: disposeBag)

        output
            .showViewDriver
            .drive(testable.viewStateObserver)
            .disposed(by: disposeBag)

        output
            .avatarDriver
            .drive(testable.avatarObserver)
            .disposed(by: disposeBag)

        scheduler
            .createColdObservable([.next(10, ())])
            .bind(to: testable.loadSubject)
            .disposed(by: disposeBag)

        // WHEN
        scheduler.start()

        let workingEvents: [Bool] = testable
            .workingObserver
            .events
            .compactMap(\.value.element)
            .reversed()

        let viewStateEvents: [ViewState] = testable
            .viewStateObserver
            .events
            .compactMap(\.value.element)
            .reversed()

        let avatarEvents: [Avatar] = testable
            .avatarObserver
            .events
            .compactMap(\.value.element)

        // THEN
        expect(workingEvents.count).to(beGreaterThanOrEqualTo(3))
        expect(workingEvents[0]).to(beFalse())
        expect(workingEvents[1]).to(beTrue())
        expect(workingEvents[2]).to(beFalse())
        expect(avatarEvents.last).toNot(beNil())
        expect(viewStateEvents.count).to(beGreaterThanOrEqualTo(2))
        expect(viewStateEvents[0]).to(equal(.avatar))
        expect(viewStateEvents[1]).to(equal(.working))
    }

    func testShowViewDriverOnFailureResult() throws {
        // GIVEN
        var (sut, getAvatarUseCase, testable, scheduler) = Self.prepareTestComponents()
        let disposeBag = DisposeBag()

        getAvatarUseCase.executeInvokedResult = .failure(DummyError.dummy)

        let output = sut.transform(testable.input)

        disposeBag.insert(output.disposables)

        output
            .workingDriver
            .drive(testable.workingObserver)
            .disposed(by: disposeBag)

        output
            .showViewDriver
            .drive(testable.viewStateObserver)
            .disposed(by: disposeBag)

        output
            .avatarDriver
            .drive(testable.avatarObserver)
            .disposed(by: disposeBag)

        scheduler
            .createColdObservable([.next(10, ())])
            .bind(to: testable.loadSubject)
            .disposed(by: disposeBag)

        // WHEN
        scheduler.start()

        let workingEvents: [Bool] = testable
            .workingObserver
            .events
            .compactMap(\.value.element)
            .reversed()

        let viewStateEvents: [ViewState] = testable
            .viewStateObserver
            .events
            .compactMap(\.value.element)
            .reversed()

        let avatarEvents: [Avatar] = testable
            .avatarObserver
            .events
            .compactMap(\.value.element)

        // THEN
        expect(workingEvents.count).to(beGreaterThanOrEqualTo(3))
        expect(workingEvents[0]).to(beFalse())
        expect(workingEvents[1]).to(beTrue())
        expect(workingEvents[2]).to(beFalse())
        expect(avatarEvents.last).to(beNil())
        expect(viewStateEvents.count).to(beGreaterThanOrEqualTo(2))
        expect(viewStateEvents[0]).to(equal(.error))
        expect(viewStateEvents[1]).to(equal(.working))
    }
}

extension WelcomeAvatarViewModelTests {
    typealias ViewState = WelcomeAvatarViewModelOutput.ViewState
    typealias Avatar = WelcomeAvatarViewModelOutput.Avatar

    struct MockedAvatarEndpoint: AvatarEndpoint {
        var avatarEndpoint = URL(string: "http://dummy.net")!
    }

    struct WelcomeAvatarViewModelTestable {
        let loadSubject = PublishSubject<Void>()
        let prevSubject = PublishSubject<Void>()
        let nextSubject = PublishSubject<Void>()
        let openLinkSubject = PublishSubject<URL>()

        let workingObserver: TestableObserver<Bool>
        let viewStateObserver: TestableObserver<ViewState>
        let avatarObserver: TestableObserver<Avatar>

        private(set) lazy var input: WelcomeAvatarViewModelInput = {
            typealias C<T> = ControlEvent<T>

            return WelcomeAvatarViewModelInput(
                loadEvent: C(events: loadSubject),
                prevEvent: C(events: prevSubject),
                nextEvent: C(events: nextSubject)
            )
        }()

        init(_ scheduler: TestScheduler) {
            workingObserver = scheduler.createObserver(Bool.self)
            viewStateObserver = scheduler.createObserver(ViewState.self)
            avatarObserver = scheduler.createObserver(Avatar.self)
        }
    }

    typealias TestComponents = (
        sut: WelcomeAvatarViewModel,
        getAvatarUseCase: MockedGetAvatarUseCase,
        testable: WelcomeAvatarViewModelTestable,
        scheduler: TestScheduler
    )

    static func prepareTestComponents() -> TestComponents {
        let scheduler = TestScheduler(initialClock: 0)
        let getAvatarUseCase = MockedGetAvatarUseCase()
        let testable = WelcomeAvatarViewModelTestable(scheduler)
        let mockedEndpoint = MockedAvatarEndpoint()

        let sut = ConcreteWelcomeAvatarViewModel(
            getAvatarUseCase: getAvatarUseCase,
            avatarEndpoint: mockedEndpoint
        )

        return (sut, getAvatarUseCase, testable, scheduler)
    }
}
