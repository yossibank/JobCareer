#if DEBUG

enum DEBUG_Section: String, CaseIterable {
    case component
    case viewController
}

enum DEBUG_Item: Hashable {
    case component(DEBUG_Component)
    case controller(DEBUG_Controller)
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
