//
//  WelcomeSkillsViewController.swift
//  ShowcaseApp
//
//  Created by Lukasz Spaczynski on 21/11/2021.
//

import RxCocoa
import RxSwift
import UIKit

final class WelcomeSkillsViewController: UIViewController {
    @IBOutlet var buttonNext: UIButton!
    @IBOutlet var buttonPrev: UIButton!

    var viewModel: WelcomeSkillsViewModel!
    var navigator: Navigator!
    var style: WelcomeAppStyle!

    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        bindViewModel()
        apply(style: style)
        applyAccessibility()
    }

    private func bindViewModel() {
        // Input
        let nextEvent = buttonNext.rx.controlEvent(.primaryActionTriggered)
        let prevEvent = buttonPrev.rx.controlEvent(.primaryActionTriggered)
        let input = WelcomeSkillsViewModel.Input(
            prevEvent: prevEvent,
            nextEvent: nextEvent
        )

        // Output
        let output = viewModel.transform(input)
        let nextDriver = output.nextDriver
        let prevDriver = output.prevDriver

        prevDriver
            .drive(onNext: { [weak self] _ in
                self?.navigatePrev()
            })
            .disposed(by: disposeBag)

        nextDriver
            .drive(onNext: { [weak self] _ in
                self?.navigateNext()
            })
            .disposed(by: disposeBag)
    }
}
