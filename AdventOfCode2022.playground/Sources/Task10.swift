import Foundation

public class Task10 {
    
    enum Instruction: CustomStringConvertible, CaseIterable {
        
        case noop
        case addx(value: Int)
        
        init?(input: String, value: String?) {
            switch (input, value) {
            case ("noop", _):
                self = .noop
            case ("addx", value):
                if let value = value, let numValue = Int(value) {
                    self = .addx(value: numValue)
                } else {
                    return nil
                }
            default:
                return nil
            }
        }
        
        var length: Int {
            switch self {
            case .noop:
                return 0
            case .addx:
                return 1
            }
        }
        
        var description: String {
            switch self {
            case .noop:
                return "noop"
            case .addx(let value):
                return "addx \(value)"
            }
        }
        
        static var allCases: [Instruction] {
            return [.noop, .addx(value: 1)]
        }
        
    }

    static func loadInstructions() -> [Instruction] {
        let data = load(file: "Input10a")
        let parsedData = data!.split(separator: "\n")
        
        return parsedData.compactMap { line in
            let instruction = line.split(separator: " ")
            let value = instruction.count > 1 ? String(instruction[1]) : nil
            return Instruction(input: String(instruction.first!), value: value )
        }
    }
    
    // MARK: - Part 1
    
    static var register = 1
    static var cycle = 0
    static var delay = 0
    static var instructionInProgress: Instruction?
    static let sampling = stride(from: 20, through: 220, by: 40)
    static var samples: [Int] = []
    
    static func executeInstruction() {
        if sampling.contains(cycle) {
            samples.append(register * cycle)
        }
            
        if let processedInstruction = instructionInProgress {
            if delay == 0 {
                switch processedInstruction {
                case .addx(let value):
                    register += value
                    instructionInProgress = nil
                case .noop:
                    instructionInProgress = nil
                }
            } else {
                delay -= 1
            }
        }
    }
    
    static func loadInstruction(from instructions: inout [Instruction]) {
        if instructionInProgress == nil {
            let instruction = instructions.removeFirst()
            instructionInProgress = instruction
            delay = instruction.length
        }
    }
    
    // MARK: - Part 2
    
    static var display: [[Character]] = []
    static let pixelsPerRow = 40
    static let litPixel: Character = "#"
    static let darkPixel: Character = "."
    static let spriteLength = 3
    
    static func currentPosition(cycle: Int) -> (row: Int, column: Int) {
        return (row: cycle / pixelsPerRow, column: cycle % pixelsPerRow)
    }

    static func drawDisplay() {
        let position = currentPosition(cycle: cycle)
        if display.count <= position.row {
            display.append([])
        }

        if register-1..<register-1+spriteLength ~= position.column {
            display[position.row].append(litPixel)
        } else {
            display[position.row].append(darkPixel)
        }
    }
    
    // MARK: - Public
    
    public static func computeA() {
        var instructions = loadInstructions()

        while !instructions.isEmpty {
            executeInstruction()
            loadInstruction(from: &instructions)
            cycle += 1
        }

        let signalStrength = samples.reduce(0, +)
        print("Signal strength sum is \(signalStrength)")
    }
    
    public static func computeB() {
        var instructions = loadInstructions()
        
        while !instructions.isEmpty {
            executeInstruction()
            drawDisplay()
            loadInstruction(from: &instructions)
            cycle += 1
        }

        print2DArray(display)
    }
    
}
