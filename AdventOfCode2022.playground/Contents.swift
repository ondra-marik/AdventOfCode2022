import Foundation

class Rope: CustomStringConvertible {
    
    public struct Coordinate: Hashable, CustomStringConvertible {
        var x: Int
        var y: Int
        
        public mutating func add(_ other: Coordinate) {
            x += other.x
            y += other.y
        }
        
        public var description: String {
            return "(\(x),\(y))"
        }
    }
    
    var head = Coordinate(x: 0, y: 0)
    var tail = Coordinate(x: 0, y: 0)
    var visited = Set<Coordinate>([Coordinate(x: 0, y: 0)])
    
    public func move(step: Task9.Step) {
        switch step.direction {
        case .x:
            head.x += step.amount
            moveTail(direction: step.direction, hPosition: head.x, positive: step.isPositive)
        case .y:
            head.y += step.amount
            moveTail(direction: step.direction, hPosition: head.y, positive: step.isPositive)
        }
    }
    
    private func moveTail(direction: Task9.Direction, hPosition: Int, positive: Bool) {
        let tPosition = direction == .x ? tail.x : tail.y
        let amount = hPosition - tPosition
        if amount.magnitude > 1 {
            let adjustment = positive ? 1 : -1
            let adjustedAmount = amount - adjustment
            switch direction {
            case .x:
                tail.x += adjustedAmount
                tail.y = head.y
                markVisited(direction: direction, from: tail.x - adjustedAmount + adjustment, to: tail.x)
            case .y:
                tail.x = head.x
                tail.y += adjustedAmount
                markVisited(direction: direction, from: tail.y - adjustedAmount + adjustment, to: tail.y)
            }
        }
    }
    
    private func markVisited(direction: Task9.Direction, from: Int, to: Int) {
        switch direction {
        case .x:
            for x in min(from, to)...max(from, to) {
                visited.insert(Coordinate(x: x, y: tail.y))
            }
        case .y:
            for y in min(from, to)...max(from, to) {
                visited.insert(Coordinate(x: tail.x, y: y))
            }
        }
    }
    
    var description: String {
        return "H: \(head) T: \(tail), visited: \(visited.count)\n\(visited)"
    }
    
}

let steps = Task9.loadSteps()
let rope = Rope()

steps.forEach { step in
    rope.move(step: step)
}

print("Rope visited \(rope.visited.count) positions at least once")


