//
//  WelcomeSkillsViewModelTests.swift
//  ShowcaseAppTests
//
//  Created by Lukasz Spaczynski on 14/12/2021.
//

import Nimble
import RxBlocking
import RxCocoa
import RxSwift
import RxTest
import ShowcaseDomainMocks
import XCTest

@testable import ShowcaseApp

final class WelcomeSkillsViewModelTests: XCTestCase {
    private enum DummyError: Error {
        case dummy
    }

    func testNextDriver() throws {
        // GIVEN

        var (sut, testable) = Self.prepareTestComponents()

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

        var (sut, testable) = Self.prepareTestComponents()

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
}

extension WelcomeSkillsViewModelTests {
    struct WelcomeSkillsViewModelTestable {
        let prevSubject = PublishSubject<Void>()
        let nextSubject = PublishSubject<Void>()

        lazy var input: WelcomeSkillsViewModelInput = {
            typealias C<T> = ControlEvent<T>

            return WelcomeSkillsViewModelInput(
                prevEvent: C(events: prevSubject),
                nextEvent: C(events: nextSubject)
            )
        }()
    }

    typealias TestComponents = (
        sut: WelcomeSkillsViewModel,
        testable: WelcomeSkillsViewModelTestable
    )

    static func prepareTestComponents() -> TestComponents {
        let testable = WelcomeSkillsViewModelTestable()

        let sut = ConcreteWelcomeSkillsViewModel()

        return (sut, testable)
    }
}
