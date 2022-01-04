#if DEBUG

enum DEBUG_Section: String, CaseIterable {
    case component
    case viewController

    var initialItems: [DEBUG_Item] {
        switch self {
            case .component:
                return [.bottomSheetContent]

            case .viewController:
                return [.home, .first, .firstDetail, .second]
        }
    }
}

enum DEBUG_Item: String, Hashable {

    /* Component */
    case bottomSheetContent

    /* ViewController */
    case home
    case first
    case firstDetail
    case second
}

#endif
