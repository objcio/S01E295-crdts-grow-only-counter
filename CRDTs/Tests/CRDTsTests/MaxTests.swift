import XCTest
import CRDTs

fileprivate let testCycles = 1000

extension Int {
    static func random() -> Int {
        Int.random(in: Int.min..<Int.max)
    }
}

class MaxTests: XCTestCase {
    func testMax() {
        for _ in 0..<testCycles {
            let a = Max(Int.random())
            let b = Max(Int.random())
            let c = Max(Int.random())
            XCTAssertEqual(a.merged(b), b.merged(a))
            XCTAssertEqual(a.merged(a), a)
            XCTAssertEqual((a.merged(b)).merged(c), a.merged(b.merged(c)))
        }
    }
    
    func testBehavior() {
        var a = Max(10)
        var b = Max(0)
        b.merge(a)
        XCTAssertEqual(b.value, 10)
        a.value += 1
        b.value += 1
        a.merge(b)
        b.merge(a)
        XCTAssertEqual(a.value, 11)
        XCTAssertEqual(b.value, 11)
    }
}
