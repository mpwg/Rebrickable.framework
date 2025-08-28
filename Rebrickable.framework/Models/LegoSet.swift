import Foundation

/// Represents a LEGO set as defined in the Rebrickable database.
///
/// This structure contains comprehensive information about a LEGO set,
/// including its identification, metadata, and associated resources.
public struct LegoSet: Codable, Hashable {
    /// The unique set number identifier.
    public let set_num: String
    /// The name of the set.
    public let name: String
    /// The year the set was released.
    public let year: Int?
    /// The ID of the theme this set belongs to.
    public let theme_id: Int?
    /// The number of parts in the set.
    public let num_parts: Int
    /// URL to the set's image.
    public let set_img_url: URL?
    /// URL to the set's page on Rebrickable.
    public let set_url: URL?
    /// Timestamp of when the set data was last modified.
    public let last_modified_dt: String

    /// Initializes a new LegoSet.
    public init(
        set_num: String,
        name: String,
        year: Int?,
        theme_id: Int?,
        num_parts: Int,
        set_img_url: URL?,
        set_url: URL?,
        last_modified_dt: String
    ) {
        self.set_num = set_num
        self.name = name
        self.year = year
        self.theme_id = theme_id
        self.num_parts = num_parts
        self.set_img_url = set_img_url
        self.set_url = set_url
        self.last_modified_dt = last_modified_dt
    }
}
