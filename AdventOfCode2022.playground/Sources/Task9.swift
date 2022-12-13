import Foundation


public class Task9 {
    
    public enum Direction {
        case x
        case y
    }
    
    public struct Step {
        public let direction: Direction
        public let amount: Int
        
        init(direction: String, amount: Int) {
            switch direction {
            case "R":
                self.direction = .x
                self.amount = amount
            case "L":
                self.direction = .x
                self.amount = -amount
            case "U":
                self.direction = .y
                self.amount = amount
            case "D":
                self.direction = .y
                self.amount = -amount
            default:
                fatalError("Uknown direction in input data")
            }
        }
        
        public var isPositive: Bool {
            return amount >= 0
        }
    }
    
    public static func loadSteps() -> [Step] {
        let data = load(file: "Input9a")
        let parsedData = data!.split(separator: "\n")
        
        return parsedData.map { line in
            let instruction = line.split(separator: " ")
            return Step(direction: String(instruction.first!), amount: Int(instruction.last!)!)
        }
    }
    
    public static func computeA() {
        
    }
    
    public static func computeB() {
        
    }
    
}
