import Combine
import Foundation

/// A client for accessing the Rebrickable API to retrieve LEGO-related data.
///
/// This class provides methods to fetch information about LEGO colors, parts, sets, themes, and other data
/// from the Rebrickable database. All methods return Combine publishers for asynchronous data retrieval.
public final class LegoAPI {
    /// The API manager responsible for handling HTTP requests.
    private var apiManager: APIManager

    /// Initializes a new LegoAPI client with the provided API key.
    /// - Parameter apiKey: The API key for authenticating with the Rebrickable API.
    public init(apiKey: String) {
        apiManager = APIManager(apiKey: apiKey)
    }

    /// Fetches a list of LEGO colors.
    ///
    /// - Parameters:
    ///   - page: The page number for pagination (optional).
    ///   - pageSize: The number of items per page (optional).
    /// - Returns: A publisher that emits an array of LegoColor objects or a LegoError.
    public func getColors(page: Int? = nil, pageSize: Int? = nil) -> AnyPublisher<[LegoColor], LegoError> {
        apiManager.getResults(with: Endpoint.colors(page: page, pageSize: pageSize))
    }

    /// Fetches details for a specific LEGO color.
    ///
    /// - Parameter id: The unique identifier of the color.
    /// - Returns: A publisher that emits a LegoColor object or a LegoError.
    public func getColorDetails(with id: Int) -> AnyPublisher<LegoColor, LegoError> {
        apiManager.getItem(with: Endpoint.color(with: id))
    }

    public func getElement(with id: String) -> AnyPublisher<LegoElement, LegoError> {
        apiManager.getItem(with: Endpoint.element(with: id))
    }

    public func getMinifigures(
        inSetNum: String? = nil,
        inThemeId: String? = nil,
        page: Int? = nil,
        pageSize: Int? = nil
    )
        -> AnyPublisher<[LegoSet], LegoError> {
        apiManager.getResults(with: Endpoint.minifigs(
            inSetNum: inSetNum,
            inThemeId: inThemeId,
            page: page,
            pageSize: pageSize
        ))
    }

    public func getMinifigureDetails(figNum: String) -> AnyPublisher<LegoSet, LegoError> {
        apiManager.getItem(with: Endpoint.minifig(with: figNum))
    }

    public func getMinifigureParts(
        figNum: String,
        page: Int? = nil,
        pageSize: Int? = nil
    )
        -> AnyPublisher<[LegoInventoryPart], LegoError> {
        apiManager.getResults(with: Endpoint.minifigParts(figNum: figNum, page: page, pageSize: pageSize))
    }

    public func getSets(figNum: String, page: Int? = nil, pageSize: Int? = nil) -> AnyPublisher<[LegoSet], LegoError> {
        apiManager.getResults(with: Endpoint.minifigSets(figNum: figNum, page: page, pageSize: pageSize))
    }

    public func getPartCategories(
        page: Int? = nil,
        pageSize: Int? = nil
    )
        -> AnyPublisher<[LegoPartCategory], LegoError> {
        apiManager.getResults(with: Endpoint.partCategories(page: page, pageSize: pageSize))
    }

    public func getPartCategoryDetails(with id: Int) -> AnyPublisher<LegoPartCategory, LegoError> {
        apiManager.getItem(with: Endpoint.partCategory(with: id))
    }

    public func getParts() -> AnyPublisher<[LegoPart], LegoError> {
        apiManager.getResults(with: Endpoint.partsUrl)
    }

    public func getPartDetails(with id: String) -> AnyPublisher<LegoPart, LegoError> {
        apiManager.getItem(with: Endpoint.part(with: id))
    }

    public func getPartColors(
        partNum: String,
        page: Int? = nil,
        pageSize: Int? = nil
    )
        -> AnyPublisher<[LegoPartColor], LegoError> {
        apiManager.getResults(with: Endpoint.partColors(partNum: partNum, page: page, pageSize: pageSize))
    }

    public func getSets(
        partNum: String,
        colorID: String,
        page: Int? = nil,
        pageSize: Int? = nil
    )
        -> AnyPublisher<[LegoSet], LegoError> {
        apiManager.getResults(with: Endpoint.set(partNum: partNum, colorId: colorID, page: page, pageSize: pageSize))
    }

    public func getSets(
        themeId: String? = nil,
        page: Int? = nil,
        pageSize: Int? = nil
    )
        -> AnyPublisher<[LegoSet], LegoError> {
        apiManager.getResults(with: Endpoint.sets(themeId: themeId, page: page, pageSize: pageSize))
    }

    public func getSetDetails(with setNum: String) -> AnyPublisher<LegoSet, LegoError> {
        apiManager.getItem(with: Endpoint.set(setNum: setNum))
    }

    public func getInventoryMinifigs(
        setNum: String,
        page: Int? = nil,
        pageSize: Int? = nil
    )
        -> AnyPublisher<[LegoInventorySet], LegoError> {
        apiManager.getResults(with: Endpoint.inventoryMinifigs(setNum: setNum, page: page, pageSize: pageSize))
    }

    public func getInventoryParts(
        setNum: String,
        page: Int? = nil,
        pageSize: Int? = nil
    )
        -> AnyPublisher<[LegoInventoryPart], LegoError> {
        apiManager.getResults(with: Endpoint.inventoryParts(setNum: setNum, page: page, pageSize: pageSize))
    }

    public func getThemes(page: Int? = nil, pageSize: Int? = nil) -> AnyPublisher<[LegoTheme], LegoError> {
        apiManager.getResults(with: Endpoint.themes(page: page, pageSize: pageSize))
    }

    public func getTheme(with id: Int) -> AnyPublisher<LegoTheme, LegoError> {
        apiManager.getItem(with: Endpoint.theme(with: id))
    }
}
