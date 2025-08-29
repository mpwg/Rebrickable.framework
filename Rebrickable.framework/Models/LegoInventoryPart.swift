import Foundation

public struct LegoInventoryPart: Hashable, Codable {
    public let id: Int
    public let invPartId: Int
    public let part: LegoPart
    public let color: LegoColor
    public let setNum: String
    public let quantity: Int
    public let isSpare: Bool
    public let elementId: String?
    public let numSets: Int

    public init(
    id: Int,
    invPartId: Int,
    part: LegoPart,
    color: LegoColor,
    setNum: String,
    quantity: Int,
    isSpare: Bool,
    elementId: String?,
    numSets: Int
    ) {
        self.id = id
        self.invPartId = invPartId
        self.part = part
        self.color = color
        self.setNum = setNum
        self.quantity = quantity
        self.isSpare = isSpare
        self.elementId = elementId
        self.numSets = numSets
    }

    private enum CodingKeys: String, CodingKey {
        case id
        case invPartId = "inv_part_id"
        case part
        case color
        case setNum = "set_num"
        case quantity
        case isSpare = "is_spare"
        case elementId = "element_id"
        case numSets = "num_sets"
    }
}
