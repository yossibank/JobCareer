import UIKit

enum KeyboardTransitionState {
    case unset
    case willShow
    case willHide
}

// MARK: - stored properties & init

struct KeyboardState {
    var state: KeyboardTransitionState = .unset
    var height = 0.0
    var isVisible = false
    var frame: CGRect = .zero
    var animationDuration = 0.0

    private let frameEnd = UIResponder.keyboardFrameEndUserInfoKey
    private let animationEnd = UIResponder.keyboardAnimationDurationUserInfoKey

    init(with note: Notification) {
        switch note.name {
            case UIResponder.keyboardWillShowNotification:
                state = .willShow
                isVisible = true

                if let keyboardEndFrame = note.userInfo?[frameEnd] as? CGRect {
                    height = Double(keyboardEndFrame.size.height)
                }

                if let animationDurationValue = note.userInfo?[animationEnd] as? NSNumber {
                    animationDuration = animationDurationValue.doubleValue
                }

            case UIResponder.keyboardWillHideNotification:
                state = .willHide
                isVisible = false

                if let animationDurationValue = note.userInfo?[animationEnd] as? NSNumber {
                    animationDuration = animationDurationValue.doubleValue
                }

            default:
                break
        }
    }
}
