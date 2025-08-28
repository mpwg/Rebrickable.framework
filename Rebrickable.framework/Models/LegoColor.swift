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
    public let is_trans: Bool

    /// Initializes a new LegoColor.
    public init(id: Int, name: String?, is_trans: Bool) {
        self.id = id
        self.name = name
        self.is_trans = is_trans
    }
}
