import Combine
import UIKit

// MARK: - stored properties & init

final class KeyboardHandler {
    let onChange: (KeyboardState) -> Void

    private(set) var currentState: KeyboardState?

    private let keyboardNotifications: [NSNotification.Name] = [
        UIResponder.keyboardWillShowNotification,
        UIResponder.keyboardWillHideNotification
    ]

    private lazy var cancellables: AnyCancellable? = .init {}

    init(with changeHandler: @escaping ((KeyboardState) -> Void)) {
        onChange = changeHandler

        let notification = NotificationCenter.default

        cancellables = Publishers.MergeMany(
            keyboardNotifications.map { notification.publisher(for: $0) }
        )
        .sink { notification in
            self.currentState = KeyboardState(with: notification)
            self.onChange(KeyboardState(with: notification))
        }
    }
}

// MARK: - internal methods

extension KeyboardHandler {

    func unsubscribe() {
        cancellables?.cancel()
    }
}

// MARK: - private methods

private extension KeyboardHandler {

    @objc func receivedKeyboardNotification(notification: Notification) {
        currentState = .init(with: notification)
        onChange(.init(with: notification))
    }
}
