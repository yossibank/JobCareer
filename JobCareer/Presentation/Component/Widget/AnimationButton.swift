import UIKit

final class AnimationButton: UIButton {

    init(
        style: ViewStyle<AnimationButton>,
        title: String,
        titleColor: UIColor = .systemBackground,
        for state: UIControl.State = .normal
    ) {
        super.init(frame: .zero)
        self.setTitle(title, for: state)
        self.setTitleColor(titleColor, for: state)
        apply(style)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

// MARK: - override methods

extension AnimationButton {

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        touchStartAnimation(button: self)
    }

    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        touchEndAnimation(button: self)
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        touchEndAnimation(button: self)
    }
}

// MARK: - private methods

private extension AnimationButton {

    func touchStartAnimation(button: UIButton, duration: CGFloat = 0.1) {
        UIView.animate(
            withDuration: duration,
            delay: 0.0,
            options: .curveEaseIn
        ) {
            button.transform = .init(scaleX: 0.95, y: 0.95)
            button.alpha = 0.7
        }
    }

    func touchEndAnimation(button: UIButton, duration: CGFloat = 0.1) {
        UIView.animate(
            withDuration: duration,
            delay: 0.0,
            options: .curveEaseIn
        ) {
            button.transform = .init(scaleX: 1.0, y: 1.0)
            button.alpha = 1.0
        }
    }
}
