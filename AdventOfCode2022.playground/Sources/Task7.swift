import Foundation

public class Task7 {
    
    enum Command {
        case cd(folder: String?)
        case ls
        case dir
        case file(size: Int)
        case unknown
    }

    typealias Directory = (name: String, size: Int)
    
    static func loadCommands() -> [Command] {
        let data = load(file: "Input7a")
        let parsedData = data!.split(separator: "\n")
        
        return parsedData.compactMap { cmd in
            var components = cmd.split(separator: " ")
            switch components.removeFirst() {
            case "$":
                switch (components.removeFirst()) {
                case "ls":
                    return nil
                case "cd":
                    if components.first == ".." {
                        return .cd(folder: nil)
                    } else {
                        return .cd(folder: components.first.flatMap { String($0) })
                    }
                default:
                    return nil
                }
            case "dir":
                return .dir
            case let size:
                return .file(size: Int(size) ?? 0)
            }
        }
    }
    
    static func getDirectorySizes(commands: [Command]) -> [Directory] {
        var result: [Directory] = []
        var processed: [Directory] = []

        commands.forEach { cmd in
            switch cmd {
            case .cd(let folder):
                if let folder = folder {
                    processed.append((name: folder, size: 0))
                } else {
                    result.append(processed.removeLast())
                }
            case .file(size: let size):
                for index in processed.indices {
                    processed[index].size += size
                }
            default:
                break
            }
        }

        return result + processed
    }
    
    public static func computeA() {
        let commands = Task7.loadCommands()
        let directories = getDirectorySizes(commands: commands)

        let totalSize = directories.filter { $0.size <= 100000 }.reduce(0, {$0 + $1.size})
        print("Total size of smaller folders is \(totalSize)")
    }
    
    public static func computeB() {
        let commands = Task7.loadCommands()
        let directories = getDirectorySizes(commands: commands)
        
        let available = 70000000
        let required = 30000000

        let rootDir = directories.first(where: { $0.name == "/" })

        let minimumToDelete = required - (available - rootDir!.size)
        let deleteDir = directories.filter { $0.size >= minimumToDelete }.min(by: { $0.size < $1.size })

        print("We need to delete directory \(deleteDir!)")
    }
    
}
