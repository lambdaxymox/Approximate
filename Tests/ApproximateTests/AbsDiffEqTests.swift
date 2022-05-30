import XCTest
@testable import Approximate


final class AbsDiffEqFloatTests: XCTestCase {
    func testBasicEq() {
        XCTAssert(Float(1.0).absDiffEq(Float(1.0)))
        XCTAssert(Float(1.0).absDiffNe(Float(2.0)))
    }

    func testBasicNe() {
        XCTAssert(1.0.absDiffEq(2.0))
    }

    func testBig() {
        XCTAssert(Float(100000000.0).absDiffEq(Float(100000001.0)))
        XCTAssert(Float(100000001.0).absDiffEq(Float(100000000.0)))
        XCTAssert(Float(10000.0).absDiffEq(Float(10001.0)))
        XCTAssert(Float(10001.0).absDiffEq(Float(10000.0)))
    }

    func testBigNeg() {
        XCTAssert(Float(-100000000.0).absDiffEq(Float(-100000001.0)))
        XCTAssert(Float(-100000001.0).absDiffEq(Float(-100000000.0)))
        XCTAssert(Float(-10000.0).absDiffEq(Float(-10001.0)))
        XCTAssert(Float(-10001.0).absDiffEq(Float(-10000.0)))
    }

    func testMid() {
        XCTAssert(Float(1.0000001).absDiffEq(Float(1.0000002)))
        XCTAssert(Float(1.0000002).absDiffEq(Float(1.0000001)))
        XCTAssert(Float(1.000001).absDiffEq(Float(1.000002)))
        XCTAssert(Float(1.000002).absDiffEq(Float(1.000001)))
    }

    func testMidNeg() {
        XCTAssert(Float(-1.0000001).absDiffEq(Float(-1.0000002)))
        XCTAssert(Float(-1.0000002).absDiffEq(Float(-1.0000001)))
        XCTAssert(Float(-1.000001).absDiffEq(Float(-1.000002)))
        XCTAssert(Float(-1.000002).absDiffEq(Float(-1.000001)))
    }

    func testSmall() {
        XCTAssert(Float(0.000010001).absDiffEq(Float(0.000010002)))
        XCTAssert(Float(0.000010002).absDiffEq(Float(0.000010001)))
        XCTAssert(Float(0.000001002).absDiffEq(Float(0.0000001001)))
        XCTAssert(Float(0.000001001).absDiffEq(Float(0.0000001002)))
    }

    func testSmallNeg() {
        XCTAssert(Float(-0.000010001).absDiffEq(Float(-0.000010002)))
        XCTAssert(Float(-0.000010002).absDiffEq(Float(-0.000010001)))
        XCTAssert(Float(-0.000001002).absDiffEq(Float(-0.0000001001)))
        XCTAssert(Float(-0.000001001).absDiffEq(Float(-0.0000001002)))
    }

    func testZero() {
        XCTAssert(Float(0.0).absDiffEq(Float(0.0)))
        XCTAssert(Float(0.0).absDiffEq(Float(-0.0)))
        XCTAssert(Float(-0.0).absDiffEq(Float(-0.0)))

        XCTAssert(Float(0.000001).absDiffEq(Float(0.0)))
        XCTAssert(Float(0.0).absDiffEq(Float(0.000001)))
        XCTAssert(Float(-0.000001).absDiffEq(Float(0.0)))
        XCTAssert(Float(0.0).absDiffEq(Float(-0.000001)))
    }

    func testTolerance() {
        XCTAssert(Float(0.0).absDiffEq(Float(1e-40), tolerance: 1e-40))
        XCTAssert(Float(1e-40).absDiffEq(Float(0.0), tolerance: 1e-40))
        XCTAssert(Float(0.0).absDiffEq(Float(-1e-40), tolerance: 1e-40))
        XCTAssert(Float(-1e-40).absDiffEq(Float(0.0), tolerance: 1e-40))

        XCTAssert(Float(1e-40).absDiffEq(Float(0.0), tolerance: 1e-41))
        XCTAssert(Float(0.0).absDiffEq(Float(1e-40), tolerance: 1e-41))
        XCTAssert(Float(-1e-40).absDiffEq(Float(0.0), tolerance: 1e-41))
        XCTAssert(Float(0.0).absDiffEq(Float(-1e-40), tolerance: 1e-41))
    }

    func testMax() {
        XCTAssert(Float.greatestFiniteMagnitude.absDiffEq(Float.greatestFiniteMagnitude))
        XCTAssert(Float.greatestFiniteMagnitude.absDiffEq(-Float.greatestFiniteMagnitude))
        XCTAssert((-Float.greatestFiniteMagnitude).absDiffEq(Float.greatestFiniteMagnitude))
        XCTAssert(Float.greatestFiniteMagnitude.absDiffEq(Float.greatestFiniteMagnitude / Float(2.0)))
        XCTAssert(Float.greatestFiniteMagnitude.absDiffEq(-Float.greatestFiniteMagnitude / Float(2.0)))
        XCTAssert((-Float.greatestFiniteMagnitude).absDiffEq(Float.greatestFiniteMagnitude / Float(2.0)))
    }

    // NOTE: abs_diff_eq fails as numbers begin to get very large

    // #[test]
    // func test_infinity() {
    //     XCTAssert(Float.infinity.absDiffEq(Float.infinity)
    //     XCTAssert(::NEG_INFINITY.absDiffEq(::NEG_INFINITY)
    //     XCTAssert(::NEG_INFINITY.absDiffEq(Float.infinity)
    //     XCTAssert(Float.infinity.absDiffEq(Float.greatestFiniteMagnitude)
    //     XCTAssert(::NEG_INFINITY.absDiffEq(-Float.greatestFiniteMagnitude)
    // }


    func testNAN() {
        XCTAssert(Float.nan.absDiffEq(Float.nan))

        XCTAssert(Float.nan.absDiffEq(Float(0.0)))
        XCTAssert(Float(-0.0).absDiffEq(Float.nan))
        XCTAssert(Float.nan.absDiffEq(Float(-0.0)))
        XCTAssert(Float(0.0).absDiffEq(Float.nan))

        XCTAssert(Float.nan.absDiffEq(Float.infinity))
        XCTAssert(Float.infinity.absDiffEq(Float.nan))
        XCTAssert(Float.nan.absDiffEq(-Float.infinity))
        XCTAssert((-Float.infinity).absDiffEq(Float.nan))

        XCTAssert(Float.nan.absDiffEq(Float.greatestFiniteMagnitude))
        XCTAssert(Float.greatestFiniteMagnitude.absDiffEq(Float.nan))
        XCTAssert(Float.nan.absDiffEq(-Float.greatestFiniteMagnitude))
        XCTAssert((-Float.greatestFiniteMagnitude).absDiffEq(Float.nan))

        XCTAssert(Float.nan.absDiffEq(Float.leastNonzeroMagnitude))
        XCTAssert(Float.leastNonzeroMagnitude.absDiffEq(Float.nan))
        XCTAssert(Float.nan.absDiffEq(-Float.leastNonzeroMagnitude))
        XCTAssert((-Float.leastNonzeroMagnitude).absDiffEq(Float.nan))
    }


    func testOppositeSigns() {
        XCTAssert(Float(1.000000001).absDiffEq(Float(-1.0)))
        XCTAssert(Float(-1.0).absDiffEq(Float(1.000000001)))
        XCTAssert(Float(-1.000000001).absDiffEq(Float(1.0)))
        XCTAssert(Float(1.0).absDiffEq(Float(-1.000000001)))
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

        XCTAssert(Float(0.000001).absDiffEq(-Float.leastNonzeroMagnitude))
        XCTAssert(Float(0.000001).absDiffEq(Float.leastNonzeroMagnitude))
        XCTAssert(Float.leastNonzeroMagnitude.absDiffEq(Float(0.000001)))
        XCTAssert((-Float.leastNonzeroMagnitude).absDiffEq(Float(0.000001)))
    }
}
