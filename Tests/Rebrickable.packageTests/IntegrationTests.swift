import Combine
import XCTest

@testable import Rebrickable_package

final class IntegrationTests: XCTestCase {
    var cancellables = Set<AnyCancellable>()

    func testGetColors_liveIfApiKeyPresent() throws {
        // Requirement checklist:
        // - Use live server: Done (Endpoint.colors)
        // - Read API key from environment variable REBRICKABLE_API_KEY: Done
        // - Skip test when env var missing to avoid CI failures: Done

        guard let apiKey = ProcessInfo.processInfo.environment["REBRICKABLE_API_KEY"],
            !apiKey.isEmpty
        else {
            throw XCTSkip("Skipping live integration test because REBRICKABLE_API_KEY is not set")
        }

        let api = LegoAPI(apiKey: apiKey)
        let exp = expectation(description: "getColors from live server")

        var received: [Any]? = nil
        api.getColors(page: 1, pageSize: 10)
            .sink { completion in
                if case .failure(let err) = completion {
                    XCTFail("API call failed: \(err)")
                    exp.fulfill()
                }
            } receiveValue: { (colors: [LegoColor]) in
                received = colors
                exp.fulfill()
            }
            .store(in: &cancellables)

        wait(for: [exp], timeout: 10)

        XCTAssertNotNil(received, "Expected to receive colors from live API")
        if let colors = received as? [LegoColor] {
            XCTAssertFalse(colors.isEmpty, "Expected non-empty colors list from live API")
        }
    }
}
