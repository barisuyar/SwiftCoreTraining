import UIKit

extension Sequence {
    public func barisMap<Item> ( _ transform: (Element) throws -> Item) rethrows -> [Item] {
        var result = [Item]()
        
        try self.forEach {
            result.append(try transform($0))
        }
        return result
    }
}

extension Sequence {
    public func barisContains(where predicate: (Element) throws -> Bool) rethrows -> Bool {
        for e in self {
            if try predicate(e) {
                return true
            }
        }
        return false
    }
}

extension Sequence {
    public func barisContains2<Item: Equatable>(_ item: Item) -> Bool where Element == Item {
        for e in self {
            if e == item {
                return true
            }
        }
        return false
    }
}

let array = [1,2,3,4,5]

print(array.barisMap { $0 * 2 })

print(array.barisContains(where: { 6 == $0 }))
