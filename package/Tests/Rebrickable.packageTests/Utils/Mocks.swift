import Foundation
@testable import Rebrickable_package

extension Int {
    static func mock() -> Int {
        Int.random(in: 0 ... 100)
    }
}

extension Bool {
    static func mock() -> Bool {
        Bool.random()
    }
}

extension URL {
    static func mock(string: String = String.mock()) -> URL {
        URL(string: string)!
    }
}

extension String {
    static func mock() -> String {
        UUID().uuidString
    }
}

extension LegoColor {
    static func mock() -> LegoColor {
        LegoColor(
            id: Int.mock(),
            name: String.mock(),
            isTrans: Bool.mock()
        )
    }
}

extension LegoElement {
    static func mock() -> LegoElement {
        LegoElement(
            part: LegoPart.mock(),
            color: LegoColor.mock(),
            elementId: String.mock(),
            designId: String.mock(),
            elementImgUrl: URL.mock(),
            partImgUrl: URL.mock()
        )
    }
}

extension LegoSet {
    static func mock() -> LegoSet {
        LegoSet(
            setNum: String.mock(),
            name: String.mock(),
            year: Int.mock(),
            themeId: Int.mock(),
            numParts: Int.mock(),
            setImgUrl: URL.mock(),
            setUrl: URL.mock(),
            lastModifiedDt: String.mock()
        )
    }
}

extension LegoPartCategory {
    static func mock() -> LegoPartCategory {
        LegoPartCategory(
            id: Int.mock(),
            name: String.mock(),
            partCount: Int.mock()
        )
    }
}

extension LegoPart {
    static func mock() -> LegoPart {
        LegoPart(
            partNum: String.mock(),
            name: String.mock(),
            partCatId: Int.mock(),
            partUrl: URL.mock(),
            partImgUrl: URL.mock(),
            externalIds: [:],
            printOf: String.mock()
        )
    }
}

extension LegoPartColor {
    static func mock() -> LegoPartColor {
        LegoPartColor(
            colorId: Int.mock(),
            colorName: String.mock(),
            numSets: Int.mock(),
            numSetParts: Int.mock(),
            partImgUrl: URL.mock()
        )
    }
}

extension LegoInventoryPart {
    static func mock() -> LegoInventoryPart {
        LegoInventoryPart(
            id: Int.mock(),
            invPartId: Int.mock(),
            part: LegoPart.mock(),
            color: LegoColor.mock(),
            setNum: String.mock(),
            quantity: Int.mock(),
            isSpare: Bool.mock(),
            elementId: String.mock(),
            numSets: Int.mock()
        )
    }
}

extension LegoInventorySet {
    static func mock() -> LegoInventorySet {
        LegoInventorySet(
            id: Int.mock(),
            setNum: String.mock(),
            setName: String.mock(),
            quantity: Int.mock(),
            setImgUrl: URL.mock()
        )
    }
}

extension LegoTheme {
    static func mock() -> LegoTheme {
        LegoTheme(
            id: Int.mock(),
            parentId: Int.mock(),
            name: String.mock()
        )
    }
}
