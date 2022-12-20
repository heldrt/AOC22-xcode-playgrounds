import Foundation

@main
public struct swifties {
    static var mine = Mine()

    public static func main() {
        mine.run18()
    }
}

class Mine {
    
    public func run18() {
        let input: [String] = day18.components(separatedBy: "\n")
        var xMax = 0
        var yMax = 0
        var zMax = 0
        
        for line in input {
            let coordinates = line.components(separatedBy: ",")
            xMax = max(xMax, Int(coordinates[0]) ?? 0)
            yMax = max(yMax, Int(coordinates[1]) ?? 0)
            zMax = max(zMax, Int(coordinates[2]) ?? 0)
        }
        let maxValues = String(xMax) + ", " + String(yMax) + ", " + String(zMax)
        print(maxValues)
        let zCoords = Array(repeating: false, count: zMax + 2)
        let yAndZCoords = Array(repeating: zCoords, count: yMax + 2)
        var volume = Array(repeating: yAndZCoords, count: xMax + 2)
        
        let checkVolume = volume
        
        for line in input {
            let coordinates = line.components(separatedBy: ",")
            let xCoord = Int(coordinates[0]) ?? 0
            let yCoord = Int(coordinates[1]) ?? 0
            let zCoord = Int(coordinates[2]) ?? 0
            volume[xCoord][yCoord][zCoord] = true
        }

        var totalExposedSides = 0
        // Along x
        for z in 0..<volume[0][0].count {
            for y in 0..<volume[0].count {
                var currentOccupancy = false
                for x in 0..<volume.count {
                    if volume[x][y][z] != currentOccupancy {
                        if (!volume[x][y][z]) {
                            var newCheckVolume = checkVolume
                            if (!pathToEdges(x: x, y: y, z: z, volume: &volume, checkVolume: &newCheckVolume)) {
                                volume[x][y][z] = true
                            } else {
                                totalExposedSides = totalExposedSides + 1
                                currentOccupancy = !currentOccupancy
                            }
                        } else {
                            totalExposedSides = totalExposedSides + 1
                            currentOccupancy = !currentOccupancy
                        }
                    }
                }
            }
        }
        
        // Along y
        for z in 0..<volume[0][0].count {
            for x in 0..<volume.count {
                var currentOccupancy = false
                for y in 0..<volume[0].count {
                    if volume[x][y][z] != currentOccupancy {
                        if (!volume[x][y][z]) {
                            var newCheckVolume = checkVolume
                            if (!pathToEdges(x: x, y: y, z: z, volume: &volume, checkVolume: &newCheckVolume)) {
                                volume[x][y][z] = true
                            } else {
                                totalExposedSides = totalExposedSides + 1
                                currentOccupancy = !currentOccupancy
                            }
                        } else {
                            totalExposedSides = totalExposedSides + 1
                            currentOccupancy = !currentOccupancy
                        }
                    }
                }
            }
        }
        // Along z
        for x in 0..<volume.count {
            for y in 0..<volume[0].count {
                var currentOccupancy = false
                for z in 0..<volume[0][0].count {
                    if volume[x][y][z] != currentOccupancy {
                        if (!volume[x][y][z]) {
                            var newCheckVolume = checkVolume
                            if (!pathToEdges(x: x, y: y, z: z, volume: &volume, checkVolume: &newCheckVolume)) {
                                volume[x][y][z] = true
                            } else {
                                totalExposedSides = totalExposedSides + 1
                                currentOccupancy = !currentOccupancy
                            }
                        } else {
                            totalExposedSides = totalExposedSides + 1
                            currentOccupancy = !currentOccupancy
                        }
                    }
                }
            }
        }
        
        print(totalExposedSides)
    }
    
    func pathToEdges(x: Int, y: Int, z: Int, volume: inout [[[Bool]]], checkVolume: inout [[[Bool]]]) -> Bool {
        let xMax = volume.count - 1
        let yMax = volume[0].count - 1
        let zMax = volume[0][0].count - 1
        if (volume[x][y][z]) {
            checkVolume[x][y][z] = true
            return false
        } else if ((x == 0) || (x == xMax) ||
            (y == 0) || (y == yMax) ||
            (z == 0) || (z == zMax)) {
            checkVolume[x][y][z] = true
            return true
        } else {
            checkVolume[x][y][z] = true
            if (!checkVolume[x+1][y][z]) {
                if pathToEdges(x: x+1, y: y, z: z, volume: &volume, checkVolume: &checkVolume) {
                    return true
                }
            }
            if (!checkVolume[x-1][y][z]) {
                if pathToEdges(x: x-1, y: y, z: z, volume: &volume, checkVolume: &checkVolume) {
                    return true
                }
            }
            if (!checkVolume[x][y+1][z]) {
                if pathToEdges(x: x, y: y+1, z: z, volume: &volume, checkVolume: &checkVolume) {
                    return true
                }
            }
            if (!checkVolume[x][y-1][z]) {
                if pathToEdges(x: x, y: y-1, z: z, volume: &volume, checkVolume: &checkVolume) {
                    return true
                }
            }
            if (!checkVolume[x][y][z+1]) {
                if pathToEdges(x: x, y: y, z: z+1, volume: &volume, checkVolume: &checkVolume) {
                    return true
                }
            }
            if (!checkVolume[x][y][z-1]) {
                if pathToEdges(x: x, y: y, z: z-1, volume: &volume, checkVolume: &checkVolume) {
                    return true
                }
            }
            return false
        }
    }
    
    
    
    func getStartingHeight(chamber: [[Int]:String]) -> Int {
        var startingHeight = 4
        for entry in chamber {
            if (entry.key[1] + 4) > startingHeight {
                startingHeight = entry.key[1] + 4
            }
        }
        return startingHeight
    }
    public func run17() {
        let input = day17
        var pieces = [[(Int,Int)]]()
        let piece1 = [(0,0), (1,0), (2,0), (3,0)]
        pieces.append(piece1)
        let piece2 = [(1,0), (0,1), (1,1), (2,1), (1,2)]
        pieces.append(piece2)
        let piece3 = [(0,0), (1,0), (2,0), (2,1), (2,2)]
        pieces.append(piece3)
        let piece4 = [(0,0), (0,1), (0,2), (0,3)]
        pieces.append(piece4)
        let piece5 = [(0,0), (0,1), (1,0), (1,1)]
        pieces.append(piece5)
        
        var chamber = [[Bool]]()

        let floor = 1
        var pieceIndex = 0
        var inputIndex = 0
        let maxPieces = 1_000_000_000_000
        let rightWall = 7
        var cumulativeHeight = 0
        var maxHeight = 0
        var tetrisRowIndices = [Int]()
        let loopedAmount = 0
        var tetrisIndices = [[Int]]()
        var mIndices = [Int]()
        var m = 1
        while m  <= maxPieces {
            let currentPiece = pieces[pieceIndex]
            let startingHeight = maxHeight + 4
            var currentHeight = startingHeight
            var currentShift = 2
            var collision = false
            let maxy = currentPiece.max { $0.1 < $1.1 }!.1
            for _ in (chamber.count - 1) ... max(maxy + currentHeight, chamber.count - 1) {
                chamber.append(Array(repeating: false, count: 7))
            }
            while !collision {
                for block in currentPiece {
                    if (block.1 + currentHeight) < floor{
                        collision = true
                    } else {
                        if chamber[block.1 + currentHeight][block.0 + currentShift] {
                            collision = true
                        }
                    }
                }
                if (collision) {
                    var rowsToCheck = [Int]()
                    for block in currentPiece {
                        chamber[block.1 + currentHeight + 1][block.0 + currentShift] = true
                        rowsToCheck.append(block.1 + currentHeight + 1)
                        maxHeight = max(maxHeight, block.1 + currentHeight + 1)
                    }
                   
                        let row = maxHeight-1 //rowsToCheck[r]
                        var filled = true
                        var space = 0
                        while filled && space < chamber[row].count {
                            if !chamber[row][space] {
                                filled = false
                            }
                            space = space + 1
                        }
                        if (filled) {
                            let currentPair = [inputIndex,pieceIndex]
                            if(tetrisIndices.contains(currentPair)) {
                                let firstIndex = tetrisIndices.firstIndex(of: currentPair) ?? 0
                                let cycleSize = m - (mIndices[firstIndex])
                                print(cycleSize)
                                let maxDiff = row - tetrisRowIndices[firstIndex]
                                print(mIndices[firstIndex])
                                print(m)
                                let numCycles = (maxPieces - (mIndices[firstIndex] + 1)) / cycleSize
                                print(numCycles)
                                cumulativeHeight = (maxDiff) * (numCycles-1)
                                m = m  + cycleSize * (numCycles - 1)
                                tetrisIndices.removeAll()
                                tetrisRowIndices.removeAll()
                                mIndices.removeAll()
                            } else {
                                tetrisIndices.append(currentPair)
                                tetrisRowIndices.append(row)
                                mIndices.append(m)
                            }
                        }
                } else {
                    let direction = input[inputIndex]
                    if (direction == "<") {
                        var shouldShift = true
                        for block in currentPiece {
                            if (block.0 + currentShift - 1) < 0 {
                                shouldShift = false
                            } else {
                                if (chamber[block.1 + currentHeight][block.0 + currentShift - 1]) {
                                    shouldShift = false
                                }
                            }
                        }
                        if (shouldShift) {
                            currentShift = currentShift - 1
                        }
                    } else if (direction == ">") {
                        var shouldShift = true
                        for block in currentPiece {
                            if (block.0 + currentShift + 1) >= rightWall {
                                shouldShift = false
                            } else {
                                if chamber[block.1 + currentHeight][block.0 + currentShift + 1] {
                                    shouldShift = false
                                }
                            }
                        }
                        if (shouldShift) {
                            currentShift = currentShift + 1
                        }
                    }
                    
                    currentHeight = currentHeight - 1
                    inputIndex = (inputIndex + 1) % input.count
                }
            }
            m = m + 1
            pieceIndex = (pieceIndex + 1) % pieces.count
        }
        print( maxHeight + cumulativeHeight - loopedAmount)
    }
    
    
    
    struct Valve {
        let flow: Int
    }
    
    struct Path: Hashable {
        let from: String
        let to: String
    }
    
    typealias Destination = (valve: String, time: Int)

    typealias Paths = [String: [Destination]]
    
    public func run16() {
        let lines = day16.components(separatedBy: "\n")
        var fullValveList = [String]()
        var unopenedList = [String]()
        var connectionList = [[String]]()
        var valvesWithFlow = [String]()
        var fullRateList = [Int]()
        var valveListWithFlow = [String: Valve]()
        
        let removeCharacters: Set<Character> = [",", ";"]
        for line in lines {
            let chunks = line.components(separatedBy: " ")
            let currentValve = chunks[1]
            fullValveList.append(currentValve)
            var connections = [String]()
            for c in 9..<chunks.count {
                var connection = chunks[c]
                connection.removeAll(where: { removeCharacters.contains($0) } )
                connections.append(connection)
            }
            connectionList.append(connections)
            var flowChunk = chunks[4]
            flowChunk.removeAll(where: { removeCharacters.contains($0) } )
            flowChunk = flowChunk.replacingOccurrences(of: "rate=", with: "")
            let flowRate = Int(flowChunk) ?? 0
            fullRateList.append(flowRate)
            if (flowRate > 0 || currentValve == "AA") {
                valveListWithFlow[currentValve] = Valve(flow: flowRate)
                unopenedList.append(currentValve)
                valvesWithFlow.append(currentValve)
            }
        }
        let valveGraph: WeightedGraph<String, Int> = WeightedGraph<String, Int>(vertices: fullValveList)
        for v in 0..<fullValveList.count {
            for connection in connectionList[v] {
                if (Int(fullValveList.firstIndex(of: connection) ?? 0) > v) {
                    valveGraph.addEdge(from: fullValveList[v], to: connection, weight: 1)
                }
            }
        }
        
        // Create combos of paths
        var paths = Paths()
        for start in valvesWithFlow {
            let (_, pathDict) = valveGraph.dijkstra(root: start, startDistance: 0)
            for destination in valvesWithFlow {
                if start != destination {
                    let valvePath: [WeightedEdge<Int>] = pathDictToPath(from: valveGraph.indexOfVertex(start)!, to: valveGraph.indexOfVertex(destination)!, pathDict: pathDict)
                    let stops: [String] = valveGraph.edgesToVertices(edges: valvePath)
                    let path = Path(from: start, to: destination)
                    if paths[path.from] == nil {
                        paths[path.from] = [Destination]()
                    }
                    paths[path.from]!.append((valve: path.to, time: stops.count - 1))
                }
            }
        }
        var open = Set<String>()
        var result = findMaxPressurePt1(valveListWithFlow, paths: paths, minutes: 30, valve: "AA", open: &open)
        print(result)
        open = Set<String>()
        result = findMaxPressurePt2(valveListWithFlow, paths: paths, m1: 26, m2: 26, v1: "AA", v2: "AA", open: &open)
        print(result)
    }
    
    func findMaxPressurePt1(_ valves: [String: Valve], paths: Paths, minutes: Int, valve: String, open: inout Set<String>) -> Int {
        var result = 0
        for p in paths[valve]! {
            if !open.contains(p.valve) && minutes >= p.time + 1 {
                open.insert(p.valve)
                let remainingTime = minutes - p.time - 1
                let pressure = findMaxPressurePt1(valves, paths: paths, minutes: remainingTime, valve: p.valve, open: &open)
                open.remove(p.valve)
                result = max(result, pressure + remainingTime * valves[p.valve]!.flow)
            }
        }
        return result
    }
    
    func findMaxPressurePt2(_ valves: [String: Valve], paths: Paths, m1: Int, m2: Int, v1: String, v2: String, open: inout Set<String>) -> Int {
        var result = 0
        for p in paths[v1]! {
            if !open.contains(p.valve) && m1 >= p.time + 1 {
                open.insert(p.valve)
                let remainingTime = m1 - p.time - 1
                let pressure = findMaxPressurePt2(valves, paths: paths, m1: m2, m2: remainingTime, v1: v2, v2: p.valve, open: &open)
                open.remove(p.valve)
                result = max(result, pressure + remainingTime * valves[p.valve]!.flow)
            }
        }
        return result
    }
    
    public func run13(){
        let rawString = day13
        let inputString = rawString.components(separatedBy: "\n")
        var input: [Packet] = inputString.compactMap { try? JSONDecoder().decode(Packet.self, from: $0.data(using: .utf8)!) }
        var part1Result = 0
        for i in stride(from: 0, to: input.count, by: 2) {
            if (input[i] < input[i + 1]) {
                part1Result = part1Result + i/2 + 1
            }
        }
        print(part1Result)
        
        let newPacket1: Packet = .list([.list([.num(2)])])
        let newPacket2: Packet = .list([.list([.num(6)])])
        input.append(newPacket1)
        input.append(newPacket2)
        input = input.sorted(by: <)
        let part2Result = (Int(input.firstIndex(of: newPacket1) ?? 0) + 1) * (Int(input.firstIndex(of: newPacket2) ?? 0) + 1)
        print(part2Result)
    }
    
    public enum Packet: Comparable, Decodable {
        case num(Int), list([Packet])
        
        public init(from decoder: Decoder) throws {
            do {
                let c = try decoder.singleValueContainer()
                self = .num(try c.decode(Int.self))
            } catch {
                self = .list(try [Packet](from: decoder))
            }
        }
        
        public static func < (lhs: Self, rhs: Self) -> Bool {
            switch (lhs, rhs) {
            case (.num(let lValue), .num(let rValue)): return lValue < rValue
            case (.list(_), .num(_)): return lhs < .list([rhs])
            case (.num(_), .list(_)): return .list([lhs]) < rhs
            case (.list(let lValue), .list(let rValue)):
                for (l, r) in zip(lValue, rValue) {
                    if (l < r) {
                        return true
                    } else if (l > r) {
                        return false
                    }
                }
                return lValue.count < rValue.count
            }
        }
    }
    
    func comparator<T,S>(first: T, second: S) -> Int {
        if (first is Int && second is Int){
            let firstInt = first as! Int
            let secondInt = second as! Int
            if (firstInt < secondInt) {
                return 1
            } else if (firstInt == secondInt) {
                return 0
            } else {
                return -1
            }
        } else if (first is [Int] && second is [Int]){
            let firstIntArray = first as! [Int]
            let secondIntArray = second as! [Int]
            if (firstIntArray.count == 0 && secondIntArray.count == 0) {
                return 0
            } else {
                let maxCount = max(firstIntArray.count, secondIntArray.count)
                for i in 0..<maxCount {
                    if i > firstIntArray.count - 1 {
                        return 1
                    } else if i > secondIntArray.count - 1 {
                        return -1
                    }else {
                        if (firstIntArray[i]  < secondIntArray[i]) {
                            return 1
                        } else if (firstIntArray[i] > secondIntArray[i]) {
                            return -1
                        }
                    }
                }
            }
        } else if (first is Int) {
            let newArray: [Int] = [first as! Int]
            return comparator(first: newArray, second: second)
        } else {
            let newArray: [Int] = [second as! Int]
            return comparator(first: first, second: newArray)
        }
        return 0
    }
    
    public func run14() {
        let input: [String] = day14.components(separatedBy: "\n")
        
        var grid:[[Int]:String] = .init()

        // tracks the bounding edges of the grid
        var minX: Int = Int.max
        var maxX: Int = 0
        var maxY: Int = 0
        
        for line: String in input {
            let stringChunks: [String] = line.components(separatedBy: " -> ")
            var coordinates = [(Int,Int)]()
            for chunk in stringChunks {
                let rawCoords = chunk.components(separatedBy: ",")
                let xCoord = Int(rawCoords[0]) ?? 0
                let yCoord = Int(rawCoords[1]) ?? 0
                coordinates.append((xCoord, yCoord))
                maxY = max(yCoord, maxY)
                maxX = max(xCoord, maxX)
                minX = min(xCoord, minX)
            }
            for i in 0..<(coordinates.count - 1) {
                for x in min(coordinates[i].0,coordinates[i+1].0)...max(coordinates[i].0,coordinates[i+1].0) {
                    for y in min(coordinates[i].1,coordinates[i+1].1)...max(coordinates[i].1,coordinates[i+1].1){
                        let key: [Int] = [x,y]
                        if grid[key] == nil {
                            grid[key] = "#"
                        }
                    }
                }
            }
        }
        let grainStart = (500,0)
        var abyssFound = false
        var grains = 0
        while (!abyssFound){
            var grainPosition = grainStart
            var blocked = false
            while (!blocked){
                if grid[[grainPosition.0,grainPosition.1+1]] == nil {
                    grainPosition.1 = grainPosition.1 + 1
                } else if (grid[[grainPosition.0,grainPosition.1+1]] == "#") {
                    if ((grid[[grainPosition.0-1,grainPosition.1+1]] != "#") &&
                        (grid[[grainPosition.0-1,grainPosition.1+1]] != "o")) {
                        grainPosition.0 = grainPosition.0 - 1
                        grainPosition.1 = grainPosition.1 + 1
                    } else if ((grid[[grainPosition.0+1,grainPosition.1+1]] != "#") &&
                               (grid[[grainPosition.0+1,grainPosition.1+1]] != "o")) {
                        grainPosition.0 = grainPosition.0 + 1
                        grainPosition.1 = grainPosition.1 + 1
                    } else {
                        grid[[grainPosition.0,grainPosition.1]] = "o"
                        blocked = true
                        grains = grains + 1
                    }
                } else if (grid[[grainPosition.0,grainPosition.1+1]] == "o") {
                    if ((grid[[grainPosition.0-1,grainPosition.1+1]] != "#") &&
                        (grid[[grainPosition.0-1,grainPosition.1+1]] != "o")) {
                        grainPosition.0 = grainPosition.0 - 1
                        grainPosition.1 = grainPosition.1 + 1
                    } else if ((grid[[grainPosition.0+1,grainPosition.1+1]] != "#") &&
                               (grid[[grainPosition.0+1,grainPosition.1+1]] != "o")) {
                        grainPosition.0 = grainPosition.0 + 1
                        grainPosition.1 = grainPosition.1 + 1
                    } else {
                        grid[[grainPosition.0,grainPosition.1]] = "o"
                        blocked = true
                        grains = grains + 1
                    }
                }
                if (grainPosition.1 == maxY){
                    blocked = true
                    abyssFound = true
                }
            }
        }
        print(grains)
        
        abyssFound = false
        let floor = maxY + 2
        while (!abyssFound){
            var grainPosition = grainStart
            var blocked = false
            while (!blocked){
                if grainPosition.1 + 1 == floor {
                    grid[[grainPosition.0,grainPosition.1]] = "o"
                    blocked = true
                    grains = grains + 1
                } else if grid[[grainPosition.0,grainPosition.1+1]] == nil {
                    grainPosition.1 = grainPosition.1 + 1
                } else if (grid[[grainPosition.0,grainPosition.1+1]] == "#") {
                    if ((grid[[grainPosition.0-1,grainPosition.1+1]] != "#") &&
                        (grid[[grainPosition.0-1,grainPosition.1+1]] != "o")) {
                        grainPosition.0 = grainPosition.0 - 1
                        grainPosition.1 = grainPosition.1 + 1
                    } else if ((grid[[grainPosition.0+1,grainPosition.1+1]] != "#") &&
                               (grid[[grainPosition.0+1,grainPosition.1+1]] != "o")) {
                        grainPosition.0 = grainPosition.0 + 1
                        grainPosition.1 = grainPosition.1 + 1
                    } else {
                        grid[[grainPosition.0,grainPosition.1]] = "o"
                        blocked = true
                        grains = grains + 1
                    }
                } else if (grid[[grainPosition.0,grainPosition.1+1]] == "o") {
                    if ((grid[[grainPosition.0-1,grainPosition.1+1]] != "#") &&
                        (grid[[grainPosition.0-1,grainPosition.1+1]] != "o")) {
                        grainPosition.0 = grainPosition.0 - 1
                        grainPosition.1 = grainPosition.1 + 1
                    } else if ((grid[[grainPosition.0+1,grainPosition.1+1]] != "#") &&
                               (grid[[grainPosition.0+1,grainPosition.1+1]] != "o")) {
                        grainPosition.0 = grainPosition.0 + 1
                        grainPosition.1 = grainPosition.1 + 1
                    } else {
                        grid[[grainPosition.0,grainPosition.1]] = "o"
                        blocked = true
                        grains = grains + 1
                    }
                }
                if (grainPosition.1 == 0){
                    blocked = true
                    abyssFound = true
                }
                minX = min(minX,grainPosition.0)
                maxX = max(maxX,grainPosition.0)
            }
        }
        print(grains)
        
//        // print the grid
//        for y: Int in 0...maxY+3 {
//            var line: String = ""
//            for x: Int in minX-2..<maxX+3 {
//                let key: [Int] = [x,y]
//                if grid[key] == nil {
//                    line += "."
//                } else {
//                    line += grid[key]!
//                }
//            }
//            print(line)
//        }
    }
    
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
    
    public func run14Andy() {
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
                    _ = (toX-fromX).signum()
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
