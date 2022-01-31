import Data

public struct AppError: Error, Equatable {

    public var errorMessage: String? {
        error.errorDescription
    }

    private let error: APIError

    public init(error: APIError) {
        self.error = error
    }
}
