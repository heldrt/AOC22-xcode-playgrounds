import Foundation

//gross but fast way to turn single char string to Int
public extension String {
    func valDay3() -> Int {
        var returnVal = Int(Character(self).asciiValue!)
        if returnVal >= 97 {
            returnVal -= 70 + 26
        } else {
            returnVal -= 64 - 26
        }
        return returnVal
    }

    static func + (l: String, r: Character) -> String {
        return String(l).appending(String(r))
    }
    static func + (l: Character, r: String) -> String {
        return String(l).appending(String(r))
    }
}

public extension StringProtocol {
    subscript(_ offset: Int) -> Element { self[index(startIndex, offsetBy: offset)] }
    subscript(_ range: Range<Int>) -> SubSequence { prefix(range.lowerBound + range.count).suffix(range.count) }
    subscript(_ range: ClosedRange<Int>) -> SubSequence { prefix(range.lowerBound + range.count).suffix(range.count) }
    subscript(_ range: PartialRangeThrough<Int>) -> SubSequence { prefix(range.upperBound.advanced(by: 1)) }
    subscript(_ range: PartialRangeUpTo<Int>) -> SubSequence { prefix(range.upperBound) }
    subscript(_ range: PartialRangeFrom<Int>) -> SubSequence { suffix(Swift.max(0, count - range.lowerBound)) }
}

public extension LosslessStringConvertible {
    var string: String { .init(self) }
}

public extension BidirectionalCollection {
    subscript(safe offset: Int) -> Element? {
        guard !isEmpty, let i = index(startIndex, offsetBy: offset, limitedBy: index(before: endIndex)) else { return nil }
        return self[i]
    }
}

public extension Character {
    func valDay3() -> Int {
        var returnVal = Int(self.asciiValue!)
        if returnVal >= 97 {
            returnVal -= 70 + 26
        } else {
            returnVal -= 64 - 26
        }
        return returnVal
    }

    static func + (l: Character, r: Character) -> String {
        return String(l).appending(String(r))
    }

    static func + (l: String, r: Character) -> String {
        return String(l).appending(String(r))
    }
    static func + (l: Character, r: String) -> String {
        return String(l).appending(String(r))
    }
}

public extension Array where Element: Hashable {
    func difference(from other: [Element]) -> [Element] {
        let thisSet = Set(self)
        let otherSet = Set(other)
        return Array(thisSet.symmetricDifference(otherSet))
    }
}
