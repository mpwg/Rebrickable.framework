import Foundation

public struct LegoInventorySet: Hashable, Codable {
    public let id: Int
    public let setNum: String
    public let setName: String
    public let quantity: Int
    public let setImgUrl: URL?

    public init(id: Int, setNum: String, setName: String, quantity: Int, setImgUrl: URL?) {
        self.id = id
        self.setNum = setNum
        self.setName = setName
        self.quantity = quantity
        self.setImgUrl = setImgUrl
    }

    private enum CodingKeys: String, CodingKey {
        case id
        case setNum = "set_num"
        case setName = "set_name"
        case quantity
        case setImgUrl = "set_img_url"
    }
}
