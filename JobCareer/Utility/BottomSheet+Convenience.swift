import UIKit

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

    func showBottomSheet(
        title: String?,
        body: String?,
        actions: [BottomSheetAction],
        dismissCallBack: VoidBlock? = nil,
        completion: VoidBlock? = nil
    ) {
        let commonBottomSheetView = CommonBottomSheetContentView()
        commonBottomSheetView.set(
            title: title,
            body: body,
            actions: actions
        )

        let bottomSheetVC = Resources.ViewControllers.App.bottomSheet(
            dismissCallBack: dismissCallBack
        )
        bottomSheetVC.set(view: commonBottomSheetView)

        present(
            bottomSheetVC,
            animated: true,
            completion: completion
        )
    }

    func showSimpleSheet(
        title: String? = nil,
        body: String? = nil,
        dismissCallBack: VoidBlock? = nil,
        completion: VoidBlock? = nil
    ) {
        let commonBottomSheetView = CommonBottomSheetContentView()
        let action: BottomSheetAction = .init(
            title: Resources.Strings.Alert.ok,
            style: .default
        ) { [weak self] in
            self?.dismiss(animated: true) {
                dismissCallBack?()
            }
        }

        commonBottomSheetView.set(
            title: title,
            body: body,
            actions: [action]
        )

        let bottomSheetVC = Resources.ViewControllers.App.bottomSheet(
            dismissCallBack: dismissCallBack
        )
        bottomSheetVC.set(view: commonBottomSheetView)

        present(
            bottomSheetVC,
            animated: true,
            completion: completion
        )
    }

    func showErrorSheet(
        body: String? = nil,
        dismissCallBack: VoidBlock? = nil,
        completion: VoidBlock? = nil
    ) {
        let commonBottomSheetView = CommonBottomSheetContentView()
        let action: BottomSheetAction = .init(
            title: Resources.Strings.Alert.ok,
            style: .alert
        ) { [weak self] in
            self?.dismiss(animated: true)
        }

        commonBottomSheetView.set(
            title: Resources.Strings.Alert.error,
            body: body,
            actions: [action]
        )

        let bottomSheetVC = Resources.ViewControllers.App.bottomSheet(
            dismissCallBack: dismissCallBack
        )
        bottomSheetVC.set(view: commonBottomSheetView)

        present(
            bottomSheetVC,
            animated: true,
            completion: completion
        )
    }
}
