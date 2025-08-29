import Combine
@testable import Rebrickable_package
import Swifter
import XCTest

class LegoAPITests: UnitTestCase {
    private let legoApi = LegoAPI(apiKey: TestConfig.testApiKey)
    private var bag = Set<AnyCancellable>()

    @MainActor func testGetLegoColors() throws {
        try getTest(
            mock: [LegoColor.mock()],
            endpoint: Endpoint.colors,
            publisher: legoApi.getColors()
        )
    }

    @MainActor func testGetLegoColorWithId() throws {
        try getTest(
            mock: LegoColor.mock(),
            endpoint: Endpoint.colors,
            publisher: legoApi.getColorDetails(with: 1)
        )
    }

    @MainActor func  testGetLegoElement() throws {
        try getTest(
            mock: LegoElement.mock(),
            endpoint: Endpoint.elements,
            publisher: legoApi.getElement(with: "6099483")
        )
    }

    @MainActor func  testGetLegoMinifigures() throws {
        try getTest(
            mock: [LegoSet.mock()],
            endpoint: Endpoint.minifigs,
            publisher: legoApi.getMinifigures()
        )
    }

    @MainActor func  testGetLegoMinifigureWithSetNum() throws {
        try getTest(
            mock: LegoSet.mock(),
            endpoint: Endpoint.minifigs,
            publisher: legoApi.getMinifigureDetails(figNum: "fig-000001")
        )
    }

    @MainActor func  testGetLegoMinifigureParts() throws {
        try getTest(
            mock: [LegoInventoryPart.mock()],
            endpoint: Endpoint.parts,
            publisher: legoApi.getMinifigureParts(figNum: "fig-000001")
        )
    }

    @MainActor func  testGetLegoMinifigureSets() throws {
        try getTest(
            mock: [LegoSet.mock()],
            endpoint: Endpoint.sets,
            publisher: legoApi.getSets(figNum: "fig-000001")
        )
    }

    @MainActor func  testGetLegoPartCategories() throws {
        try getTest(
            mock: [LegoPartCategory.mock()],
            endpoint: Endpoint.elements,
            publisher: legoApi.getPartCategories()
        )
    }

    @MainActor func  testGetLegoPartCategoriesWithId() throws {
        try getTest(
            mock: LegoPartCategory.mock(),
            endpoint: Endpoint.elements,
            publisher: legoApi.getPartCategoryDetails(with: 49)
        )
    }

    @MainActor func  testGetLegoParts() throws {
        try getTest(
            mock: [LegoPart.mock()],
            endpoint: Endpoint.parts,
            publisher: legoApi.getParts()
        )
    }

    @MainActor func  testGetLegoPartWithId() throws {
        try getTest(
            mock: LegoPart.mock(),
            endpoint: Endpoint.parts,
            publisher: legoApi.getPartDetails(with: "39381")
        )
    }

    @MainActor func  testGetLegoPartColorsWithPartNum() throws {
        try getTest(
            mock: [LegoPartColor.mock()],
            endpoint: Endpoint.colors,
            publisher: legoApi.getPartColors(partNum: "003381")
        )
    }

    @MainActor func  testGetLegoPartsWitPartAndColor() throws {
        try getTest(
            mock: [LegoSet.mock()],
            endpoint: Endpoint.sets,
            publisher: legoApi.getSets(partNum: "003381", colorID: "9999")
        )
    }

    @MainActor func  testGetLegoSets() throws {
        try getTest(
            mock: [LegoSet.mock()],
            endpoint: Endpoint.sets,
            publisher: legoApi.getSets()
        )
    }

    @MainActor func  testGetLegoSet() throws {
        try getTest(
            mock: LegoSet.mock(),
            endpoint: Endpoint.sets,
            publisher: legoApi.getSetDetails(with: "0011-2")
        )
    }

    @MainActor func  testGetLegoInventoryMinifigsWithSetNum() throws {
        try getTest(
            mock: [LegoInventorySet.mock()],
            endpoint: Endpoint.minifigs,
            publisher: legoApi.getInventoryMinifigs(setNum: "0011-2")
        )
    }

    @MainActor func  testGetLegoInventoryPartsWithSetNum() throws {
        try getTest(
            mock: [LegoInventoryPart.mock()],
            endpoint: Endpoint.parts,
            publisher: legoApi.getInventoryParts(setNum: "76139-1")
        )
    }

    @MainActor func  testGetLegoThemes() throws {
        try getTest(
            mock: [LegoTheme.mock()],
            endpoint: Endpoint.themes,
            publisher: legoApi.getThemes()
        )
    }

    @MainActor func  testGetLegoThemeWithId() throws {
        try getTest(
            mock: LegoTheme.mock(),
            endpoint: Endpoint.themes,
            publisher: legoApi.getTheme(with: 1)
        )
    }
}

extension LegoAPITests {
    @MainActor func getTest<T: Codable>(mock: T, endpoint: String, publisher: AnyPublisher<T, LegoError>) throws {
        let exp1 = expectation(description: "receiveCompletion")
        let exp2 = expectation(description: "receiveValue")

        try httpServerBuilder
            .route(endpoint) { request, callCount -> (HttpResponse) in
                XCTAssertEqual(request.method, APIManager.HttpMethod.get.rawValue)
                XCTAssertEqual(callCount, 1)
                return HttpResponse.encode(value: mock)
            }
            .buildAndStart()

        publisher
            .sink(
                receiveCompletion: { _ in exp1.fulfill() },
                receiveValue: { _ in exp2.fulfill() }
            )
            .store(in: &bag)

        waitForExpectations(timeout: 3) { error in
            print("Error:\(String(describing: error))")
        }
    }
}
