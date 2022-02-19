import UIKit

enum BottomSheetType {
    case debug(content: DebugContent)
    case error(content: OneButton)
    case signUp(content: OneButton)
    case logout(content: OneButton)

    struct BottomSheetContent {
        var title: String?
        var body: String?
        let actions: [BottomSheetAction]
        var dismissCallback: VoidBlock?
        var completion: VoidBlock?
    }

    struct DebugContent {
        let title: String?
        let body: String?
        let actions: [BottomSheetAction]
    }

    struct OneButton {
        var body: String?
        let handler: VoidBlock
    }

    var content: BottomSheetContent {
        switch self {
            case let .debug(content):
                return .init(
                    title: content.title,
                    body: content.body,
                    actions: content.actions
                )

            case let .error(content):
                return .init(
                    title: Resources.Strings.Alert.error,
                    body: content.body,
                    actions: [.init(
                        title: Resources.Strings.Alert.ok,
                        style: .alert,
                        handler: content.handler
                    )]
                )

            case let .signUp(content):
                return .init(
                    title: Resources.Strings.Alert.done,
                    body: Resources.Strings.Alert.successSignUpMessage,
                    actions: [.init(
                        title: Resources.Strings.Alert.ok,
                        style: .default,
                        handler: content.handler
                    )],
                    dismissCallback: content.handler
                )

            case let .logout(content):
                return .init(
                    title: Resources.Strings.Alert.warn,
                    body: Resources.Strings.Alert.wouldYouLikeToLogout,
                    actions: [.init(
                        title: Resources.Strings.Alert.ok,
                        style: .alert,
                        handler: content.handler
                    )]
                )
        }
    }
}

extension UIViewController {

    func showBottomSheet(
        view: UIView,
        dismissCallBack: VoidBlock? = nil,
        completion: VoidBlock? = nil
    ) {
        let bottomSheetVC = Resources.ViewControllers.App.bottomSheet(
            dismissCallBack: dismissCallBack
        )
        bottomSheetVC.set(view: view)

        present(
            bottomSheetVC,
            animated: true,
            completion: completion
        )
    }

    func showBottomSheet(type: BottomSheetType) {
        let commonBottomSheetView = CommonBottomSheetContentView()
        let content = type.content
        commonBottomSheetView.set(
            title: content.title,
            body: content.body,
            actions: content.actions
        )

        let bottomSheetVC = Resources.ViewControllers.App.bottomSheet(
            dismissCallBack: content.dismissCallback
        )
        bottomSheetVC.set(view: commonBottomSheetView)

        present(
            bottomSheetVC,
            animated: true,
            completion: content.completion
        )
    }
}
