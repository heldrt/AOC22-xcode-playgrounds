import Foundation

@main
public struct swifties {
    static var mine = Mine()

    public static func main() {
        mine.run15()
    }
}

class Mine {
    public func run15() {
        let input: [String] = day15.components(separatedBy: "\n")
        
        var grid:[[Int]:String] = .init(minimumCapacity: 100000000000)
        var sensors = [(Int,Int)]()
        var beacons = [(Int,Int)]()
        
        // tracks the bounding edges of the grid
        var minX: Int = Int.max
        var minY: Int = Int.max
        var maxX: Int = 0
        var maxY: Int = 0
        
        for line: String in input {
            let stringChunks: [String] = line.components(separatedBy: " ")
            // Sensor position
            
            let sensorXString = stringChunks[2]
            var start = sensorXString.index(sensorXString.startIndex, offsetBy: 2)
            var end = sensorXString.index(sensorXString.endIndex, offsetBy: -1)
            var range = start..<end
            let sensorXInt = Int(sensorXString[range]) ?? 0
            
            let sensorYString = stringChunks[3]
            start = sensorYString.index(sensorYString.startIndex, offsetBy: 2)
            end = sensorYString.index(sensorYString.endIndex, offsetBy: -1)
            range = start..<end
            let sensorYInt = Int(sensorYString[range]) ?? 0
            sensors.append((sensorXInt, sensorYInt))
            
            let beaconXString = stringChunks[8]
            start = beaconXString.index(beaconXString.startIndex, offsetBy: 2)
            end = beaconXString.index(beaconXString.endIndex, offsetBy: -1)
            range = start..<end
            let beaconXInt = Int(beaconXString[range]) ?? 0
            
            let beaconYString = stringChunks[9]
            start = beaconYString.index(beaconYString.startIndex, offsetBy: 2)
            end = beaconYString.index(beaconYString.endIndex, offsetBy: 0)
            range = start..<end
            let beaconYInt = Int(beaconYString[range]) ?? 0
            beacons.append((beaconXInt, beaconYInt))
                    
            minX = min(sensorXInt, beaconXInt, minX)
            maxX = max(sensorXInt, beaconXInt, maxX)
            minY = max(sensorYInt, beaconYInt, minY)
            maxY = max(sensorYInt, beaconYInt, maxY)
        }
        
        for sensor in sensors {
            grid[[sensor.0,sensor.1]] = "S"
        }
        for beacon in beacons {
            grid[[beacon.0,beacon.1]] = "B"
        }
        
        let yRow = 10
        
        var minExtent = Int.max
        var maxExtent = 0
        for i in 0..<sensors.count {
            var distanceToBeacon = abs(sensors[i].0 - beacons[i].0) + abs(sensors[i].1 - beacons[i].1)
            if ((sensors[i].0 - beacons[i].0) == 0 || (sensors[i].1 - beacons[i].1) == 0) {
                distanceToBeacon = distanceToBeacon - 1
            }
            if ((yRow >= (sensors[i].1 - distanceToBeacon)) && (yRow <= (sensors[i].1 + distanceToBeacon))) {
                let xRange = abs(distanceToBeacon - abs(yRow - sensors[i].1))
                minExtent = min(sensors[i].0 - xRange, minExtent)
                maxExtent = max(sensors[i].0 + xRange, maxExtent)
            }
        }
        
        var distancesToBeacon = [Int]()
        for i in 0..<sensors.count {
            var distanceToBeacon = abs(sensors[i].0 - beacons[i].0) + abs(sensors[i].1 - beacons[i].1)
            if ((sensors[i].0 - beacons[i].0) == 0 || (sensors[i].1 - beacons[i].1) == 0) {
                distanceToBeacon = distanceToBeacon - 1
            }
            distancesToBeacon.append(distanceToBeacon)
        }
        
        let xMax = 4000000
        for row in 0..<xMax {
                        print(row)
            var xRanges = [(Int,Int)]()
            for i in 0..<sensors.count {
                //            print(i)
                if ((row >= (sensors[i].1 - distancesToBeacon[i])) && (row <= (sensors[i].1 + distancesToBeacon[i]))) {
                    let xRange = abs(distancesToBeacon[i] - abs(row - sensors[i].1))
                    minExtent = max(sensors[i].0 - xRange, 0)
                    maxExtent = min(sensors[i].0 + xRange, xMax)
                    xRanges.append((minExtent,maxExtent))
                }
            }
            xRanges = xRanges.sorted(by: {$0.0 < $1.0})
            var totalRange = xRanges[0]
            for i in 1..<xRanges.count {
                if (xRanges[i].0 <= totalRange.1+1){
                    if (totalRange.1 < xRanges[i].1) {
                        totalRange.1 = xRanges[i].1
                    }
                }
            }
            if (totalRange.1 < xMax) {
                print(row + (totalRange.1 + 1) * 4000000)
                break
            }
        }
        print("Done")
    }
    
    public func run14() {
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
