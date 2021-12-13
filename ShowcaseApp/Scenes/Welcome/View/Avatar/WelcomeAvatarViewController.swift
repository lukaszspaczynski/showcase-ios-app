//
//  WelcomeAvatarViewController.swift
//  ShowcaseApp
//
//  Created by Lukasz Spaczynski on 21/11/2021.
//

import RxCocoa
import RxSwift
import UIKit

final class WelcomeAvatarViewController: UIViewController {
    @IBOutlet var buttonPrev: UIButton!
    @IBOutlet var buttonNext: UIButton!
    @IBOutlet var buttonReload: UIButton!
    @IBOutlet var viewError: UIView!
    @IBOutlet var viewAvatar: UIView!
    @IBOutlet var viewLoading: UIView!
    @IBOutlet var viewActivityIndicator: UIActivityIndicatorView!
    @IBOutlet var imageViewPixelizedAvatar: UIImageView!

    var viewModel: WelcomeAvatarViewModel!
    var navigator: Navigator!
    var style: WelcomeAppStyle!

    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        bind()
        bind(viewModel)
        apply(style: style)
        applyAccessibility()
    }

    private func bind() {
        let tapGesture = UITapGestureRecognizer()
        imageViewPixelizedAvatar.isUserInteractionEnabled = true
        imageViewPixelizedAvatar.addGestureRecognizer(tapGesture)

        tapGesture.rx
            .event
            .subscribe(
                onNext: { [weak self] _ in
                    self?.imageViewPixelizedAvatar.startAnimating()
                })
            .disposed(by: disposeBag)
    }

    private func bind(_ viewModel: WelcomeAvatarViewModel) {
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
        let input = WelcomeAvatarViewModel.Input(
            loadEvent: loadEvent,
            prevEvent: prevEvent,
            nextEvent: nextEvent
        )

        // Output
        let output = viewModel.transform(input)

        bind(output)
    }

    private func bind(_ vmo: WelcomeAvatarViewModelOutput) {
        disposeBag.insert(vmo.disposables)

        vmo.workingDriver
            .asObservable()
            .bind(to: viewActivityIndicator.rx.isAnimating)
            .disposed(by: disposeBag)

        vmo.nextDriver
            .drive(onNext: { [weak self] _ in
                self?.navigateNext()
            })
            .disposed(by: disposeBag)

        vmo.prevDriver
            .drive(onNext: { [weak self] _ in
                self?.navigatePrev()
            })
            .disposed(by: disposeBag)

        vmo.avatarDriver
            .drive(onNext: bind)
            .disposed(by: disposeBag)

        vmo.showViewDriver
            .drive(onNext: show(view:))
            .disposed(by: disposeBag)
    }

    private func bind(_ avatar: WelcomeAvatarViewModelOutput.Avatar) {
//        let radius = imageViewPixelizedAvatar.frame.width / 2.0

        imageViewPixelizedAvatar.image = avatar.original
        imageViewPixelizedAvatar.animationImages = avatar.pixelized
        imageViewPixelizedAvatar.animationDuration = 4
        imageViewPixelizedAvatar.animationRepeatCount = 1
        imageViewPixelizedAvatar.startAnimating()
//        imageViewPixelizedAvatar.layer.cornerRadius = radius
    }

    private func show(view type: WelcomeAvatarViewModelOutput.ViewState) {
        let animations: () -> Void
        let completion: (Bool) -> Void

        switch type {
        case .avatar:

            animations = { [weak self] in
                self?.viewError.alpha = 0.0
                self?.viewLoading.alpha = 0.0
                self?.viewAvatar.alpha = 1.0
            }

            completion = { [weak self] _ in
                self?.viewError.isHidden = true
                self?.viewLoading.isHidden = true
                self?.viewAvatar.isHidden = false
            }

        case .working:

            animations = { [weak self] in
                self?.viewError.alpha = 0.0
                self?.viewLoading.alpha = 1.0
                self?.viewAvatar.alpha = 0.0
            }

            completion = { [weak self] _ in
                self?.viewError.isHidden = true
                self?.viewLoading.isHidden = false
                self?.viewAvatar.isHidden = true
            }

        case .error:

            animations = { [weak self] in
                self?.viewError.alpha = 1.0
                self?.viewLoading.alpha = 0.0
                self?.viewAvatar.alpha = 0.0
            }

            completion = { [weak self] _ in
                self?.viewError.isHidden = false
                self?.viewLoading.isHidden = true
                self?.viewAvatar.isHidden = true
            }
        }

        UIView.animate(withDuration: style.animationDuration,
                       animations: animations,
                       completion: completion)
    }
}
