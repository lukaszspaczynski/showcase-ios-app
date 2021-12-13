//
//  WelcomeBioViewController.swift
//  ShowcaseApp
//
//  Created by Lukasz Spaczynski on 21/11/2021.
//

import Action
import RxAppState
import RxCocoa
import RxSwift
import UIKit

final class WelcomeBioViewController: UIViewController {
    @IBOutlet var labelError: UILabel!
    @IBOutlet var buttonReload: UIButton!
    @IBOutlet var buttonPrev: UIButton!
    @IBOutlet var buttonNext: UIButton!
    @IBOutlet var viewActivityIndicator: UIActivityIndicatorView!
    @IBOutlet var viewError: UIView!
    @IBOutlet var viewBio: UIView!
    @IBOutlet var viewLoading: UIView!
    @IBOutlet var viewBioStack: UIStackView!

    var viewModel: WelcomeBioViewModel!
    var navigator: Navigator!
    var style: WelcomeAppStyle!

    private let disposeBag = DisposeBag()
    private let openLinkSubject = PublishSubject<URL>()

    override func viewDidLoad() {
        super.viewDidLoad()

        bind(viewModel)
        apply(style: style)
        applyAccessibility()
    }

    private func bind(_ viewModel: WelcomeBioViewModel) {
        // Input
        let willAppearObservable = rx.viewDidAppear
            .map { _ -> Void in () }
            .take(1)

        let reloadObservable = buttonReload.rx
            .controlEvent(.primaryActionTriggered)
            .asObservable()

        let loadObservable = Observable.merge(
            willAppearObservable,
            reloadObservable
        )

        let loadEvent = ControlEvent(events: loadObservable)
        let nextEvent = buttonNext.rx.controlEvent(.primaryActionTriggered)
        let prevEvent = buttonPrev.rx.controlEvent(.primaryActionTriggered)
        let openLinkEvent = ControlEvent<URL>(events: openLinkSubject.asObserver())

        let input = WelcomeBioViewModel.Input(
            loadEvent: loadEvent,
            prevEvent: prevEvent,
            nextEvent: nextEvent,
            openLinkEvent: openLinkEvent
        )

        // Output
        let output = viewModel.transform(input)

        bind(output)
    }

    private func bind(_ vmo: WelcomeBioViewModelOutput) {
        disposeBag.insert(vmo.disposables)

        vmo.workingDriver
            .asObservable()
            .map { ($0 ? 0.5 : 1.0) }
            .bind(to: buttonReload.rx.alpha)
            .disposed(by: disposeBag)

        vmo.workingDriver
            .asObservable()
            .map { !$0 }
            .bind(to: buttonReload.rx.isEnabled)
            .disposed(by: disposeBag)

        vmo.workingDriver
            .asObservable()
            .bind(to: viewActivityIndicator.rx.isAnimating)
            .disposed(by: disposeBag)

        vmo.bioDriver
            .drive(onNext: bind)
            .disposed(by: disposeBag)

        vmo.nextDriver
            .drive(onNext: navigateNext)
            .disposed(by: disposeBag)

        vmo.prevDriver
            .drive(onNext: navigatePrev)
            .disposed(by: disposeBag)

        vmo.linkDriver
            .drive(onNext: navigateTo(url:))
            .disposed(by: disposeBag)

        vmo.showViewDriver
            .drive(onNext: show(view:))
            .disposed(by: disposeBag)
    }

    private func bind(_ bio: WelcomeBioViewModelOutput.Bio) {
        viewBioStack
            .arrangedSubviews
            .forEach(viewBioStack.removeArrangedSubview)

        let labelSummary = UILabel()
        labelSummary.numberOfLines = 0
        labelSummary.attributedText = bio.summary

        viewBioStack.addArrangedSubview(labelSummary)

        bio.links
            .sorted(by: { lhv, rhv in
                lhv.key.string >= rhv.key.string
            })
            .map { [unowned self] (title, url) -> UIButton in
                let button = UIButton(type: .system)

                button.setAttributedTitle(title, for: .normal)
                button.rx
                    .controlEvent(.primaryActionTriggered)
                    .map { url }
                    .bind(to: self.openLinkSubject)
                    .disposed(by: disposeBag)
                button.translatesAutoresizingMaskIntoConstraints = false

                let heightConstraint = NSLayoutConstraint(
                    item: button,
                    attribute: .height,
                    relatedBy: .equal,
                    toItem: nil,
                    attribute: .notAnAttribute,
                    multiplier: 1,
                    constant: 24
                )
                button.addConstraint(heightConstraint)

                return button
            }.forEach(viewBioStack.addArrangedSubview)

        viewBioStack.setNeedsLayout()
        viewBioStack.setNeedsDisplay()
    }

    private func show(view type: WelcomeBioViewModelOutput.ViewState) {
        let animations: () -> Void
        let completion: (Bool) -> Void

        switch type {
        case .bio:

            animations = { [weak self] in
                self?.viewError.alpha = 0.0
                self?.viewLoading.alpha = 0.0
                self?.viewBio.alpha = 1.0
            }

            completion = { [weak self] _ in
                self?.viewError.isHidden = true
                self?.viewLoading.isHidden = true
                self?.viewBio.isHidden = false
            }

        case .working:

            animations = { [weak self] in
                self?.viewError.alpha = 0.0
                self?.viewLoading.alpha = 1.0
                self?.viewBio.alpha = 0.0
            }

            completion = { [weak self] _ in
                self?.viewError.isHidden = true
                self?.viewLoading.isHidden = false
                self?.viewBio.isHidden = true
            }

        case .error:

            animations = { [weak self] in
                self?.viewError.alpha = 1.0
                self?.viewLoading.alpha = 0.0
                self?.viewBio.alpha = 0.0
            }

            completion = { [weak self] _ in
                self?.viewError.isHidden = false
                self?.viewLoading.isHidden = true
                self?.viewBio.isHidden = true
            }
        }

        UIView.animate(withDuration: style.animationDuration,
                       animations: animations,
                       completion: completion)
    }
}
