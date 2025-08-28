import Combine
import Swifter
import XCTest
@testable import Rebrickable_framework

class LegoAPIErrorTests: UnitTestCase {
    private let legoApi = LegoAPI(apiKey: TestConfig.testApiKey)
    private var cancellable: AnyCancellable?

    func testGetLegoColorsError() throws {
        // GIVEN
        try httpServerBuilder

            .route("/colors") { request, callCount -> (HttpResponse) in
                XCTAssertEqual(request.method, APIManager.HttpMethod.get.rawValue)
                XCTAssertEqual(callCount, 1)
                let errorBody = ErrorBody(
                    code: "error qualcosa",
                    details: [ErrorBody.ErrorDetail(id: "qualcosa id", description: "")]
                )
                return HttpResponse.encode(errorBody, statusCode: 429)
            }
            .buildAndStart()
        // WHEN
        cancellable = legoApi.getColors()
            // THEN
            .print()
            .sink(
                receiveCompletion: { print($0) },
                receiveValue: { print($0) }
            )
    }
}

public struct ErrorBody: Codable {
    public struct ErrorDetail: Codable {
        public let id: String
        public let description: String
    }

    public let code: String
    public let details: [ErrorDetail]?
}
