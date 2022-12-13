import Foundation


public class Task9 {
    
    enum Direction {
        case x
        case y
    }
    
    struct Coordinate: Hashable, CustomStringConvertible {
        var x: Int
        var y: Int
        
        mutating func add(_ other: Coordinate) {
            x += other.x
            y += other.y
        }
        
        mutating func moveTo(_ other: Coordinate) {
            let deltaX = other.x - x
            let deltaY = other.y - y
            if abs(deltaX) > 1 && abs(deltaY) > 1 {
                x += deltaX.signum()
                y += deltaY.signum()
            } else if abs(deltaX) > 1 {
                x += deltaX.signum()
                y = other.y
            } else if abs(deltaY) > 1 {
                x = other.x
                y += deltaY.signum()
            }
        }
        
        var description: String {
            return "(\(x),\(y))"
        }
        
    }
    
    struct Step {
        let direction: Direction
        let amount: Int
        let delta: Coordinate
        
        init(direction: String, amount: Int) {
            self.amount = amount
            switch direction {
            case "R":
                self.direction = .x
                self.delta = Coordinate(x: 1, y: 0)
            case "L":
                self.direction = .x
                self.delta = Coordinate(x: -1, y: 0)
            case "U":
                self.direction = .y
                self.delta = Coordinate(x: 0, y: 1)
            case "D":
                self.direction = .y
                self.delta = Coordinate(x: 0, y: -1)
            default:
                fatalError("Uknown direction in input data")
            }
        }
    }
    
    class Rope: CustomStringConvertible {
        
        var rope: [Coordinate]
        var visited: Set<Coordinate>
        
        init(ropeLength: Int) {
            rope = Array(repeating: Coordinate(x: 0, y: 0), count: ropeLength)
            visited = Set(arrayLiteral: Coordinate(x: 0, y: 0))
        }
        
        func move(step: Step) {
            for _ in 1...step.amount {
                for index in rope.indices {
                    if index == 0 {
                        rope[index].add(step.delta)
                    } else {
                        rope[index].moveTo(rope[index - 1])
                        if index == rope.count-1 {
                            visited.insert(rope[index])
                        }
                    }
                }
            }
        }
        
        var description: String {
            return "\(rope.map { $0.description }.joined(separator: " ")), visited: \(visited.count)\n\(visited)"
        }
        
    }
    
    static func loadSteps() -> [Step] {
        let data = load(file: "Input9a")
        let parsedData = data!.split(separator: "\n")
        
        return parsedData.map { line in
            let instruction = line.split(separator: " ")
            return Step(direction: String(instruction.first!), amount: Int(instruction.last!)!)
        }
    }
    
    public static func computeA() {
        let steps = loadSteps()
        let rope = Rope(ropeLength: 2)

        steps.forEach { step in
            rope.move(step: step)
        }

        print("Rope visited \(rope.visited.count) positions at least once")
    }
    
    public static func computeB() {
        let steps = loadSteps()
        let rope = Rope(ropeLength: 10)

        steps.forEach { step in
            rope.move(step: step)
        }

        print("Rope visited \(rope.visited.count) positions at least once")
    }
    
}
