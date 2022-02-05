import Data

public struct EmptyMapper {

    func convert(response _: EmptyResponse) -> EmptyEntity {
        .init()
    }
}
