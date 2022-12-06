import Foundation

public class Task6 {
    
    public static func processBuffer(_ buffer: String, markerSize: Int) -> Int {
        var position = 0
        var counters: [Character: Int] = [:]
        var queue: [Character] = []
        var input = buffer.reversed().map { letter in
            return letter as Character
        }
        
        while (position <= markerSize || counters.values.contains(where: { $0 > 1 })) {
            guard let current = input.popLast() else {
                print("Input buffer is empty")
                break
            }
            queue.append(current)
            counters[current] = (counters[current] ?? 0) + 1
            
            if queue.count > markerSize {
                let discard = queue.removeFirst()
                counters[discard] = (counters[discard] ?? 1) - 1
            }
            
            position += 1
        }
        
        return position
    }
    
    public static func computeA() {
        let buffer = load(file: "Input6a")!
        let markerPosition = processBuffer(buffer, markerSize: 4)
        print("\(markerPosition) processed before start-of-packet found")
    }
    
    public static func computeB() {
        let buffer = load(file: "Input6a")!
        let markerPosition = processBuffer(buffer, markerSize: 14)
        print("\(markerPosition) processed before start-of-message found")
    }
    
}
