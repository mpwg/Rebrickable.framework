import Foundation

public struct LegoElement: Codable, Hashable {
    public let part: LegoPart
    public let color: LegoColor
    public let elementId: String
    public let designId: String
    public let elementImgUrl: URL?
    public let partImgUrl: URL?

    public init(
        part: LegoPart,
        color: LegoColor,
        elementId: String,
        designId: String,
        elementImgUrl: URL?,
        partImgUrl: URL?
    ) {
        self.part = part
        self.color = color
        self.elementId = elementId
        self.designId = designId
        self.elementImgUrl = elementImgUrl
        self.partImgUrl = partImgUrl
    }

    private enum CodingKeys: String, CodingKey {
        case part
        case color
        case elementId = "element_id"
        case designId = "design_id"
        case elementImgUrl = "element_img_url"
        case partImgUrl = "part_img_url"
    }
}
