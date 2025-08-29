import Foundation

/// Represents a LEGO color as defined in the Rebrickable database.
///
/// This structure contains information about LEGO colors, including their ID,
/// name, and whether they are transparent colors.
public struct LegoColor: Codable, Hashable {
    /// The unique identifier for the color.
    public let id: Int
    /// The name of the color.
    public let name: String?
    /// Whether the color is transparent.
    public let isTrans: Bool

    /// Initializes a new LegoColor.
    public init(id: Int, name: String?, isTrans: Bool) {
        self.id = id
        self.name = name
        self.isTrans = isTrans
    }

    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case isTrans = "is_trans"
    }
}
