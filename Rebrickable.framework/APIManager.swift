import Combine
import Foundation

/// A manager for handling HTTP requests to the Rebrickable API.
///
/// This class provides methods for making authenticated requests to the Rebrickable API endpoints.
/// It handles request configuration, authentication headers, and response processing.
final class APIManager {
    /// The API key used for authentication with the Rebrickable API.
    private let apiKey: String

    /// Initializes a new APIManager with the provided API key.
    /// - Parameter apiKey: The API key for authenticating with the Rebrickable API.
    init(apiKey: String) {
        self.apiKey = apiKey
    }

    /// Creates and executes an HTTP request to the specified URL.
    ///
    /// - Parameters:
    ///   - url: The URL to send the request to.
    ///   - parameters: Optional HTTP body parameters as key-value pairs.
    ///   - httpMethod: The HTTP method to use for the request.
    /// - Returns: A publisher that emits the data task result or an error.
    func makeRequest(
        to url: URL,
        httpBody parameters: [String: String] = [:],
        withHttpMethod httpMethod: HttpMethod
    )
        -> URLSession.DataTaskPublisher
    {
        let urlRequest = prepareRequest(with: url, parameters: parameters, httpMethod: httpMethod)
        return URLSession.shared.dataTaskPublisher(for: urlRequest)
    }

    private func prepareRequest(with url: URL, parameters: [String: String], httpMethod: HttpMethod) -> URLRequest {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = httpMethod.rawValue
        urlRequest.setValue("application/json", forHTTPHeaderField: "Accept")
        urlRequest.setValue("key \(apiKey)", forHTTPHeaderField: "Authorization")
        urlRequest.httpBody = getHttpBody(with: parameters)
        return urlRequest
    }

    private func getHttpBody(with parameters: [String: String]) -> Data? {
        guard !parameters.isEmpty else { return nil }
        return try? JSONSerialization.data(withJSONObject: parameters, options: [.prettyPrinted, .sortedKeys])
    }
}

extension APIManager {
    /// Fetches a single item from the API and decodes it to the specified type.
    ///
    /// - Parameter url: The URL to fetch the item from.
    /// - Returns: A publisher that emits the decoded item or a LegoError.
    func getItem<T: Codable>(with url: URL) -> AnyPublisher<T, LegoError> {
        makeRequest(to: url, withHttpMethod: .get)
            .map(\.data)
            .decode(type: T.self, decoder: JSONDecoder())
            .mapToLegoError()
            .eraseToAnyPublisher()
    }

    /// Fetches a paginated list of results from the API.
    ///
    /// - Parameter url: The URL to fetch the results from.
    /// - Returns: A publisher that emits an array of decoded results or a LegoError.
    func getResults<T: Codable & Hashable>(with url: URL) -> AnyPublisher<[T], LegoError> {
        let pageResponse: AnyPublisher<PageResponse<T>, LegoError> = getItem(with: url)
        return pageResponse
            .map(\.results)
            .eraseToAnyPublisher()
    }

    /// Makes a generic request and decodes the response to the specified type.
    ///
    /// - Parameters:
    ///   - url: The URL to send the request to.
    ///   - parameters: Optional HTTP body parameters as key-value pairs.
    ///   - httpMethod: The HTTP method to use for the request.
    /// - Returns: A publisher that emits the decoded response or a LegoError.
    func request<T: Codable & Hashable>(
        to url: URL,
        httpBody parameters: [String: String] = [:],
        withHttpMethod httpMethod: HttpMethod
    )
        -> AnyPublisher<T, LegoError>
    {
        makeRequest(to: url, httpBody: parameters, withHttpMethod: httpMethod)
            .map(\.data)
            .decode(type: T.self, decoder: JSONDecoder())
            .mapToLegoError()
            .eraseToAnyPublisher()
    }
}

extension APIManager {
    /// HTTP methods supported by the API manager.
    enum HttpMethod: String {
        case get = "GET"
        case post = "POST"
        case put = "PUT"
        case patch = "PATCH"
        case delete = "DELETE"
    }
}
