import XCTest
@testable import Approximate


final class AbsDiffEqFloatTests: XCTestCase {
    func testBasicEq() {
        XCTAssert(Float(1.0).absDiffEq(Float(1.0)))
        XCTAssert(Float(1.0).absDiffNe(Float(2.0)))
    }

    func testBasicNe() {
        XCTAssert(1.0.absDiffNe(2.0))
    }

    func testBig() {
        XCTAssert(Float(100000000.0).absDiffEq(Float(100000001.0)))
        XCTAssert(Float(100000001.0).absDiffEq(Float(100000000.0)))
        XCTAssert(Float(10000.0).absDiffNe(Float(10001.0)))
        XCTAssert(Float(10001.0).absDiffNe(Float(10000.0)))
    }

    func testBigNeg() {
        XCTAssert(Float(-100000000.0).absDiffEq(Float(-100000001.0)))
        XCTAssert(Float(-100000001.0).absDiffEq(Float(-100000000.0)))
        XCTAssert(Float(-10000.0).absDiffNe(Float(-10001.0)))
        XCTAssert(Float(-10001.0).absDiffNe(Float(-10000.0)))
    }

    func testMid() {
        XCTAssert(Float(1.0000001).absDiffEq(Float(1.0000002)))
        XCTAssert(Float(1.0000002).absDiffEq(Float(1.0000001)))
        XCTAssert(Float(1.000001).absDiffNe(Float(1.000002)))
        XCTAssert(Float(1.000002).absDiffNe(Float(1.000001)))
    }

    func testMidNeg() {
        XCTAssert(Float(-1.0000001).absDiffEq(Float(-1.0000002)))
        XCTAssert(Float(-1.0000002).absDiffEq(Float(-1.0000001)))
        XCTAssert(Float(-1.000001).absDiffNe(Float(-1.000002)))
        XCTAssert(Float(-1.000002).absDiffNe(Float(-1.000001)))
    }

    func testSmall() {
        XCTAssert(Float(0.000010001).absDiffEq(Float(0.000010002)))
        XCTAssert(Float(0.000010002).absDiffEq(Float(0.000010001)))
        XCTAssert(Float(0.000001002).absDiffNe(Float(0.0000001001)))
        XCTAssert(Float(0.000001001).absDiffNe(Float(0.0000001002)))
    }

    func testSmallNeg() {
        XCTAssert(Float(-0.000010001).absDiffEq(Float(-0.000010002)))
        XCTAssert(Float(-0.000010002).absDiffEq(Float(-0.000010001)))
        XCTAssert(Float(-0.000001002).absDiffNe(Float(-0.0000001001)))
        XCTAssert(Float(-0.000001001).absDiffNe(Float(-0.0000001002)))
    }

    func testZero() {
        XCTAssert(Float(0.0).absDiffEq(Float(0.0)))
        XCTAssert(Float(0.0).absDiffEq(Float(-0.0)))
        XCTAssert(Float(-0.0).absDiffEq(Float(-0.0)))

        XCTAssert(Float(0.000001).absDiffNe(Float(0.0)))
        XCTAssert(Float(0.0).absDiffNe(Float(0.000001)))
        XCTAssert(Float(-0.000001).absDiffNe(Float(0.0)))
        XCTAssert(Float(0.0).absDiffNe(Float(-0.000001)))
    }

    func testTolerance() {
        XCTAssert(Float(0.0).absDiffEq(Float(1e-40), tolerance: 1e-40))
        XCTAssert(Float(1e-40).absDiffEq(Float(0.0), tolerance: 1e-40))
        XCTAssert(Float(0.0).absDiffEq(Float(-1e-40), tolerance: 1e-40))
        XCTAssert(Float(-1e-40).absDiffEq(Float(0.0), tolerance: 1e-40))

        XCTAssert(Float(1e-40).absDiffNe(Float(0.0), tolerance: 1e-41))
        XCTAssert(Float(0.0).absDiffNe(Float(1e-40), tolerance: 1e-41))
        XCTAssert(Float(-1e-40).absDiffNe(Float(0.0), tolerance: 1e-41))
        XCTAssert(Float(0.0).absDiffNe(Float(-1e-40), tolerance: 1e-41))
    }

    func testMax() {
        XCTAssert(Float.greatestFiniteMagnitude.absDiffEq(Float.greatestFiniteMagnitude))
        XCTAssert(Float.greatestFiniteMagnitude.absDiffNe(-Float.greatestFiniteMagnitude))
        XCTAssert((-Float.greatestFiniteMagnitude).absDiffNe(Float.greatestFiniteMagnitude))
        XCTAssert(Float.greatestFiniteMagnitude.absDiffNe(Float.greatestFiniteMagnitude / Float(2.0)))
        XCTAssert(Float.greatestFiniteMagnitude.absDiffNe(-Float.greatestFiniteMagnitude / Float(2.0)))
        XCTAssert((-Float.greatestFiniteMagnitude).absDiffNe(Float.greatestFiniteMagnitude / Float(2.0)))
    }

    func testNAN() {
        XCTAssert(Float.nan.absDiffNe(Float.nan))

        XCTAssert(Float.nan.absDiffNe(Float(0.0)))
        XCTAssert(Float(-0.0).absDiffNe(Float.nan))
        XCTAssert(Float.nan.absDiffNe(Float(-0.0)))
        XCTAssert(Float(0.0).absDiffNe(Float.nan))

        XCTAssert(Float.nan.absDiffNe(Float.infinity))
        XCTAssert(Float.infinity.absDiffNe(Float.nan))
        XCTAssert(Float.nan.absDiffNe(-Float.infinity))
        XCTAssert((-Float.infinity).absDiffNe(Float.nan))

        XCTAssert(Float.nan.absDiffNe(Float.greatestFiniteMagnitude))
        XCTAssert(Float.greatestFiniteMagnitude.absDiffNe(Float.nan))
        XCTAssert(Float.nan.absDiffNe(-Float.greatestFiniteMagnitude))
        XCTAssert((-Float.greatestFiniteMagnitude).absDiffNe(Float.nan))

        XCTAssert(Float.nan.absDiffNe(Float.leastNonzeroMagnitude))
        XCTAssert(Float.leastNonzeroMagnitude.absDiffNe(Float.nan))
        XCTAssert(Float.nan.absDiffNe(-Float.leastNonzeroMagnitude))
        XCTAssert((-Float.leastNonzeroMagnitude).absDiffNe(Float.nan))
    }


    func testOppositeSigns() {
        XCTAssert(Float(1.000000001).absDiffNe(Float(-1.0)))
        XCTAssert(Float(-1.0).absDiffNe(Float(1.000000001)))
        XCTAssert(Float(-1.000000001).absDiffNe(Float(1.0)))
        XCTAssert(Float(1.0).absDiffNe(Float(-1.000000001)))
        XCTAssert(
            (Float(10.0) * Float.leastNonzeroMagnitude).absDiffEq(
                Float(10.0) * -Float.leastNonzeroMagnitude
            )
        )
    }


    func testCloseToZero() {
        XCTAssert(Float.leastNonzeroMagnitude.absDiffEq(Float.leastNonzeroMagnitude))
        XCTAssert(Float.leastNonzeroMagnitude.absDiffEq(-Float.leastNonzeroMagnitude))
        XCTAssert((-Float.leastNonzeroMagnitude).absDiffEq(Float.leastNonzeroMagnitude))

        XCTAssert(Float.leastNonzeroMagnitude.absDiffEq(Float(0.0)))
        XCTAssert(Float(0.0).absDiffEq(Float.leastNonzeroMagnitude))
        XCTAssert((-Float.leastNonzeroMagnitude).absDiffEq(Float(0.0)))
        XCTAssert(Float(0.0).absDiffEq(-Float.leastNonzeroMagnitude))

        XCTAssert(Float(0.000001).absDiffNe(-Float.leastNonzeroMagnitude))
        XCTAssert(Float(0.000001).absDiffNe(Float.leastNonzeroMagnitude))
        XCTAssert(Float.leastNonzeroMagnitude.absDiffNe(Float(0.000001)))
        XCTAssert((-Float.leastNonzeroMagnitude).absDiffNe(Float(0.000001)))
    }
}


final class AbsDiffEqDoubleTests: XCTestCase {
    func testBasicEq() {
        XCTAssert(Double(1.0).absDiffEq(Double(1.0)))
        XCTAssert(Double(1.0).absDiffNe(Double(2.0)))
    }

    func testBasicNe() {
        XCTAssert(Double(1.0).absDiffNe(Double(2.0)))
    }

    func testBig() {
        XCTAssert(Double(10000000000000000.0).absDiffEq(Double(10000000000000001.0)))
        XCTAssert(Double(10000000000000001.0).absDiffEq(Double(10000000000000000.0)))
        XCTAssert(Double(1000000000000000.0).absDiffNe(Double(1000000000000001.0)))
        XCTAssert(Double(1000000000000001.0).absDiffNe(Double(1000000000000000.0)))
    }

    func testBigNeg() {
        XCTAssert(Double(-10000000000000000.0).absDiffEq(Double(-10000000000000001.0)))
        XCTAssert(Double(-10000000000000001.0).absDiffEq(Double(-10000000000000000.0)))
        XCTAssert(Double(-1000000000000000.0).absDiffNe(Double(-1000000000000001.0)))
        XCTAssert(Double(-1000000000000001.0).absDiffNe(Double(-1000000000000000.0)))
    }

    func testMid() {
        XCTAssert(Double(1.0000000000000001).absDiffEq(Double(1.0000000000000002)))
        XCTAssert(Double(1.0000000000000002).absDiffEq(Double(1.0000000000000001)))
        XCTAssert(Double(1.000000000000001).absDiffNe(Double(1.000000000000002)))
        XCTAssert(Double(1.000000000000002).absDiffNe(Double(1.000000000000001)))
    }

    func testMidNeg() {
        XCTAssert(Double(-1.0000000000000001).absDiffEq(Double(-1.0000000000000002)))
        XCTAssert(Double(-1.0000000000000002).absDiffEq(Double(-1.0000000000000001)))
        XCTAssert(Double(-1.000000000000001).absDiffNe(Double(-1.000000000000002)))
        XCTAssert(Double(-1.000000000000002).absDiffNe(Double(-1.000000000000001)))
    }

    func testSmall() {
        XCTAssert(Double(0.0000000100000001).absDiffEq(Double(0.0000000100000002)))
        XCTAssert(Double(0.0000000100000002).absDiffEq(Double(0.0000000100000001)))
        XCTAssert(Double(0.0000000100000001).absDiffNe(Double(0.0000000010000002)))
        XCTAssert(Double(0.0000000100000002).absDiffNe(Double(0.0000000010000001)))
    }

    func testSmallNeg() {
        XCTAssert(Double(-0.0000000100000001).absDiffEq(Double(-0.0000000100000002)))
        XCTAssert(Double(-0.0000000100000002).absDiffEq(Double(-0.0000000100000001)))
        XCTAssert(Double(-0.0000000100000001).absDiffNe(Double(-0.0000000010000002)))
        XCTAssert(Double(-0.0000000100000002).absDiffNe(Double(-0.0000000010000001)))
    }

    func testZero() {
        XCTAssert(Double(0.0).absDiffEq(Double(0.0)))
        XCTAssert(Double(0.0).absDiffEq(Double(-0.0)))
        XCTAssert(Double(-0.0).absDiffEq(Double(-0.0)))

        XCTAssert(Double(0.000000000000001).absDiffNe(Double(0.0)))
        XCTAssert(Double(0.0).absDiffNe(Double(0.000000000000001)))
        XCTAssert(Double(-0.000000000000001).absDiffNe(Double(0.0)))
        XCTAssert(Double(0.0).absDiffNe(Double(-0.000000000000001)))
    }

    func testTolerance() {
        XCTAssert(Double(0.0).absDiffEq(Double(1e-40), tolerance: 1e-40))
        XCTAssert(Double(1e-40).absDiffEq(Double(0.0), tolerance: 1e-40))
        XCTAssert(Double(0.0).absDiffEq(Double(-1e-40), tolerance: 1e-40))
        XCTAssert(Double(-1e-40).absDiffEq(Double(0.0), tolerance: 1e-40))

        XCTAssert(Double(1e-40).absDiffNe(Double(0.0), tolerance: 1e-41))
        XCTAssert(Double(0.0).absDiffNe(Double(1e-40), tolerance: 1e-41))
        XCTAssert(Double(-1e-40).absDiffNe(Double(0.0), tolerance: 1e-41))
        XCTAssert(Double(0.0).absDiffNe(Double(-1e-40), tolerance: 1e-41))
    }

    func testMax() {
        XCTAssert(Double.greatestFiniteMagnitude.absDiffEq(Double.greatestFiniteMagnitude))
        XCTAssert(Double.greatestFiniteMagnitude.absDiffNe(-Double.greatestFiniteMagnitude))
        XCTAssert((-Double.greatestFiniteMagnitude).absDiffNe(Double.greatestFiniteMagnitude))
        XCTAssert(Double.greatestFiniteMagnitude.absDiffNe(Double.greatestFiniteMagnitude / Double(2.0)))
        XCTAssert(Double.greatestFiniteMagnitude.absDiffNe(-Double.greatestFiniteMagnitude / Double(2.0)))
        XCTAssert((-Double.greatestFiniteMagnitude).absDiffNe(Double.greatestFiniteMagnitude / Double(2.0)))
    }

    func testNAN() {
        XCTAssert(Double.nan.absDiffNe(Double.nan))

        XCTAssert(Double.nan.absDiffNe(Double(0.0)))
        XCTAssert(Double(-0.0).absDiffNe(Double.nan))
        XCTAssert(Double.nan.absDiffNe(Double(-0.0)))
        XCTAssert(Double(0.0).absDiffNe(Double.nan))

        XCTAssert(Double.nan.absDiffNe(Double.infinity))
        XCTAssert(Double.infinity.absDiffNe(Double.nan))
        XCTAssert(Double.nan.absDiffNe(-Double.infinity))
        XCTAssert((-Double.infinity).absDiffNe(Double.nan))

        XCTAssert(Double.nan.absDiffNe(Double.greatestFiniteMagnitude))
        XCTAssert(Double.greatestFiniteMagnitude.absDiffNe(Double.nan))
        XCTAssert(Double.nan.absDiffNe(-Double.greatestFiniteMagnitude))
        XCTAssert((-Double.greatestFiniteMagnitude).absDiffNe(Double.nan))

        XCTAssert(Double.nan.absDiffNe(Double.leastNonzeroMagnitude))
        XCTAssert(Double.leastNonzeroMagnitude.absDiffNe(Double.nan))
        XCTAssert(Double.nan.absDiffNe(-Double.leastNonzeroMagnitude))
        XCTAssert((-Double.leastNonzeroMagnitude).absDiffNe(Double.nan))
    }

    func testOppositeSigns() {
        XCTAssert(Double(1.000000001).absDiffNe(Double(-1.0)))
        XCTAssert(Double(-1.0).absDiffNe(Double(1.000000001)))
        XCTAssert(Double(-1.000000001).absDiffNe(Double(1.0)))
        XCTAssert(Double(1.0).absDiffNe(Double(-1.000000001)))

        XCTAssert((10.0 * Double.leastNonzeroMagnitude).absDiffEq(10.0 * -Double.leastNonzeroMagnitude))
    }

    func testCloseToZero() {
        XCTAssert(Double.leastNonzeroMagnitude.absDiffEq(Double.leastNonzeroMagnitude))
        XCTAssert(Double.leastNonzeroMagnitude.absDiffEq(-Double.leastNonzeroMagnitude))
        XCTAssert((-Double.leastNonzeroMagnitude).absDiffEq(Double.leastNonzeroMagnitude))

        XCTAssert(Double.leastNonzeroMagnitude.absDiffEq(Double(0.0)))
        XCTAssert(Double(0.0).absDiffEq(Double.leastNonzeroMagnitude))
        XCTAssert((-Double.leastNonzeroMagnitude).absDiffEq(Double(0.0)))
        XCTAssert(Double(0.0).absDiffEq(-Double.leastNonzeroMagnitude))

        XCTAssert(Double(0.000000000000001).absDiffNe(-Double.leastNonzeroMagnitude))
        XCTAssert(Double(0.000000000000001).absDiffNe(Double.leastNonzeroMagnitude))
        XCTAssert(Double.leastNonzeroMagnitude.absDiffNe(Double(0.000000000000001)))
        XCTAssert((-Double.leastNonzeroMagnitude).absDiffNe(Double(0.000000000000001)))
    }
}
