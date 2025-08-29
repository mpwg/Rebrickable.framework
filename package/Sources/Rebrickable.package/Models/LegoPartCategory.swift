import Foundation

public struct LegoPartCategory: Codable, Hashable {
    public let id: Int
    public let name: String
    public let partCount: Int

    public init(id: Int, name: String, partCount: Int) {
        self.id = id
        self.name = name
        self.partCount = partCount
    }

    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case partCount = "part_count"
    }
}
