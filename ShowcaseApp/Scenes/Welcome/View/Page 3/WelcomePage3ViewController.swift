//
//  WelcomePage3ViewController.swift
//  ShowcaseApp
//
//  Created by Lukasz Spaczynski on 21/11/2021.
//

import RxCocoa
import RxSwift
import UIKit

final class WelcomePage3ViewController: UIViewController {
    @IBOutlet var buttonPrev: UIButton!
    @IBOutlet var buttonStart: UIButton!

    var viewModel: WelcomePage3ViewModel!
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
        let startEvent = buttonStart.rx.controlEvent(.primaryActionTriggered)
        let prevEvent = buttonPrev.rx.controlEvent(.primaryActionTriggered)
        let input = WelcomePage3ViewModel.Input(
            prevEvent: prevEvent,
            startEvent: startEvent
        )

        // Output
        let output = viewModel.transform(input)
        let startDriver = output.startDriver
        let prevDriver = output.prevDriver

        startDriver
            .drive(onNext: { [weak self] _ in
                self?.navigateStart()
            })
            .disposed(by: disposeBag)

        prevDriver
            .drive(onNext: { [weak self] _ in
                self?.navigatePrev()
            })
            .disposed(by: disposeBag)
    }
}
