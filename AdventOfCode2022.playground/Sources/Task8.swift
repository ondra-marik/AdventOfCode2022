import Foundation

public class Task8 {
    
    public struct Tree: CustomStringConvertible {
        
        public var height: Int
        public var maxHeights: (left: Int, right: Int, top: Int, bottom: Int)
        public var visibility: (left: Int, right: Int, top: Int, bottom: Int)
        
        public var description: String {
            return "\(scenicScore)"
        }
        
        public var isVisible: Bool {
            return  maxHeights.left < height ||
                    maxHeights.right < height ||
                    maxHeights.top < height ||
                    maxHeights.bottom < height
        }
        
        public var scenicScore: Int {
            return visibility.left * visibility.right * visibility.top * visibility.bottom
        }
        
    }
    
    public static func loadForest() -> [[Tree]] {
        let data = load(file: "Input8a")
        let parsedData = data!.split(separator: "\n")
        
        return parsedData.map { line in
            return line
                .map { Tree(height: $0.wholeNumberValue!,
                            maxHeights: (left: -1, right: -1, top: -1, bottom: -1),
                            visibility: (left: 0, right: 0, top: 0, bottom: 0)) }
        }
    }
    
    public static func print2DArray(_ array: [[Any]]) {
        array.forEach { print($0) }
    }
    
    public static func computeA() {
        var forest = Task8.loadForest()

        // Left to right
        for x in 0..<forest.count {
            for y in 1..<forest[x].count {
                let neighbour = forest[x][y-1]
                forest[x][y].maxHeights.left = max(neighbour.maxHeights.left, neighbour.height)
            }
        }

        // Right to left
        for x in 0..<forest.count {
            for y in (0..<forest[x].count-1).reversed() {
                let neighbour = forest[x][y+1]
                forest[x][y].maxHeights.right = max(neighbour.maxHeights.right, neighbour.height)
            }
        }

        // Top to bottom
        for x in 1..<forest.count {
            for y in 0..<forest[x].count {
                let neighbour = forest[x-1][y]
                forest[x][y].maxHeights.top = max(neighbour.maxHeights.top, neighbour.height)
            }
        }

        // Bottom to top
        for x in (0..<forest.count-1).reversed() {
            for y in 0..<forest[x].count {
                let neighbour = forest[x+1][y]
                forest[x][y].maxHeights.bottom = max(neighbour.maxHeights.bottom, neighbour.height)
            }
        }

        let visibleTreesCount = forest.map { row in
            row.filter { $0.isVisible }.count
        }.reduce(0, +)

        print("There are \(visibleTreesCount) visible trees")
    }
    
    public static func computeB() {
        var forest = Task8.loadForest()

        class VisibilityCache {
            public static var heights = [
                0: 0, 1: 0, 2: 0, 3: 0, 4: 0, 5: 0, 6: 0, 7: 0, 8: 0, 9: 0
            ]
            
            public static func reset() {
                for index in heights.keys { heights[index] = 0 }
            }
            
            public static func evalTree(height: Int) {
                for (key, value) in heights {
                    if height >= key {
                        heights[key] = 1
                    } else {
                        heights[key] = value + 1
                    }
                }
            }
        }
        
        // Left to right
        for x in 0..<forest.count {
            for y in 0..<forest[x].count {
                let height = forest[x][y].height
                forest[x][y].visibility.left = VisibilityCache.heights[height]!
                VisibilityCache.evalTree(height: height)
            }
            VisibilityCache.reset()
        }


        // Right to left
        for x in 0..<forest.count {
            for y in (0..<forest[x].count).reversed() {
                let height = forest[x][y].height
                forest[x][y].visibility.right = VisibilityCache.heights[height]!
                VisibilityCache.evalTree(height: height)
            }
            VisibilityCache.reset()
        }

        // Top to bottom
        for y in 0..<forest.first!.count {
            for x in 0..<forest.count {
                let height = forest[x][y].height
                forest[x][y].visibility.top = VisibilityCache.heights[height]!
                VisibilityCache.evalTree(height: height)
            }
            VisibilityCache.reset()
        }

        // Bottom to top
        for y in 0..<forest.first!.count {
            for x in (0..<forest.count).reversed() {
                let height = forest[x][y].height
                forest[x][y].visibility.bottom = VisibilityCache.heights[height]!
                VisibilityCache.evalTree(height: height)
            }
            VisibilityCache.reset()
        }

        let maxScenicScore = forest
            .map { $0.max(by: { $0.scenicScore < $1.scenicScore })!.scenicScore }
            .max()!

        print("Biggest scenic score is \(maxScenicScore)")
    }
    
}

public func print2DArray(_ array: [[CustomStringConvertible]]) {
    array.forEach { row in
        print(row.map { String(describing: $0) }.joined())
    }
}
