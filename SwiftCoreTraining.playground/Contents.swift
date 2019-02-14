import UIKit

extension Sequence {
    
    var count: Int { return reduce(0) { acc, row in acc + 1 } }
    
    var first: Element? {
        var element: Element?
        self.forEach { element = $0
            return
        }
        return element }
    
    public func barisMap<Item> ( _ transform: (Element) throws -> Item) rethrows -> [Item] {
        var result = [Item]()
        
        try self.forEach {
            result.append(try transform($0))
        }
        return result
    }
    
    public func barisContains(where predicate: (Element) throws -> Bool) rethrows -> Bool {
        for e in self {
            if try predicate(e) {
                return true
            }
        }
        return false
    }
    
    public func barisContains2<Item: Equatable>(_ item: Item) -> Bool where Element == Item {
        for e in self {
            if e == item {
                return true
            }
        }
        return false
    }
    
    public func barisFilter<Item> (where predicate: (Element) throws -> Bool) rethrows -> [Item] where Self.Element == Item {
        var result = [Item]()
        
        try self.forEach { item in
            if try predicate(item) {
                result.append(item)
            }
        }
        return result
    }
    
    public func barisReduce<Item> (item: Item, where transform: (Item, Element) throws -> (Item)) rethrows -> Item where Element == Item {
        var item = item
        try forEach {
            item = try transform(item, $0)
        }
        return item
    }
    
    public func barisReversed() -> [Element]? {
        
        if count < 1 {
            return nil
        }
        var result = [Element]()

        for e in self {
            result.insert(e, at: 0)
        }
        return result
    }
}

extension Sequence where Element: Comparable {
    public func barisMin() -> Element? {
        
        if var min = first {
            for e in self {
                if e < min {
                    min = e
                }
            }
            return min
        } else {
            return nil
        }
    }
    
    public func barisMax() -> Element? {
        
        if var max = first {
            for e in self {
                if e > max {
                    max = e
                }
            }
            return max
        } else {
            return nil
        }
    }
}


struct School {
    var name: String?
    var code: Int!
}

extension School: Comparable {
    static func < (lhs: School, rhs: School) -> Bool {
        return lhs.code < rhs.code
    }
}

var schoolArray = [School(name: "Anaokulu", code: 0), School(name: "İlkokul", code: 1), School(name: "Ortaokul", code: 2), School(name: "Lise", code: 3), School(name: "Üniversite", code: 4)]

var intArray = [1,2,3,4,5,6]

var schoolArray2: [School]?
print(schoolArray.barisMax() ?? School())

print(intArray.barisReduce(item: 0, where: { a, b in
    a + b
}))


print([Int]().barisReversed())
