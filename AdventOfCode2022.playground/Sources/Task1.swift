import Foundation

public class Task1 {
        
    public static func computeA() {
        let data = load(file: "Input1a")
        let elvesData = data?.split(separator: "\n", omittingEmptySubsequences: false) ?? []
        let elves = elvesData.split(separator: "")

        let maxCalories = elves.map { elf in elf.reduce(0, { $0 + (Int($1) ?? 0) }) }.max()
        print("Elf with maximum supply has \(maxCalories ?? 0) calories")
    }
    
    public static func computeB() {
        let data = load(file: "Input1a")
        let elvesData = data?.split(separator: "\n", omittingEmptySubsequences: false) ?? []
        let elves = elvesData.split(separator: "")

        let elvesCalories = elves.map { elf in elf.reduce(0, { $0 + (Int($1) ?? 0) }) }.sorted()

        let topThreeCalories = elvesCalories.suffix(3).reduce(0, +)
        print("Top three elves are carrying \(topThreeCalories) calories")
    }
    
}

