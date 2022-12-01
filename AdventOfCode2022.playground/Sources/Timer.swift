import SwiftUI

public class Timer {
    
    private static var times: [String: CFTimeInterval] = [:]
    
    public static func measure(name: String) {
        let time = CACurrentMediaTime()
        if let old = times[name] {
            print("\(name): \(time - old)")
        }
        times[name] = time
    }
    
}
