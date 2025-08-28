import Foundation
import Combine

/// Errors that can occur when interacting with the Rebrickable API.
public enum LegoError: Error {
    /// Failed to decode the response data.
    case decode
    /// The request format was incorrect.
    case formatRequestWrong
    /// The provided API key is invalid.
    case invalidApiKey
    /// Access to the requested item is forbidden.
    case notItemAccess
    /// The requested item was not found.
    case itemNotFound
    /// The request was throttled due to rate limiting.
    case throttledRequest
    /// A generic error occurred.
    case generic(Error)

    /// A human-readable error message.
    var message: String {
        switch self {
            case .decode: return ""
            case .formatRequestWrong : return "Something was wrong with the format of your request"
            case .invalidApiKey : return "Unauthorized - your API key is invalid"
            case .notItemAccess: return "Forbidden - you do not have access to operate on the requested item(s)"
            case .itemNotFound : return "Item not found"
            case .throttledRequest : return "Request was throttled. Expected available in 2 seconds."
            case .generic(let error): return error.localizedDescription
        }
    }
}

extension Publisher {
    func mapToLegoError() -> Publishers.MapError<Self, LegoError> {
        mapError { error -> LegoError in
            switch error {
                case is DecodingError: return LegoError.decode
                case is URLError: return error.toLegoError
                default: return .generic(error)
            }
        }
    }
}

fileprivate extension Error {
    var toLegoError: LegoError {
        guard let errorCode = (self as? URLError)?.errorCode else { return .generic(self) }
        switch errorCode {
            case 400: return .formatRequestWrong
            case 401: return .invalidApiKey
            case 403: return .notItemAccess
            case 404: return .itemNotFound
            case 429: return .throttledRequest
            default: return .generic(self)
        }
    }
}
