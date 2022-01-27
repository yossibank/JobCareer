import UIKit

extension Resources {

    static var ViewControllers: ViewController {
        ViewController()
    }

    struct ViewController {

        var App: AppControllers {
            AppControllers()
        }

        struct AppControllers {

            func signUp() -> SignUpViewController {
                let instance = SignUpViewController()
                instance.inject(viewModel: SignUpViewModel(), ui: SignUpUI())
                instance.title = Resources.Strings.Navigation.Title.signUp
                return instance
            }

            func login() -> LoginViewController {
                let instance = LoginViewController()
                instance.inject(ui: LoginUI())
                instance.title = Resources.Strings.Navigation.Title.login
                return instance
            }

            func home() -> HomeViewController {
                let instance = HomeViewController()
                instance.inject(ui: HomeUI())
                instance.title = Resources.Strings.Navigation.Title.home
                return instance
            }

            func profile() -> ProfileViewController {
                let instance = ProfileViewController()
                instance.inject(viewModel: ProfileViewModel(), ui: ProfileUI())
                instance.title = Resources.Strings.Navigation.Title.profile
                return instance
            }

            func first() -> FirstViewController {
                let instance = FirstViewController()
                instance.inject(viewModel: FirstViewModel(), ui: FirstUI())
                instance.title = Resources.Strings.Navigation.Title.first
                return instance
            }

            func firstDetail() -> FirstDetailViewController {
                let instance = FirstDetailViewController()
                instance.inject(ui: FirstDetailUI())
                instance.title = Resources.Strings.Navigation.Title.firstDetail
                return instance
            }

            func second() -> SecondViewController {
                let instance = SecondViewController()
                instance.inject(viewModel: SecondViewModel(), ui: SecondUI())
                instance.title = Resources.Strings.Navigation.Title.second
                return instance
            }

            func bottomSheet(dismissCallBack: VoidBlock? = nil) -> BottomSheetViewController {
                let instance = BottomSheetViewController(dismissCallBack: dismissCallBack)
                instance.inject(ui: BottomSheetUI())
                return instance
            }

            #if DEBUG

            func debug() -> DEBUG_ViewController {
                let instance = DEBUG_ViewController()
                instance.inject(ui: DEBUG_UI())
                instance.title = Resources.Strings.Navigation.Title.debug
                return instance
            }

            func debugBottomSheetList() -> DEBUG_BottomSheetListViewController {
                let instance = DEBUG_BottomSheetListViewController()
                instance.inject(ui: DEBUG_BottomSheetListUI())
                return instance
            }

            #endif
        }
    }
}
