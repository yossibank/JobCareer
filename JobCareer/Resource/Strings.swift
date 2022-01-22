struct StringResource {

    struct Button {
        @Localizable static var signUpTitle = "signUp_button_title"
        @Localizable static var hereIsSignUpTitle = "here_is_sign_up"
        @Localizable static var loginTitle = "login_button_title"
        @Localizable static var nextTitle = "next_button_title"
        @Localizable static var backTitle = "back_button_title"
        @Localizable static var cancelButtonTitle = "cancel_button_title"
    }

    struct TextField {
        @Localizable static var emailPlaceholder = "email_textfield_placeholder"
        @Localizable static var passwordPlaceholder = "password_textfield_placeholder"
        @Localizable static var confirmPasswordPlaceholder = "confirm_password_textfield_placeholder"
    }

    struct Home {
        @Localizable static var home = "home"
        @Localizable static var news = "news"
        @Localizable static var contents = "contents"
    }

    struct Profile {
        @Localizable static var profile = "profile"
        @Localizable static var career = "career"
        @Localizable static var logout = "logout"
    }

    struct Navigation {

        struct Title {
            @Localizable static var signUp = "signUp"
            @Localizable static var login = "login"
            static var home = "HOME"
            static var profile = "PROFILE"
            static var first = "FIRST"
            static var firstDetail = "FIRST DETAIL"
            static var second = "SECOND"
            static var debug = "DEBUG"
        }
    }
}
