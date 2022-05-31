import XCTest
@testable import Approximate


final class RelativeEqFloatTests: XCTestCase {
    func testBasicEq() {
        XCTAssert(relativeEq(Float(1.0), Float(1.0)))
        XCTAssert(relativeNe(Float(1.0), Float(2.0)))
    }

    func testBasicNe() {
        XCTAssert(relativeNe(Float(1.0), Float(2.0)))
    }

    func testBig() {
        XCTAssert(relativeEq(Float(100000000.0), Float(100000001.0)))
        XCTAssert(relativeEq(Float(100000001.0), Float(100000000.0)))
        XCTAssert(relativeNe(Float(10000.0), Float(10001.0)))
        XCTAssert(relativeNe(Float(10001.0), Float(10000.0)))
    }

    func testBigNeg() {
        XCTAssert(relativeEq(Float(-100000000.0), Float(-100000001.0)))
        XCTAssert(relativeEq(Float(-100000001.0), Float(-100000000.0)))
        XCTAssert(relativeNe(Float(-10000.0), Float(-10001.0)))
        XCTAssert(relativeNe(Float(-10001.0), Float(-10000.0)))
    }

    func testMid() {
        XCTAssert(relativeEq(Float(1.0000001), Float(1.0000002)))
        XCTAssert(relativeEq(Float(1.0000002), Float(1.0000001)))
        XCTAssert(relativeNe(Float(1.000001), Float(1.000002)))
        XCTAssert(relativeNe(Float(1.000002), Float(1.000001)))
    }

    func testMidNeg() {
        XCTAssert(relativeEq(Float(-1.0000001), Float(-1.0000002)))
        XCTAssert(relativeEq(Float(-1.0000002), Float(-1.0000001)))
        XCTAssert(relativeNe(Float(-1.000001), Float(-1.000002)))
        XCTAssert(relativeNe(Float(-1.000002), Float(-1.000001)))
    }

    func testSmall() {
        XCTAssert(relativeEq(Float(0.000010001), Float(0.000010002)))
        XCTAssert(relativeEq(Float(0.000010002), Float(0.000010001)))
        XCTAssert(relativeNe(Float(0.000001002), Float(0.0000001001)))
        XCTAssert(relativeNe(Float(0.000001001), Float(0.0000001002)))
    }

    func testSmallNeg() {
        XCTAssert(relativeEq(Float(-0.000010001), Float(-0.000010002)))
        XCTAssert(relativeEq(Float(-0.000010002), Float(-0.000010001)))
        XCTAssert(relativeNe(Float(-0.000001002), Float(-0.0000001001)))
        XCTAssert(relativeNe(Float(-0.000001001), Float(-0.0000001002)))
    }

    func testZero() {
        XCTAssert(relativeEq(Float(0.0), Float(0.0)))
        XCTAssert(relativeEq(Float(0.0), Float(-0.0)))
        XCTAssert(relativeEq(Float(-0.0), Float(-0.0)))

        XCTAssert(relativeNe(Float(0.000001), Float(0.0)))
        XCTAssert(relativeNe(Float(0.0), Float(0.000001)))
        XCTAssert(relativeNe(Float(-0.000001), Float(0.0)))
        XCTAssert(relativeNe(Float(0.0), Float(-0.000001)))
    }

    func testTolerance() {
        XCTAssert(relativeEq(Float(0.0), Float(1e-40), tolerance: Float(1e-40)))
        XCTAssert(relativeEq(Float(1e-40), Float(0.0), tolerance: Float(1e-40)))
        XCTAssert(relativeEq(Float(0.0), Float(-1e-40), tolerance: Float(1e-40)))
        XCTAssert(relativeEq(Float(-1e-40), Float(0.0), tolerance: Float(1e-40)))

        XCTAssert(relativeNe(Float(1e-40), Float(0.0), tolerance: Float(1e-41)))
        XCTAssert(relativeNe(Float(0.0), Float(1e-40), tolerance: Float(1e-41)))
        XCTAssert(relativeNe(Float(-1e-40), Float(0.0), tolerance: Float(1e-41)))
        XCTAssert(relativeNe(Float(0.0), Float(-1e-40), tolerance: Float(1e-41)))
    }

    func testMax() {
        XCTAssert(relativeEq(Float.greatestFiniteMagnitude, Float.greatestFiniteMagnitude))
        XCTAssert(relativeNe(Float.greatestFiniteMagnitude, -Float.greatestFiniteMagnitude))
        XCTAssert(relativeNe(-Float.greatestFiniteMagnitude, Float.greatestFiniteMagnitude))
        XCTAssert(relativeNe(
            Float.greatestFiniteMagnitude,
            Float.greatestFiniteMagnitude / Float(2.0)
        ))
        XCTAssert(relativeNe(
             Float.greatestFiniteMagnitude,
            -Float.greatestFiniteMagnitude / Float(2.0)
        ))
        XCTAssert(relativeNe(
            -Float.greatestFiniteMagnitude,
             Float.greatestFiniteMagnitude / Float(2.0)
        ))
    }

    func testInfinity() {
        XCTAssert(relativeEq(Float.infinity, Float.infinity))
        XCTAssert(relativeEq(-Float.infinity, -Float.infinity))
        XCTAssert(relativeNe(-Float.infinity, Float.infinity))
    }

    func testZeroInfinity() {
        XCTAssert(relativeNe(Float(0), Float.infinity))
        XCTAssert(relativeNe(Float(0), -Float.infinity))
    }

    func testNAN() {
        XCTAssert(relativeNe(Float.nan, Float.nan))

        XCTAssert(relativeNe(Float.nan, Float(0.0)))
        XCTAssert(relativeNe(Float(-0.0), Float.nan))
        XCTAssert(relativeNe(Float.nan, Float(-0.0)))
        XCTAssert(relativeNe(Float(0.0), Float.nan))

        XCTAssert(relativeNe(Float.nan, Float.infinity))
        XCTAssert(relativeNe(Float.infinity, Float.nan))
        XCTAssert(relativeNe(Float.nan, -Float.infinity))
        XCTAssert(relativeNe(-Float.infinity, Float.nan))

        XCTAssert(relativeNe(Float.nan, Float.greatestFiniteMagnitude))
        XCTAssert(relativeNe(Float.greatestFiniteMagnitude, Float.nan))
        XCTAssert(relativeNe(Float.nan, -Float.greatestFiniteMagnitude))
        XCTAssert(relativeNe(-Float.greatestFiniteMagnitude, Float.nan))

        XCTAssert(relativeNe(Float.nan, Float.leastNonzeroMagnitude))
        XCTAssert(relativeNe(Float.leastNonzeroMagnitude, Float.nan))
        XCTAssert(relativeNe(Float.nan, -Float.leastNonzeroMagnitude))
        XCTAssert(relativeNe(-Float.leastNonzeroMagnitude, Float.nan))
    }

    func testOppositeSigns() {
        XCTAssert(relativeNe(Float(1.000000001), Float(-1.0)))
        XCTAssert(relativeNe(Float(-1.0), Float(1.000000001)))
        XCTAssert(relativeNe(Float(-1.000000001), Float(1.0)))
        XCTAssert(relativeNe(Float(1.0), Float(-1.000000001)))

        XCTAssert(relativeEq(
            Float(10.0) *  Float.leastNonzeroMagnitude,
            Float(10.0) * -Float.leastNonzeroMagnitude
        ))
    }

    func testCloseToZero() {
        XCTAssert(relativeEq(Float.leastNonzeroMagnitude, Float.leastNonzeroMagnitude))
        XCTAssert(relativeEq(Float.leastNonzeroMagnitude, -Float.leastNonzeroMagnitude))
        XCTAssert(relativeEq(-Float.leastNonzeroMagnitude, Float.leastNonzeroMagnitude))

        XCTAssert(relativeEq(Float.leastNonzeroMagnitude, Float(0.0)))
        XCTAssert(relativeEq(Float(0.0), Float.leastNonzeroMagnitude))
        XCTAssert(relativeEq(-Float.leastNonzeroMagnitude, Float(0.0)))
        XCTAssert(relativeEq(Float(0.0), -Float.leastNonzeroMagnitude))

        XCTAssert(relativeNe(Float(0.000001), -Float.leastNonzeroMagnitude))
        XCTAssert(relativeNe(Float(0.000001), Float.leastNonzeroMagnitude))
        XCTAssert(relativeNe(Float.leastNonzeroMagnitude, Float(0.000001)))
        XCTAssert(relativeNe(-Float.leastNonzeroMagnitude, Float(0.000001)))
    }
}


final class RelativeEqDoubleTests: XCTestCase {
    func testBasicEq() {
        XCTAssert(relativeEq(Double(1.0), Double(1.0)))
        XCTAssert(relativeNe(Double(1.0), Double(2.0)))
    }

    func testBasicNe() {
        XCTAssert(relativeNe(Double(1.0), Double(2.0)))
    }

    func testBig() {
        XCTAssert(relativeEq(Double(10000000000000000.0), Double(10000000000000001.0)))
        XCTAssert(relativeEq(Double(10000000000000001.0), Double(10000000000000000.0)))
        XCTAssert(relativeNe(Double(1000000000000000.0), Double(1000000000000001.0)))
        XCTAssert(relativeNe(Double(1000000000000001.0), Double(1000000000000000.0)))
    }

    func testBigNeg() {
        XCTAssert(relativeEq(Double(-10000000000000000.0), Double(-10000000000000001.0)))
        XCTAssert(relativeEq(Double(-10000000000000001.0), Double(-10000000000000000.0)))
        XCTAssert(relativeNe(Double(-1000000000000000.0), Double(-1000000000000001.0)))
        XCTAssert(relativeNe(Double(-1000000000000001.0), Double(-1000000000000000.0)))
    }

    func testMid() {
        XCTAssert(relativeEq(Double(1.0000000000000001), Double(1.0000000000000002)))
        XCTAssert(relativeEq(Double(1.0000000000000002), Double(1.0000000000000001)))
        XCTAssert(relativeNe(Double(1.000000000000001), Double(1.000000000000002)))
        XCTAssert(relativeNe(Double(1.000000000000002), Double(1.000000000000001)))
    }

    func testMidNeg() {
        XCTAssert(relativeEq(Double(-1.0000000000000001), Double(-1.0000000000000002)))
        XCTAssert(relativeEq(Double(-1.0000000000000002), Double(-1.0000000000000001)))
        XCTAssert(relativeNe(Double(-1.000000000000001), Double(-1.000000000000002)))
        XCTAssert(relativeNe(Double(-1.000000000000002), Double(-1.000000000000001)))
    }

    func testSmall() {
        XCTAssert(relativeEq(Double(0.0000000100000001), Double(0.0000000100000002)))
        XCTAssert(relativeEq(Double(0.0000000100000002), Double(0.0000000100000001)))
        XCTAssert(relativeNe(Double(0.0000000100000001), Double(0.0000000010000002)))
        XCTAssert(relativeNe(Double(0.0000000100000002), Double(0.0000000010000001)))
    }

    func testSmallNeg() {
        XCTAssert(relativeEq(Double(-0.0000000100000001), Double(-0.0000000100000002)))
        XCTAssert(relativeEq(Double(-0.0000000100000002), Double(-0.0000000100000001)))
        XCTAssert(relativeNe(Double(-0.0000000100000001), Double(-0.0000000010000002)))
        XCTAssert(relativeNe(Double(-0.0000000100000002), Double(-0.0000000010000001)))
    }

    func testZero() {
        XCTAssert(relativeEq(Double(0.0), Double(0.0)))
        XCTAssert(relativeEq(Double(0.0), Double(-0.0)))
        XCTAssert(relativeEq(Double(-0.0), Double(-0.0)))

        XCTAssert(relativeNe(Double(0.000000000000001), Double(0.0)))
        XCTAssert(relativeNe(Double(0.0), Double(0.000000000000001)))
        XCTAssert(relativeNe(Double(-0.000000000000001), Double(0.0)))
        XCTAssert(relativeNe(Double(0.0), Double(-0.000000000000001)))
    }

    func testTolerance() {
        XCTAssert(relativeEq(Double(0.0), Double(1e-40), tolerance: Double(1e-40)))
        XCTAssert(relativeEq(Double(1e-40), Double(0.0), tolerance: Double(1e-40)))
        XCTAssert(relativeEq(Double(0.0), Double(-1e-40), tolerance: Double(1e-40)))
        XCTAssert(relativeEq(Double(-1e-40), Double(0.0), tolerance: Double(1e-40)))

        XCTAssert(relativeNe(Double(1e-40), Double(0.0), tolerance: Double(1e-41)))
        XCTAssert(relativeNe(Double(0.0), Double(1e-40), tolerance: Double(1e-41)))
        XCTAssert(relativeNe(Double(-1e-40), Double(0.0), tolerance: Double(1e-41)))
        XCTAssert(relativeNe(Double(0.0), Double(-1e-40), tolerance: Double(1e-41)))
    }

    func testMax() {
        XCTAssert(relativeEq(Double.greatestFiniteMagnitude, Double.greatestFiniteMagnitude))
        XCTAssert(relativeNe(Double.greatestFiniteMagnitude, -Double.greatestFiniteMagnitude))
        XCTAssert(relativeNe(-Double.greatestFiniteMagnitude, Double.greatestFiniteMagnitude))
        XCTAssert(relativeNe(
            Double.greatestFiniteMagnitude,
            Double.greatestFiniteMagnitude / Double(2.0)
        ))
        XCTAssert(relativeNe(
             Double.greatestFiniteMagnitude,
            -Double.greatestFiniteMagnitude / Double(2.0)
        ))
        XCTAssert(relativeNe(
            -Double.greatestFiniteMagnitude,
             Double.greatestFiniteMagnitude / Double(2.0)
        ))
    }

    func testInfinity() {
        XCTAssert(relativeEq(Double.infinity, Double.infinity))
        XCTAssert(relativeEq(-Double.infinity, -Double.infinity))
        XCTAssert(relativeNe(-Double.infinity, Double.infinity))
    }

    func testNAN() {
        XCTAssert(relativeNe(Double.nan, Double.nan))

        XCTAssert(relativeNe(Double.nan, Double(0.0)))
        XCTAssert(relativeNe(Double(-0.0), Double.nan))
        XCTAssert(relativeNe(Double.nan, Double(-0.0)))
        XCTAssert(relativeNe(Double(0.0), Double.nan))

        XCTAssert(relativeNe(Double.nan, Double.infinity))
        XCTAssert(relativeNe(Double.infinity, Double.nan))
        XCTAssert(relativeNe(Double.nan, -Double.infinity))
        XCTAssert(relativeNe(-Double.infinity, Double.nan))

        XCTAssert(relativeNe(Double.nan, Double.greatestFiniteMagnitude))
        XCTAssert(relativeNe(Double.greatestFiniteMagnitude, Double.nan))
        XCTAssert(relativeNe(Double.nan, -Double.greatestFiniteMagnitude))
        XCTAssert(relativeNe(-Double.greatestFiniteMagnitude, Double.nan))

        XCTAssert(relativeNe(Double.nan, Double.leastNonzeroMagnitude))
        XCTAssert(relativeNe(Double.leastNonzeroMagnitude, Double.nan))
        XCTAssert(relativeNe(Double.nan, -Double.leastNonzeroMagnitude))
        XCTAssert(relativeNe(-Double.leastNonzeroMagnitude, Double.nan))
    }

    func testOppositeSigns() {
        XCTAssert(relativeNe(Double(1.000000001), Double(-1.0)))
        XCTAssert(relativeNe(Double(-1.0), Double(1.000000001)))
        XCTAssert(relativeNe(Double(-1.000000001), Double(1.0)))
        XCTAssert(relativeNe(Double(1.0), Double(-1.000000001)))

        XCTAssert(relativeEq(
            Double(10.0) *  Double.leastNonzeroMagnitude,
            Double(10.0) * -Double.leastNonzeroMagnitude
        ))
    }

    func testCloseToZero() {
        XCTAssert(relativeEq(Double.leastNonzeroMagnitude, Double.leastNonzeroMagnitude))
        XCTAssert(relativeEq(Double.leastNonzeroMagnitude, -Double.leastNonzeroMagnitude))
        XCTAssert(relativeEq(-Double.leastNonzeroMagnitude, Double.leastNonzeroMagnitude))

        XCTAssert(relativeEq(Double.leastNonzeroMagnitude, Double(0.0)))
        XCTAssert(relativeEq(Double(0.0), Double.leastNonzeroMagnitude))
        XCTAssert(relativeEq(-Double.leastNonzeroMagnitude, Double(0.0)))
        XCTAssert(relativeEq(Double(0.0), -Double.leastNonzeroMagnitude))

        XCTAssert(relativeNe(Double(0.000000000000001), -Double.leastNonzeroMagnitude))
        XCTAssert(relativeNe(Double(0.000000000000001), Double.leastNonzeroMagnitude))
        XCTAssert(relativeNe(Double.leastNonzeroMagnitude, Double(0.000000000000001)))
        XCTAssert(relativeNe(-Double.leastNonzeroMagnitude, Double(0.000000000000001)))
    }
}

