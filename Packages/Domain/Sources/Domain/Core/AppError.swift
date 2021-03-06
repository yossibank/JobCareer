import Data

public struct AppError: Error, Equatable {
    private let error: APIError

    public var errorMessage: String? {
        error.errorDescription
    }

    public init(error: APIError) {
        self.error = error
    }
}
