import Foundation

public class Task3 {
    
    public static func loadBackpacks() -> [[UInt8]] {
        let startChar: Character = "a"
        let startUpperChar: Character = "A"
        let data = load(file: "Input3a")
        return data!.split(separator: "\n")
            .map { backpack in
                return backpack.map { $0.asciiValue! - ($0.isUppercase ? startUpperChar.asciiValue! - 27 : startChar.asciiValue! - 1) }
            }
    }
    
    public static func computeA() {
        let backpackData = loadBackpacks()
            .map { backpack in
                return (Set(backpack[0..<backpack.count/2]), Set(backpack[backpack.count/2..<backpack.count]))
            }

        let prioritySum = backpackData
            .map { backpack in
                return backpack.0.intersection(backpack.1).first!
            }
            .reduce(0) { sum, val in
                return sum + Int(val)
            }

        print("Sum of item type priorities: \(prioritySum)")
        
    }
    
    public static func computeB() {
        let backpackData = Task3.loadBackpacks()
            .map { Set($0) }
            .chunked(into: 3)

        let prioritySum = backpackData
            .map { $0[0].intersection($0[1]).intersection($0[2]).first! }
            .reduce(0) { $0 + Int($1) }

        print("Sum of badge type priorities: \(prioritySum)")
    }
    
}

extension Array {
    func chunked(into size: Int) -> [[Element]] {
        return stride(from: 0, to: count, by: size).map {
            Array(self[$0 ..< Swift.min($0 + size, count)])
        }
    }
}
