//
//  WelcomeBioViewModelTests.swift
//  ShowcaseAppTests
//
//  Created by Lukasz Spaczynski on 26/11/2021.
//

import Nimble
import RxBlocking
import RxCocoa
import RxSwift
import RxTest
import ShowcaseDomainMocks
import XCTest

@testable import ShowcaseApp

final class WelcomeBioViewModelTests: XCTestCase {
    private enum DummyError: Error {
        case dummy
    }

    func testLinkDriver() throws {
        // GIVEN

        let (sut, _, testable, _) = Self.prepareTestComponents()

        // WHEN
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
            testable.openLinkSubject.onNext(URL(string: "http://dummy.net")!)
        }

        let output = try sut
            .transform(testable.input)
            .linkDriver
            .toBlocking(timeout: 1)
            .first()

        // THEN
        expect(output).toNot(beNil())
    }

    func testNextDriver() throws {
        // GIVEN

        let (sut, _, testable, _) = Self.prepareTestComponents()

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

        let (sut, _, testable, _) = Self.prepareTestComponents()

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
        let (sut, getBioUseCase, testable, scheduler) = Self.prepareTestComponents()
        let disposeBag = DisposeBag()

        getBioUseCase.executeInvokedResult = .valid

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
            .bioDriver
            .drive(testable.bioObserver)
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

        let bioEvents: [Bio] = testable
            .bioObserver
            .events
            .compactMap(\.value.element)

        // THEN
        expect(workingEvents.count).to(beGreaterThanOrEqualTo(3))
        expect(workingEvents[0]).to(beFalse())
        expect(workingEvents[1]).to(beTrue())
        expect(workingEvents[2]).to(beFalse())
        expect(bioEvents.last).toNot(beNil())
        expect(viewStateEvents.count).to(beGreaterThanOrEqualTo(2))
        expect(viewStateEvents[0]).to(equal(.bio))
        expect(viewStateEvents[1]).to(equal(.working))
    }

    func testShowViewDriverOnFailureResult() throws {
        // GIVEN
        let (sut, getBioUseCase, testable, scheduler) = Self.prepareTestComponents()
        let disposeBag = DisposeBag()

        getBioUseCase.executeInvokedResult = .failure(DummyError.dummy)

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
            .bioDriver
            .drive(testable.bioObserver)
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

        let bioEvents: [Bio] = testable
            .bioObserver
            .events
            .compactMap(\.value.element)

        // THEN
        expect(workingEvents.count).to(beGreaterThanOrEqualTo(3))
        expect(workingEvents[0]).to(beFalse())
        expect(workingEvents[1]).to(beTrue())
        expect(workingEvents[2]).to(beFalse())
        expect(bioEvents.last).to(beNil())
        expect(viewStateEvents.count).to(beGreaterThanOrEqualTo(2))
        expect(viewStateEvents[0]).to(equal(.error))
        expect(viewStateEvents[1]).to(equal(.working))
    }
}

extension WelcomeBioViewModelTests {
    typealias ViewState = WelcomeBioViewModelOutput.ViewState
    typealias Bio = WelcomeBioViewModelOutput.Bio

    struct WelcomeBioViewModelTestable {
        let loadSubject = PublishSubject<Void>()
        let prevSubject = PublishSubject<Void>()
        let nextSubject = PublishSubject<Void>()
        let openLinkSubject = PublishSubject<URL>()

        let workingObserver: TestableObserver<Bool>
        let viewStateObserver: TestableObserver<ViewState>
        let bioObserver: TestableObserver<Bio>

        var input: WelcomeBioViewModelInput {
            typealias C<T> = ControlEvent<T>

            return WelcomeBioViewModelInput(
                loadEvent: C(events: loadSubject),
                prevEvent: C(events: prevSubject),
                nextEvent: C(events: nextSubject),
                openLinkEvent: C(events: openLinkSubject)
            )
        }

        init(_ scheduler: TestScheduler) {
            workingObserver = scheduler.createObserver(Bool.self)
            viewStateObserver = scheduler.createObserver(ViewState.self)
            bioObserver = scheduler.createObserver(Bio.self)
        }
    }

    typealias TestComponents = (
        sut: WelcomeBioViewModel,
        getBioUseCase: MockedGetBioUseCase,
        testable: WelcomeBioViewModelTestable,
        scheduler: TestScheduler
    )

    static func prepareTestComponents() -> TestComponents {
        let scheduler = TestScheduler(initialClock: 0)
        let getBioUseCase = MockedGetBioUseCase()
        let testable = WelcomeBioViewModelTestable(scheduler)

        let sut = ConcreteWelcomeBioViewModel(
            getBioUseCase: getBioUseCase)

        return (sut, getBioUseCase, testable, scheduler)
    }
}
