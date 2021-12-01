//
//  WelcomePage1ViewController.swift
//  ShowcaseApp
//
//  Created by Lukasz Spaczynski on 21/11/2021.
//

import RxCocoa
import RxSwift
import UIKit

final class WelcomePage1ViewController: UIViewController {
    @IBOutlet var labelHeader: UILabel!
    @IBOutlet var buttonNext: UIButton!

    var viewModel: WelcomePage1ViewModel!
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
        let input = WelcomePage1ViewModel.Input(
            nextEvent: nextEvent)

        // Output
        let output = viewModel.transform(input)
        let nextDriver = output.nextDriver

        nextDriver
            .drive(onNext: { [weak self] _ in
                self?.navigateNext()
            })
            .disposed(by: disposeBag)
    }
}
