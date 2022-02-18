import XCTest
import CRDTs

class GCounterTests: XCTestCase {
//    func testMax() {
//        for _ in 0..<testCycles {
//            let a = Max(Int.random())
//            let b = Max(Int.random())
//            let c = Max(Int.random())
//            XCTAssertEqual(a.merged(b), b.merged(a))
//            XCTAssertEqual(a.merged(a), a)
//            XCTAssertEqual((a.merged(b)).merged(c), a.merged(b.merged(c)))
//        }
//    }
    
    func testBehavior() {
        var a = GCounter(10)
        var b = GCounter(0)
        b.merge(a)
        XCTAssertEqual(b.value, 10)
        a += 1
        b += 1
        a.merge(b)
        b.merge(a)
        XCTAssertEqual(a.value, 12)
        XCTAssertEqual(b.value, 12)
    }
}
