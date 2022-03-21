import UIKit

/** Keyboard and Combine
 * https://www.swiftjectivec.com/keyboard-and-combine/
 */

enum KeyboardTransitionState {
    case unset
    case willShow
    case willHide
}

// MARK: - stored properties & init

struct KeyboardState {
    var state: KeyboardTransitionState = .unset
    var height = 0.0
    var animationDuration = 0.0

    private let frameEnd = UIResponder.keyboardFrameEndUserInfoKey
    private let animationEnd = UIResponder.keyboardAnimationDurationUserInfoKey

    init(with note: Notification) {
        switch note.name {
            case UIResponder.keyboardWillShowNotification:
                state = .willShow

                if let keyboardEndFrame = note.userInfo?[frameEnd] as? CGRect {
                    height = Double(keyboardEndFrame.size.height)
                }

                if let animationDurationValue = note.userInfo?[animationEnd] as? NSNumber {
                    animationDuration = animationDurationValue.doubleValue
                }

            case UIResponder.keyboardWillHideNotification:
                state = .willHide

                if let animationDurationValue = note.userInfo?[animationEnd] as? NSNumber {
                    animationDuration = animationDurationValue.doubleValue
                }

            default:
                break
        }
    }
}
