import Foundation

public class Task2 {
    
    private static func loadData() -> [(String, String)] {
        let data = load(file: "Input2a")
        return data?.split(separator: "\n")
            .map { $0.split(separator: " ")}
            .map { (String($0[0]), String($0[1])) } ?? []
    }
    
    private static func computeScore(guide: [(String, String)], symbolScore: [String: Int], outcomeScore: [String: Int]) -> Int {
        return guide.map { round in
            return symbolScore[round.1]! + outcomeScore["\(round.0)\(round.1)"]!
        }.reduce(0, +)
    }
    
    public static func computeA() {
        
        let symbolScore = [
            "X": 1,
            "Y": 2,
            "Z": 3
        ]

        let outcomeScore = [
            "AX": 3,
            "AY": 6,
            "AZ": 0,
            "BX": 0,
            "BY": 3,
            "BZ": 6,
            "CX": 6,
            "CY": 0,
            "CZ": 3
        ]
        
        let guideData = loadData()
        
        print("Final score for guide: \(computeScore(guide: guideData, symbolScore: symbolScore, outcomeScore: outcomeScore))")
    }
    
    public static func computeB() {
        
        let outcomeScore = [
            "X": 0,
            "Y": 3,
            "Z": 6
        ]

        let symbolScore = [
            "AX": 3,
            "AY": 1,
            "AZ": 2,
            "BX": 1,
            "BY": 2,
            "BZ": 3,
            "CX": 2,
            "CY": 3,
            "CZ": 1
        ]
        
        let guideData = loadData()
        
        print("Final score for corrected guide: \(computeScore(guide: guideData, symbolScore: outcomeScore, outcomeScore: symbolScore))")
    }
    
}

