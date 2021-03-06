#if DEBUG

enum DEBUG_Section: String, CaseIterable {
    case development
    case component
    case viewController

    var items: [DEBUG_Item] {
        switch self {
            case .development:
                return DEBUG_Development.allCases.map { $0.component }

            case .component:
                return DEBUG_Component.allCases.map { $0.component }

            case .viewController:
                return DEBUG_Controller.allCases.map { $0.component }
        }
    }
}

enum DEBUG_Item: Hashable {
    case development(DEBUG_Development)
    case component(DEBUG_Component)
    case controller(DEBUG_Controller)
}

enum DEBUG_Development: String, CaseIterable, Hashable {
    case theme
    case profile

    var component: DEBUG_Item {
        switch self {
            case .theme:
                return .development(.theme)

            case .profile:
                return .development(.profile)
        }
    }
}

enum DEBUG_Component: String, CaseIterable, Hashable {
    case bottomSheetContent

    var component: DEBUG_Item {
        .component(.bottomSheetContent)
    }
}

enum DEBUG_Controller: String, CaseIterable, Hashable {
    case home
    case profile
    case first
    case firstDetail
    case second

    var component: DEBUG_Item {
        switch self {
            case .home:
                return .controller(.home)

            case .profile:
                return .controller(.profile)

            case .first:
                return .controller(.first)

            case .firstDetail:
                return .controller(.firstDetail)

            case .second:
                return .controller(.second)
        }
    }
}

#endif
