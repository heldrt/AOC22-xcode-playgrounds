import Foundation

@main
public struct swifties {
    static var mine = Mine()

    public static func main() {
        mine.run()
    }
}

class Mine {
    public func run() {
        let input: [String] = day14.components(separatedBy: "\n")
        
        var grid:[[Int]:String] = .init()

        // tracks the bounding edges of the grid
        var minX: Int = 99999999999
        var maxX: Int = 0
        var maxY: Int = 0
        
        //parse input into grid
        for line: String in input {
            let points: [String] = line.components(separatedBy: " -> ")
            for i in 1...points.count-1 {
                let from: [String] = points[i-1].components(separatedBy: ",")
                let to: [String] = points[i].components(separatedBy: ",")
                let fromX: Int = Int(from[0])!
                let fromY: Int = Int(from[1])!
                let toX: Int = Int(to[0])!
                let toY: Int = Int(to[1])!
                
                maxY = max(fromY, toY, maxY)
                maxX = max(fromX, toX, maxX)
                minX = min(fromX, toX, minX)
                
                if fromX == toX {
                    for y: Int in min(fromY, toY)...max(fromY, toY) {
                        let key: [Int] = [fromX,y]
                        if grid[key] == nil {
                            grid[key] = "#"
                        } else {
//                            print("overlap", key)
                        }
                    }
                }
                if fromY == toY {
                    let step = (toX-fromX).signum()
                    for x: Int in min(fromX, toX)...max(fromX, toX) {
                        let key: [Int] = [x,fromY]
                        if grid[key] == nil {
                            grid[key] = "#"
                        } else {
//                            print("overlap", key)
                        }
                    }
                }
            }
        
        }

        // print the grid
        for y: Int in 0...maxY+3 {
            var line: String = ""
            for x: Int in minX-2..<maxX+3 {
                let key: [Int] = [x,y]
                if grid[key] == nil {
                    line += "."
                } else {
                    line += grid[key]!
                }
            }
            print(line)
        }        
    }
}
