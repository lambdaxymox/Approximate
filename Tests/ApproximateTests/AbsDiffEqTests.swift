import XCTest
@testable import Approximate


final class AbsDiffEqFloatTests: XCTestCase {
    func testBasicEq() {
        XCTAssert(absDiffEq(Float(1.0), Float(1.0)))
        XCTAssert(absDiffNe(Float(1.0), Float(2.0)))
    }

    func testBasicNe() {
        XCTAssert(absDiffNe(Float(1.0), Float(2.0)))
    }

    func testBig() {
        XCTAssert(absDiffEq(Float(100000000.0), Float(100000001.0)))
        XCTAssert(absDiffEq(Float(100000001.0), Float(100000000.0)))
        XCTAssert(absDiffNe(Float(10000.0), Float(10001.0)))
        XCTAssert(absDiffNe(Float(10001.0), Float(10000.0)))
    }

    func testBigNeg() {
        XCTAssert(absDiffEq(Float(-100000000.0), Float(-100000001.0)))
        XCTAssert(absDiffEq(Float(-100000001.0), Float(-100000000.0)))
        XCTAssert(absDiffNe(Float(-10000.0), Float(-10001.0)))
        XCTAssert(absDiffNe(Float(-10001.0), Float(-10000.0)))
    }

    func testMid() {
        XCTAssert(absDiffEq(Float(1.0000001), Float(1.0000002)))
        XCTAssert(absDiffEq(Float(1.0000002), Float(1.0000001)))
        XCTAssert(absDiffNe(Float(1.000001), Float(1.000002)))
        XCTAssert(absDiffNe(Float(1.000002), Float(1.000001)))
    }

    func testMidNeg() {
        XCTAssert(absDiffEq(Float(-1.0000001), Float(-1.0000002)))
        XCTAssert(absDiffEq(Float(-1.0000002), Float(-1.0000001)))
        XCTAssert(absDiffNe(Float(-1.000001), Float(-1.000002)))
        XCTAssert(absDiffNe(Float(-1.000002), Float(-1.000001)))
    }

    func testSmall() {
        XCTAssert(absDiffEq(Float(0.000010001), Float(0.000010002)))
        XCTAssert(absDiffEq(Float(0.000010002), Float(0.000010001)))
        XCTAssert(absDiffNe(Float(0.000001002), Float(0.0000001001)))
        XCTAssert(absDiffNe(Float(0.000001001), Float(0.0000001002)))
    }

    func testSmallNeg() {
        XCTAssert(absDiffEq(Float(-0.000010001), Float(-0.000010002)))
        XCTAssert(absDiffEq(Float(-0.000010002), Float(-0.000010001)))
        XCTAssert(absDiffNe(Float(-0.000001002), Float(-0.0000001001)))
        XCTAssert(absDiffNe(Float(-0.000001001), Float(-0.0000001002)))
    }

    func testZero() {
        XCTAssert(absDiffEq(Float(0.0), Float(0.0)))
        XCTAssert(absDiffEq(Float(0.0), Float(-0.0)))
        XCTAssert(absDiffEq(Float(-0.0), Float(-0.0)))

        XCTAssert(absDiffNe(Float(0.000001), Float(0.0)))
        XCTAssert(absDiffNe(Float(0.0), Float(0.000001)))
        XCTAssert(absDiffNe(Float(-0.000001), Float(0.0)))
        XCTAssert(absDiffNe(Float(0.0), Float(-0.000001)))
    }

    func testTolerance() {
        XCTAssert(absDiffEq(Float(0.0), Float(1e-40), tolerance: 1e-40))
        XCTAssert(absDiffEq(Float(1e-40), Float(0.0), tolerance: 1e-40))
        XCTAssert(absDiffEq(Float(0.0), Float(-1e-40), tolerance: 1e-40))
        XCTAssert(absDiffEq(Float(-1e-40), Float(0.0), tolerance: 1e-40))

        XCTAssert(absDiffNe(Float(1e-40), Float(0.0), tolerance: 1e-41))
        XCTAssert(absDiffNe(Float(0.0), Float(1e-40), tolerance: 1e-41))
        XCTAssert(absDiffNe(Float(-1e-40), Float(0.0), tolerance: 1e-41))
        XCTAssert(absDiffNe(Float(0.0), Float(-1e-40), tolerance: 1e-41))
    }

    func testMax() {
        XCTAssert(absDiffEq(Float.greatestFiniteMagnitude, Float.greatestFiniteMagnitude))
        XCTAssert(absDiffNe(Float.greatestFiniteMagnitude, -Float.greatestFiniteMagnitude))
        XCTAssert(absDiffNe((-Float.greatestFiniteMagnitude), Float.greatestFiniteMagnitude))
        XCTAssert(absDiffNe(Float.greatestFiniteMagnitude, Float.greatestFiniteMagnitude / Float(2.0)))
        XCTAssert(absDiffNe(Float.greatestFiniteMagnitude, -Float.greatestFiniteMagnitude / Float(2.0)))
        XCTAssert(absDiffNe(-Float.greatestFiniteMagnitude, Float.greatestFiniteMagnitude / Float(2.0)))
    }

    func testNAN() {
        XCTAssert(absDiffNe(Float.nan, Float.nan))

        XCTAssert(absDiffNe(Float.nan, Float(0.0)))
        XCTAssert(absDiffNe(Float(-0.0), Float.nan))
        XCTAssert(absDiffNe(Float.nan, Float(-0.0)))
        XCTAssert(absDiffNe(Float(0.0), Float.nan))

        XCTAssert(absDiffNe(Float.nan, Float.infinity))
        XCTAssert(absDiffNe(Float.infinity, Float.nan))
        XCTAssert(absDiffNe(Float.nan, -Float.infinity))
        XCTAssert(absDiffNe(-Float.infinity, Float.nan))

        XCTAssert(absDiffNe(Float.nan, Float.greatestFiniteMagnitude))
        XCTAssert(absDiffNe(Float.greatestFiniteMagnitude, Float.nan))
        XCTAssert(absDiffNe(Float.nan, -Float.greatestFiniteMagnitude))
        XCTAssert(absDiffNe(-Float.greatestFiniteMagnitude, Float.nan))

        XCTAssert(absDiffNe(Float.nan, Float.leastNonzeroMagnitude))
        XCTAssert(absDiffNe(Float.leastNonzeroMagnitude, Float.nan))
        XCTAssert(absDiffNe(Float.nan, -Float.leastNonzeroMagnitude))
        XCTAssert(absDiffNe(-Float.leastNonzeroMagnitude, Float.nan))
    }


    func testOppositeSigns() {
        XCTAssert(absDiffNe(Float(1.000000001), Float(-1.0)))
        XCTAssert(absDiffNe(Float(-1.0), Float(1.000000001)))
        XCTAssert(absDiffNe(Float(-1.000000001), Float(1.0)))
        XCTAssert(absDiffNe(Float(1.0), Float(-1.000000001)))
        XCTAssert(absDiffEq(
            Float(10.0) * Float.leastNonzeroMagnitude,
            Float(10.0) * -Float.leastNonzeroMagnitude
        ))
    }


    func testCloseToZero() {
        XCTAssert(absDiffEq(Float.leastNonzeroMagnitude, Float.leastNonzeroMagnitude))
        XCTAssert(absDiffEq(Float.leastNonzeroMagnitude, -Float.leastNonzeroMagnitude))
        XCTAssert(absDiffEq(-Float.leastNonzeroMagnitude, Float.leastNonzeroMagnitude))

        XCTAssert(absDiffEq(Float.leastNonzeroMagnitude, Float(0.0)))
        XCTAssert(absDiffEq(Float(0.0), Float.leastNonzeroMagnitude))
        XCTAssert(absDiffEq(-Float.leastNonzeroMagnitude, Float(0.0)))
        XCTAssert(absDiffEq(Float(0.0), -Float.leastNonzeroMagnitude))

        XCTAssert(absDiffNe(Float(0.000001), -Float.leastNonzeroMagnitude))
        XCTAssert(absDiffNe(Float(0.000001), Float.leastNonzeroMagnitude))
        XCTAssert(absDiffNe(Float.leastNonzeroMagnitude, Float(0.000001)))
        XCTAssert(absDiffNe(-Float.leastNonzeroMagnitude, Float(0.000001)))
    }
}


final class AbsDiffEqDoubleTests: XCTestCase {
    func testBasicEq() {
        XCTAssert(absDiffEq(Double(1.0), Double(1.0)))
        XCTAssert(absDiffNe(Double(1.0), Double(2.0)))
    }

    func testBasicNe() {
        XCTAssert(absDiffNe(Double(1.0), Double(2.0)))
    }

    func testBig() {
        XCTAssert(absDiffEq(Double(10000000000000000.0), Double(10000000000000001.0)))
        XCTAssert(absDiffEq(Double(10000000000000001.0), Double(10000000000000000.0)))
        XCTAssert(absDiffNe(Double(1000000000000000.0), Double(1000000000000001.0)))
        XCTAssert(absDiffNe(Double(1000000000000001.0), Double(1000000000000000.0)))
    }

    func testBigNeg() {
        XCTAssert(absDiffEq(Double(-10000000000000000.0), Double(-10000000000000001.0)))
        XCTAssert(absDiffEq(Double(-10000000000000001.0), Double(-10000000000000000.0)))
        XCTAssert(absDiffNe(Double(-1000000000000000.0), Double(-1000000000000001.0)))
        XCTAssert(absDiffNe(Double(-1000000000000001.0), Double(-1000000000000000.0)))
    }

    func testMid() {
        XCTAssert(absDiffEq(Double(1.0000000000000001), Double(1.0000000000000002)))
        XCTAssert(absDiffEq(Double(1.0000000000000002), Double(1.0000000000000001)))
        XCTAssert(absDiffNe(Double(1.000000000000001), Double(1.000000000000002)))
        XCTAssert(absDiffNe(Double(1.000000000000002), Double(1.000000000000001)))
    }

    func testMidNeg() {
        XCTAssert(absDiffEq(Double(-1.0000000000000001), Double(-1.0000000000000002)))
        XCTAssert(absDiffEq(Double(-1.0000000000000002), Double(-1.0000000000000001)))
        XCTAssert(absDiffNe(Double(-1.000000000000001), Double(-1.000000000000002)))
        XCTAssert(absDiffNe(Double(-1.000000000000002), Double(-1.000000000000001)))
    }

    func testSmall() {
        XCTAssert(absDiffEq(Double(0.0000000100000001), Double(0.0000000100000002)))
        XCTAssert(absDiffEq(Double(0.0000000100000002), Double(0.0000000100000001)))
        XCTAssert(absDiffNe(Double(0.0000000100000001), Double(0.0000000010000002)))
        XCTAssert(absDiffNe(Double(0.0000000100000002), Double(0.0000000010000001)))
    }

    func testSmallNeg() {
        XCTAssert(absDiffEq(Double(-0.0000000100000001), Double(-0.0000000100000002)))
        XCTAssert(absDiffEq(Double(-0.0000000100000002), Double(-0.0000000100000001)))
        XCTAssert(absDiffNe(Double(-0.0000000100000001), Double(-0.0000000010000002)))
        XCTAssert(absDiffNe(Double(-0.0000000100000002), Double(-0.0000000010000001)))
    }

    func testZero() {
        XCTAssert(absDiffEq(Double(0.0), Double(0.0)))
        XCTAssert(absDiffEq(Double(0.0), Double(-0.0)))
        XCTAssert(absDiffEq(Double(-0.0), Double(-0.0)))

        XCTAssert(absDiffNe(Double(0.000000000000001), Double(0.0)))
        XCTAssert(absDiffNe(Double(0.0), Double(0.000000000000001)))
        XCTAssert(absDiffNe(Double(-0.000000000000001), Double(0.0)))
        XCTAssert(absDiffNe(Double(0.0), Double(-0.000000000000001)))
    }

    func testTolerance() {
        XCTAssert(absDiffEq(Double(0.0), Double(1e-40), tolerance: 1e-40))
        XCTAssert(absDiffEq(Double(1e-40), Double(0.0), tolerance: 1e-40))
        XCTAssert(absDiffEq(Double(0.0), Double(-1e-40), tolerance: 1e-40))
        XCTAssert(absDiffEq(Double(-1e-40), Double(0.0), tolerance: 1e-40))

        XCTAssert(absDiffNe(Double(1e-40), Double(0.0), tolerance: 1e-41))
        XCTAssert(absDiffNe(Double(0.0), Double(1e-40), tolerance: 1e-41))
        XCTAssert(absDiffNe(Double(-1e-40), Double(0.0), tolerance: 1e-41))
        XCTAssert(absDiffNe(Double(0.0), Double(-1e-40), tolerance: 1e-41))
    }

    func testMax() {
        XCTAssert(absDiffEq(Double.greatestFiniteMagnitude, Double.greatestFiniteMagnitude))
        XCTAssert(absDiffNe(Double.greatestFiniteMagnitude, -Double.greatestFiniteMagnitude))
        XCTAssert(absDiffNe(-Double.greatestFiniteMagnitude, Double.greatestFiniteMagnitude))
        XCTAssert(absDiffNe(Double.greatestFiniteMagnitude, Double.greatestFiniteMagnitude / Double(2.0)))
        XCTAssert(absDiffNe(Double.greatestFiniteMagnitude, -Double.greatestFiniteMagnitude / Double(2.0)))
        XCTAssert(absDiffNe(-Double.greatestFiniteMagnitude, Double.greatestFiniteMagnitude / Double(2.0)))
    }

    func testNAN() {
        XCTAssert(absDiffNe(Double.nan, Double.nan))

        XCTAssert(absDiffNe(Double.nan, Double(0.0)))
        XCTAssert(absDiffNe(Double(-0.0), Double.nan))
        XCTAssert(absDiffNe(Double.nan, Double(-0.0)))
        XCTAssert(absDiffNe(Double(0.0), Double.nan))

        XCTAssert(absDiffNe(Double.nan, Double.infinity))
        XCTAssert(absDiffNe(Double.infinity, Double.nan))
        XCTAssert(absDiffNe(Double.nan, -Double.infinity))
        XCTAssert(absDiffNe(-Double.infinity, Double.nan))

        XCTAssert(absDiffNe(Double.nan, Double.greatestFiniteMagnitude))
        XCTAssert(absDiffNe(Double.greatestFiniteMagnitude, Double.nan))
        XCTAssert(absDiffNe(Double.nan, -Double.greatestFiniteMagnitude))
        XCTAssert(absDiffNe(-Double.greatestFiniteMagnitude, Double.nan))

        XCTAssert(absDiffNe(Double.nan, Double.leastNonzeroMagnitude))
        XCTAssert(absDiffNe(Double.leastNonzeroMagnitude, Double.nan))
        XCTAssert(absDiffNe(Double.nan, -Double.leastNonzeroMagnitude))
        XCTAssert(absDiffNe(-Double.leastNonzeroMagnitude, Double.nan))
    }

    func testOppositeSigns() {
        XCTAssert(absDiffNe(Double(1.000000001), Double(-1.0)))
        XCTAssert(absDiffNe(Double(-1.0), Double(1.000000001)))
        XCTAssert(absDiffNe(Double(-1.000000001), Double(1.0)))
        XCTAssert(absDiffNe(Double(1.0), Double(-1.000000001)))

        XCTAssert(absDiffEq(
            10.0 * Double.leastNonzeroMagnitude,
            10.0 * -Double.leastNonzeroMagnitude
        ))
    }

    func testCloseToZero() {
        XCTAssert(absDiffEq(Double.leastNonzeroMagnitude, Double.leastNonzeroMagnitude))
        XCTAssert(absDiffEq(Double.leastNonzeroMagnitude, -Double.leastNonzeroMagnitude))
        XCTAssert(absDiffEq(-Double.leastNonzeroMagnitude, Double.leastNonzeroMagnitude))

        XCTAssert(absDiffEq(Double.leastNonzeroMagnitude, Double(0.0)))
        XCTAssert(absDiffEq(Double(0.0), Double.leastNonzeroMagnitude))
        XCTAssert(absDiffEq(-Double.leastNonzeroMagnitude, Double(0.0)))
        XCTAssert(absDiffEq(Double(0.0), -Double.leastNonzeroMagnitude))

        XCTAssert(absDiffNe(Double(0.000000000000001), -Double.leastNonzeroMagnitude))
        XCTAssert(absDiffNe(Double(0.000000000000001), Double.leastNonzeroMagnitude))
        XCTAssert(absDiffNe(Double.leastNonzeroMagnitude, Double(0.000000000000001)))
        XCTAssert(absDiffNe(-Double.leastNonzeroMagnitude, Double(0.000000000000001)))
    }
}

