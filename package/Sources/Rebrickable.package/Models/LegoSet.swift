import Foundation

/// Represents a LEGO set as defined in the Rebrickable database.
///
/// This structure contains comprehensive information about a LEGO set,
/// including its identification, metadata, and associated resources.
public struct LegoSet: Codable, Hashable {
    /// The unique set number identifier.
    public let setNum: String
    /// The name of the set.
    public let name: String
    /// The year the set was released.
    public let year: Int?
    /// The ID of the theme this set belongs to.
    public let themeId: Int?
    /// The number of parts in the set.
    public let numParts: Int
    /// URL to the set's image.
    public let setImgUrl: URL?
    /// URL to the set's page on Rebrickable.
    public let setUrl: URL?
    /// Timestamp of when the set data was last modified.
    public let lastModifiedDt: String

    /// Initializes a new LegoSet.
    public init(
        setNum: String,
        name: String,
        year: Int?,
        themeId: Int?,
        numParts: Int,
        setImgUrl: URL?,
        setUrl: URL?,
        lastModifiedDt: String
    ) {
        self.setNum = setNum
        self.name = name
        self.year = year
        self.themeId = themeId
        self.numParts = numParts
        self.setImgUrl = setImgUrl
        self.setUrl = setUrl
        self.lastModifiedDt = lastModifiedDt
    }

    private enum CodingKeys: String, CodingKey {
        case setNum = "set_num"
        case name
        case year
        case themeId = "theme_id"
        case numParts = "num_parts"
        case setImgUrl = "set_img_url"
        case setUrl = "set_url"
        case lastModifiedDt = "last_modified_dt"
    }
}
