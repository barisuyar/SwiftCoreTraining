import UIKit

extension Sequence {
    
    var count: Int { return reduce(0) { acc, row in acc + 1 } }
    
    var first: Element? {
        var element: Element?
        
        for item in self {
            element = item
            break
        }
        return element }
    
    public func barisMap<Item> ( _ transform: (Element) throws -> Item) rethrows -> [Item] {
        var result = [Item]()
        
        try forEach {
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
        
        try forEach { item in
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
    
    public func barisFirst(where predicate: (Element) throws -> Bool) rethrows -> Element? {
        var element: Element?
        
        for item in self {
            if try predicate(item) {
                element = item
                break
            }
        }
        
        return element
    }
    
    public func barisLast(where predicate: (Element) throws -> Bool) rethrows -> Element? {
        var element: Element?
        if let reversedArray = self.barisReversed() {
            for item in reversedArray {
                if try predicate(item) {
                    element = item
                    break
                }
                
            }
        }
        return element
    }
    
    public func barisEnumarated() -> [(Int, Element)]? {
        if self.count < 1 {
            return nil
        }
        
        var i = 0
        var enumaratedArray = [(Int, Element)]()
        for item in self {
            enumaratedArray.append((i, item))
            i = i + 1
        }
        return enumaratedArray
    }
    
    public func barisCompactMap<ResultElement>(_ transform: (Element) throws -> ResultElement?) rethrows -> [ResultElement] {
        var array = [ResultElement]()
        
        for item in self {
            if let a = try transform(item) {
                array.append(a)
            }
        }
        
        return array
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

var intArray = [1,2,3,0,5,17,7,8,9,10,4]

var schoolArray2: [School]?

let possibleNumbers = ["1", "2", "three", "///4///", "5"]

print(possibleNumbers.barisCompactMap( { str in Int(str) } ))
print(possibleNumbers.compactMap({ str in Int(str) } ))
