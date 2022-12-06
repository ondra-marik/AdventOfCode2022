import Foundation

public class Task5 {
    
    typealias Stack = [Character]
    typealias Move = (from: Int, to: Int, amount: Int)

    static func loadStacks() -> (stacks: [Stack], moves: [Move]) {
        let data = load(file: "Input5a")
        let parsedData = data!.split(separator: "\n", omittingEmptySubsequences: false)
            .split(separator: "")
        let stackData = parsedData[0].reversed()
        let stackStride = stride(from: 1, to: stackData.first?.count ?? 0, by: 4)
        var stacks: [[Character]] = .init(repeating: [], count: stackStride.underestimatedCount)
        stackData.dropFirst().forEach { data in
            stackStride.enumerated().forEach { index, position in
                guard position < data.count else { return }
                let item = data[data.index(data.startIndex, offsetBy: position)]
                if item != " " {
                    stacks[index].append(item)
                }
            }
        }
        
        // This can be done much more nicely in swift 5.7
        let moves = parsedData[1].map { move -> Move in
            let regex = try! NSRegularExpression(pattern: #"\D+(\d+)\D+(\d+)\D+(\d+)"#)
            let matche = regex.matches(in: String(move), range: NSRange(move.startIndex..<move.endIndex, in: move)).first!
            return (from: Int(move[Range(matche.range(at: 2), in: move)!])! - 1,
                    to: Int(move[Range(matche.range(at: 3), in: move)!])! - 1,
                    amount: Int(move[Range(matche.range(at: 1), in: move)!])!)
        }
        
        return (stacks: stacks, moves: moves)
    }

    static func moveCrates(with move: Move, of stack: inout [Stack], reversed: Bool) {
        var moved = stack[move.from].suffix(move.amount)
        if reversed {
            moved.reverse()
        }
        stack[move.from] = stack[move.from].dropLast(move.amount)
        stack[move.to].append(contentsOf: moved)
    }
    
    public static func computeA() {
        var stackData = loadStacks()
        printStack(stackData.stacks)
        stackData.moves.forEach { move in
            moveCrates(with: move, of: &stackData.stacks, reversed: true)
        }

        let tops = stackData.stacks.compactMap { $0.last.flatMap { String($0) }}.joined()
        print("Crates on top of stacks: \(tops)")
    }
    
    public static func computeB() {
        var stackData = loadStacks()
        printStack(stackData.stacks)
        stackData.moves.forEach { move in
            moveCrates(with: move, of: &stackData.stacks, reversed: false)
        }

        let tops = stackData.stacks.compactMap { $0.last.flatMap { String($0) }}.joined()
        print("Crates on top of stacks for 9001: \(tops)")
    }
    
    // MARK: - Utility
    
    static func printStack(_ stack: [Stack]) {
        let range = stack.map { $0.count }.max()!
        for index in (0..<range).reversed() {
            stack.forEach {
                if $0.count > index {
                    print($0[index], terminator: "")
                } else {
                    print(" ", terminator: "")
                }
                print(" ", terminator: "")
            }
            print()
        }
    }
    
}
