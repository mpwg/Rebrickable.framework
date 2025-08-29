import Foundation

/// Represents a paginated response from the Rebrickable API.
///
/// This generic structure is used to wrap collections of data returned by the API,
/// providing pagination information along with the actual results.
public struct PageResponse<T: Codable & Hashable>: Codable, Hashable {
    /// The total number of items available.
    public let count: Int
    /// URL for the next page of results, if available.
    public let next: URL?
    /// URL for the previous page of results, if available.
    public let previous: URL?
    /// The array of results for the current page.
    public let results: [T]

    /// Initializes a new PageResponse.
    public init(count: Int, next: URL?, previous: URL?, results: [T]) {
        self.count = count
        self.next = next
        self.previous = previous
        self.results = results
    }
}
