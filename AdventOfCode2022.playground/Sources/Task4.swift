import Foundation

public class Task4 {
    
    public static func loadPairs() -> [((Int, Int), (Int, Int))] {
        let data = load(file: "Input4a")
        return data!.split(separator: "\n")
            .map { pair -> ((Int, Int), (Int, Int)) in
                let parsedPair = pair.split(separator: ",").map { range -> (Int, Int) in
                    let bounds = range.split(separator: "-")
                    return (Int(bounds.first!)!, Int(bounds.last!)!)
                }
                return (parsedPair.first!, parsedPair.last!)
            }
    }
    
    public static func computeA() {
        let inclusionCount = loadPairs().filter { pair in
            return (pair.0.0 <= pair.1.0 && pair.0.1 >= pair.1.1) || (pair.0.0 >= pair.1.0 && pair.0.1 <= pair.1.1)
        }.count

        print("There are \(inclusionCount) fully overlapping assignment pairs")
    }
    
    public static func computeB() {
        let overlapCount = loadPairs().filter { pair in
            return !(pair.0.1 < pair.1.0 || pair.1.1 < pair.0.0)
        }.count

        print("There are \(overlapCount) partially overlapping assignment pairs")
    }
    
}
