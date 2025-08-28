import Foundation
import Combine

/// A client for accessing user-specific data from the Rebrickable API.
///
/// This class provides methods to authenticate users and access their personal LEGO data,
/// including parts collections, builds, and lost parts tracking.
public final class UsersAPI {
    /// The API manager responsible for handling HTTP requests.
    private var apiManager: APIManager
    /// The user's authentication token for accessing personal data.
    private var userToken: String?
    /// Storage for Combine cancellables.
    private var bag = Set<AnyCancellable>()

    /// Initializes a new UsersAPI client with the provided API key.
    /// - Parameter apiKey: The API key for authenticating with the Rebrickable API.
    public init(apiKey: String) {
        apiManager = APIManager(apiKey: apiKey)
    }

    public func userAuthentication(username: String, password: String) {
        let httpBodyParameters = ["username": username, "password": password]
        apiManager.makeRequest(to: Endpoint.tokenUrl, httpBody: httpBodyParameters, withHttpMethod: .post)
            .map { $0.data }
            .decode(type: String.self, decoder: JSONDecoder())
            .mapToLegoError()
            .sink(receiveCompletion: { _ in },
                  receiveValue: { self.userToken = $0 })
            .store(in: &bag)
    }

    public func userAuthentication2(username: String, password: String) {
        let httpBodyParameters = ["username": username, "password": password]
        let response: AnyPublisher<String, LegoError> = apiManager.request(to: Endpoint.tokenUrl, httpBody: httpBodyParameters, withHttpMethod: .post)
        response
            .assertNoFailure()
            .receive(on: RunLoop.main)
            .sink { [unowned self] in self.userToken = $0 }
            .store(in: &bag)
    }

    public func getAllParts(page: Int? = nil, pageSize: Int? = nil) -> AnyPublisher<[LegoUserPart], LegoError> {
        apiManager.getResults(with: Endpoint.allParts(token: userToken ?? "", page: page, pageSize: pageSize))
    }

    public func getBuild(setNum: String) -> AnyPublisher<LegoBuild, LegoError> {
        apiManager.getItem(with: Endpoint.build(token: userToken ?? "", setNum: setNum))
    }

    public func getLostParts(page: Int? = nil, pageSize: Int? = nil) -> AnyPublisher<[LegoLostPart], LegoError> {
        apiManager.getResults(with: Endpoint.lostParts(token: userToken ?? "", page: page, pageSize: pageSize))
    }
}
