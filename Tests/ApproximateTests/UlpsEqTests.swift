import XCTest
@testable import Approximate


final class UlpsEqFloatTests: XCTestCase {
    func testBasicEq() {
        XCTAssert(ulpsEq(Float(1.0), Float(1.0)))
    }

    func testBasicNe() {
        XCTAssert(ulpsNe(Float(1.0), Float(2.0)))
    }

    func testBig() {
        XCTAssert(ulpsEq(Float(100000000.0), Float(100000001.0)))
        XCTAssert(ulpsEq(Float(100000001.0), Float(100000000.0)))
        XCTAssert(ulpsNe(Float(10000.0), Float(10001.0)))
        XCTAssert(ulpsNe(Float(10001.0), Float(10000.0)))
    }

    func testBigNeg() {
        XCTAssert(ulpsEq(Float(-100000000.0), Float(-100000001.0)))
        XCTAssert(ulpsEq(Float(-100000001.0), Float(-100000000.0)))
        XCTAssert(ulpsNe(Float(-10000.0), Float(-10001.0)))
        XCTAssert(ulpsNe(Float(-10001.0), Float(-10000.0)))
    }

    func testMid() {
        XCTAssert(ulpsEq(Float(1.0000001), Float(1.0000002)))
        XCTAssert(ulpsEq(Float(1.0000002), Float(1.0000001)))
        XCTAssert(ulpsNe(Float(1.000001), Float(1.000002)))
        XCTAssert(ulpsNe(Float(1.000002), Float(1.000001)))
    }

    func testMidNeg() {
        XCTAssert(ulpsEq(Float(-1.0000001), Float(-1.0000002)))
        XCTAssert(ulpsEq(Float(-1.0000002), Float(-1.0000001)))
        XCTAssert(ulpsNe(Float(-1.000001), Float(-1.000002)))
        XCTAssert(ulpsNe(Float(-1.000002), Float(-1.000001)))
    }

    func testSmall() {
        XCTAssert(ulpsEq(Float(0.000010001), Float(0.000010002)))
        XCTAssert(ulpsEq(Float(0.000010002), Float(0.000010001)))
        XCTAssert(ulpsNe(Float(0.000001002), Float(0.0000001001)))
        XCTAssert(ulpsNe(Float(0.000001001), Float(0.0000001002)))
    }

    func testSmallNeg() {
        XCTAssert(ulpsEq(Float(-0.000010001), Float(-0.000010002)))
        XCTAssert(ulpsEq(Float(-0.000010002), Float(-0.000010001)))
        XCTAssert(ulpsNe(Float(-0.000001002), Float(-0.0000001001)))
        XCTAssert(ulpsNe(Float(-0.000001001), Float(-0.0000001002)))
    }

    func testZero() {
        XCTAssert(ulpsEq(Float(0.0), Float(0.0)))
        XCTAssert(ulpsEq(Float(0.0), Float(-0.0)))
        XCTAssert(ulpsEq(Float(-0.0), Float(-0.0)))

        XCTAssert(ulpsNe(Float(0.000001), Float(0.0)))
        XCTAssert(ulpsNe(Float(0.0), Float(0.000001)))
        XCTAssert(ulpsNe(Float(-0.000001), Float(0.0)))
        XCTAssert(ulpsNe(Float(0.0), Float(-0.000001)))
    }

    func testTolerance() {
        XCTAssert(ulpsEq(Float(0.0), Float(1e-40), tolerance: Float(1e-40)))
        XCTAssert(ulpsEq(Float(1e-40), Float(0.0), tolerance: Float(1e-40)))
        XCTAssert(ulpsEq(Float(0.0), Float(-1e-40), tolerance: Float(1e-40)))
        XCTAssert(ulpsEq(Float(-1e-40), Float(0.0), tolerance: Float(1e-40)))

        XCTAssert(ulpsNe(Float(1e-40), Float(0.0), tolerance: Float(1e-41)))
        XCTAssert(ulpsNe(Float(0.0), Float(1e-40), tolerance: Float(1e-41)))
        XCTAssert(ulpsNe(Float(-1e-40), Float(0.0), tolerance: Float(1e-41)))
        XCTAssert(ulpsNe(Float(0.0), Float(-1e-40), tolerance: Float(1e-41)))
    }

    func testMax() {
        XCTAssert(ulpsEq(Float.greatestFiniteMagnitude, Float.greatestFiniteMagnitude))
        XCTAssert(ulpsNe(Float.greatestFiniteMagnitude, -Float.greatestFiniteMagnitude))
        XCTAssert(ulpsNe(-Float.greatestFiniteMagnitude, Float.greatestFiniteMagnitude))
        XCTAssert(ulpsNe(
            Float.greatestFiniteMagnitude,
            Float.greatestFiniteMagnitude / Float(2.0)
        ))
        XCTAssert(ulpsNe(
             Float.greatestFiniteMagnitude,
            -Float.greatestFiniteMagnitude / Float(2.0)
        ))
        XCTAssert(ulpsNe(
            -Float.greatestFiniteMagnitude,
             Float.greatestFiniteMagnitude / Float(2.0)
        ))
    }

    func testInfinity() {
        XCTAssert(ulpsEq(Float.infinity, Float.infinity))
        XCTAssert(ulpsEq(-Float.infinity, -Float.infinity))
        XCTAssert(ulpsNe(-Float.infinity, Float.infinity))
        XCTAssert(ulpsEq(Float.infinity, Float.greatestFiniteMagnitude))
        XCTAssert(ulpsEq(-Float.infinity, -Float.greatestFiniteMagnitude))
    }

    func testNAN() {
        XCTAssert(ulpsNe(Float.nan, Float.nan))

        XCTAssert(ulpsNe(Float.nan, Float(0.0)))
        XCTAssert(ulpsNe(Float(-0.0), Float.nan))
        XCTAssert(ulpsNe(Float.nan, Float(-0.0)))
        XCTAssert(ulpsNe(Float(0.0), Float.nan))

        XCTAssert(ulpsNe(Float.nan, Float.infinity))
        XCTAssert(ulpsNe(Float.infinity, Float.nan))
        XCTAssert(ulpsNe(Float.nan, -Float.infinity))
        XCTAssert(ulpsNe(-Float.infinity, Float.nan))

        XCTAssert(ulpsNe(Float.nan, Float.greatestFiniteMagnitude))
        XCTAssert(ulpsNe(Float.greatestFiniteMagnitude, Float.nan))
        XCTAssert(ulpsNe(Float.nan, -Float.greatestFiniteMagnitude))
        XCTAssert(ulpsNe(-Float.greatestFiniteMagnitude, Float.nan))

        XCTAssert(ulpsNe(Float.nan, Float.leastNonzeroMagnitude))
        XCTAssert(ulpsNe(Float.leastNonzeroMagnitude, Float.nan))
        XCTAssert(ulpsNe(Float.nan, -Float.leastNonzeroMagnitude))
        XCTAssert(ulpsNe(-Float.leastNonzeroMagnitude, Float.nan))
    }

    func testOppositeSigns() {
        XCTAssert(ulpsNe(Float(1.000000001), Float(-1.0)))
        XCTAssert(ulpsNe(Float(-1.0), Float(1.000000001)))
        XCTAssert(ulpsNe(Float(-1.000000001), Float(1.0)))
        XCTAssert(ulpsNe(Float(1.0), Float(-1.000000001)))

        XCTAssert(ulpsEq(
            Float(10.0) *  Float.leastNonzeroMagnitude,
            Float(10.0) * -Float.leastNonzeroMagnitude)
        )
    }

    func testCloseToZero() {
        XCTAssert(ulpsEq(Float.leastNonzeroMagnitude, Float.leastNonzeroMagnitude))
        XCTAssert(ulpsEq(Float.leastNonzeroMagnitude, -Float.leastNonzeroMagnitude))
        XCTAssert(ulpsEq(-Float.leastNonzeroMagnitude, Float.leastNonzeroMagnitude))

        XCTAssert(ulpsEq(Float.leastNonzeroMagnitude, Float(0.0)))
        XCTAssert(ulpsEq(Float(0.0), Float.leastNonzeroMagnitude))
        XCTAssert(ulpsEq(-Float.leastNonzeroMagnitude, Float(0.0)))
        XCTAssert(ulpsEq(Float(0.0), -Float.leastNonzeroMagnitude))

        XCTAssert(ulpsNe(Float(0.000001), -Float.leastNonzeroMagnitude))
        XCTAssert(ulpsNe(Float(0.000001), Float.leastNonzeroMagnitude))
        XCTAssert(ulpsNe(Float.leastNonzeroMagnitude, Float(0.000001)))
        XCTAssert(ulpsNe(-Float.leastNonzeroMagnitude, Float(0.000001)))
    }
}

final class UlpsEqDoubleTests: XCTestCase {
    func testBasicEq() {
        XCTAssert(ulpsEq(Double(1.0), Double(1.0)))
    }

    func testBasicNe() {
        XCTAssert(ulpsNe(Double(1.0), Double(2.0)))
    }

    func testBig() {
        XCTAssert(ulpsEq(Double(10000000000000000.0), Double(10000000000000001.0)))
        XCTAssert(ulpsEq(Double(10000000000000001.0), Double(10000000000000000.0)))
        XCTAssert(ulpsNe(Double(1000000000000000.0), Double(1000000000000001.0)))
        XCTAssert(ulpsNe(Double(1000000000000001.0), Double(1000000000000000.0)))
    }

    func testBigNeg() {
        XCTAssert(ulpsEq(Double(-10000000000000000.0), Double(-10000000000000001.0)))
        XCTAssert(ulpsEq(Double(-10000000000000001.0), Double(-10000000000000000.0)))
        XCTAssert(ulpsNe(Double(-1000000000000000.0), Double(-1000000000000001.0)))
        XCTAssert(ulpsNe(Double(-1000000000000001.0), Double(-1000000000000000.0)))
    }

    func testMid() {
        XCTAssert(ulpsEq(Double(1.0000000000000001), Double(1.0000000000000002)))
        XCTAssert(ulpsEq(Double(1.0000000000000002), Double(1.0000000000000001)))
        XCTAssert(ulpsNe(Double(1.000000000000001), Double(1.0000000000000022)))
        XCTAssert(ulpsNe(Double(1.0000000000000022), Double(1.000000000000001)))
    }

    func testMidNeg() {
        XCTAssert(ulpsEq(Double(-1.0000000000000001), Double(-1.0000000000000002)))
        XCTAssert(ulpsEq(Double(-1.0000000000000002), Double(-1.0000000000000001)))
        XCTAssert(ulpsNe(Double(-1.000000000000001), Double(-1.0000000000000022)))
        XCTAssert(ulpsNe(Double(-1.0000000000000022), Double(-1.000000000000001)))
    }

    func testSmall() {
        XCTAssert(ulpsEq(Double(0.0000000100000001), Double(0.0000000100000002)))
        XCTAssert(ulpsEq(Double(0.0000000100000002), Double(0.0000000100000001)))
        XCTAssert(ulpsNe(Double(0.0000000100000001), Double(0.0000000010000002)))
        XCTAssert(ulpsNe(Double(0.0000000100000002), Double(0.0000000010000001)))
    }

    func testSmallNeg() {
        XCTAssert(ulpsEq(Double(-0.0000000100000001), Double(-0.0000000100000002)))
        XCTAssert(ulpsEq(Double(-0.0000000100000002), Double(-0.0000000100000001)))
        XCTAssert(ulpsNe(Double(-0.0000000100000001), Double(-0.0000000010000002)))
        XCTAssert(ulpsNe(Double(-0.0000000100000002), Double(-0.0000000010000001)))
    }

    func testZero() {
        XCTAssert(ulpsEq(Double(0.0), Double(0.0)))
        XCTAssert(ulpsEq(Double(0.0), Double(-0.0)))
        XCTAssert(ulpsEq(Double(-0.0), Double(-0.0)))

        XCTAssert(ulpsNe(Double(0.000000000000001), Double(0.0)))
        XCTAssert(ulpsNe(Double(0.0), Double(0.000000000000001)))
        XCTAssert(ulpsNe(Double(-0.000000000000001), Double(0.0)))
        XCTAssert(ulpsNe(Double(0.0), Double(-0.000000000000001)))
    }

    func testTolerance() {
        XCTAssert(ulpsEq(Double(0.0), Double(1e-40), tolerance: Double(1e-40)))
        XCTAssert(ulpsEq(Double(1e-40), Double(0.0), tolerance: Double(1e-40)))
        XCTAssert(ulpsEq(Double(0.0), Double(-1e-40), tolerance: Double(1e-40)))
        XCTAssert(ulpsEq(Double(-1e-40), Double(0.0), tolerance: Double(1e-40)))

        XCTAssert(ulpsNe(Double(1e-40), Double(0.0), tolerance: Double(1e-41)))
        XCTAssert(ulpsNe(Double(0.0), Double(1e-40), tolerance: Double(1e-41)))
        XCTAssert(ulpsNe(Double(-1e-40), Double(0.0), tolerance: Double(1e-41)))
        XCTAssert(ulpsNe(Double(0.0), Double(-1e-40), tolerance: Double(1e-41)))
    }

    func testMax() {
        XCTAssert(ulpsEq(Double.greatestFiniteMagnitude, Double.greatestFiniteMagnitude))
        XCTAssert(ulpsNe(Double.greatestFiniteMagnitude, -Double.greatestFiniteMagnitude))
        XCTAssert(ulpsNe(-Double.greatestFiniteMagnitude, Double.greatestFiniteMagnitude))
        XCTAssert(ulpsNe(Double.greatestFiniteMagnitude, Double.greatestFiniteMagnitude / Double(2.0)))
        XCTAssert(ulpsNe(Double.greatestFiniteMagnitude, -Double.greatestFiniteMagnitude / Double(2.0)))
        XCTAssert(ulpsNe(-Double.greatestFiniteMagnitude, Double.greatestFiniteMagnitude / Double(2.0)))
    }

    func testInfinity() {
        XCTAssert(ulpsEq(Double.infinity, Double.infinity))
        XCTAssert(ulpsEq(-Double.infinity, -Double.infinity))
        XCTAssert(ulpsNe(-Double.infinity, Double.infinity))
        XCTAssert(ulpsEq(Double.infinity, Double.greatestFiniteMagnitude))
        XCTAssert(ulpsEq(-Double.infinity, -Double.greatestFiniteMagnitude))
    }

    func testNAN() {
        XCTAssert(ulpsNe(Double.nan, Double.nan))

        XCTAssert(ulpsNe(Double.nan, Double(0.0)))
        XCTAssert(ulpsNe(Double(-0.0), Double.nan))
        XCTAssert(ulpsNe(Double.nan, Double(-0.0)))
        XCTAssert(ulpsNe(Double(0.0), Double.nan))

        XCTAssert(ulpsNe(Double.nan, Double.infinity))
        XCTAssert(ulpsNe(Double.infinity, Double.nan))
        XCTAssert(ulpsNe(Double.nan, -Double.infinity))
        XCTAssert(ulpsNe(-Double.infinity, Double.nan))

        XCTAssert(ulpsNe(Double.nan, Double.greatestFiniteMagnitude))
        XCTAssert(ulpsNe(Double.greatestFiniteMagnitude, Double.nan))
        XCTAssert(ulpsNe(Double.nan, -Double.greatestFiniteMagnitude))
        XCTAssert(ulpsNe(-Double.greatestFiniteMagnitude, Double.nan))

        XCTAssert(ulpsNe(Double.nan, Double.leastNonzeroMagnitude))
        XCTAssert(ulpsNe(Double.leastNonzeroMagnitude, Double.nan))
        XCTAssert(ulpsNe(Double.nan, -Double.leastNonzeroMagnitude))
        XCTAssert(ulpsNe(-Double.leastNonzeroMagnitude, Double.nan))
    }

    func testOppositeSigns() {
        XCTAssert(ulpsNe(Double(1.000000001), Double(-1.0)))
        XCTAssert(ulpsNe(Double(-1.0), Double(1.000000001)))
        XCTAssert(ulpsNe(Double(-1.000000001), Double(1.0)))
        XCTAssert(ulpsNe(Double(1.0), Double(-1.000000001)))

        XCTAssert(ulpsEq(
            Double(10.0) * Double.leastNonzeroMagnitude,
            Double(10.0) * -Double.leastNonzeroMagnitude
        ))
    }

    func testCloseToZero() {
        XCTAssert(ulpsEq(Double.leastNonzeroMagnitude, Double.leastNonzeroMagnitude))
        XCTAssert(ulpsEq(Double.leastNonzeroMagnitude, -Double.leastNonzeroMagnitude))
        XCTAssert(ulpsEq(-Double.leastNonzeroMagnitude, Double.leastNonzeroMagnitude))

        XCTAssert(ulpsEq(Double.leastNonzeroMagnitude, Double(0.0)))
        XCTAssert(ulpsEq(Double(0.0), Double.leastNonzeroMagnitude))
        XCTAssert(ulpsEq(-Double.leastNonzeroMagnitude, Double(0.0)))
        XCTAssert(ulpsEq(Double(0.0), -Double.leastNonzeroMagnitude))

        XCTAssert(ulpsNe(Double(0.000000000000001), -Double.leastNonzeroMagnitude))
        XCTAssert(ulpsNe(Double(0.000000000000001), Double.leastNonzeroMagnitude))
        XCTAssert(ulpsNe(Double.leastNonzeroMagnitude, Double(0.000000000000001)))
        XCTAssert(ulpsNe(-Double.leastNonzeroMagnitude, Double(0.000000000000001)))
    }
}


final class UlpsEqSimdTests: XCTestCase {
    func testBasicEqSimd2() {
        XCTAssert(relativeEq(SIMD2(1.0, 1.0), SIMD2(1.0, 1.0)))
    }
    
    func testBasicNeSimd2() {
        XCTAssert(relativeNe(SIMD2(1.0, 1.0), SIMD2(2.0, 3.0)))
    }
    
    func testBasicEqSimd3() {
        XCTAssert(relativeEq(SIMD3(1.0, 1.0, 1.0), SIMD3(1.0, 1.0, 1.0)))
    }
    
    func testBasicNeSimd3() {
        XCTAssert(relativeNe(SIMD3(1.0, 1.0, 1.0), SIMD3(2.0, 3.0, 4.0)))
    }
    
    func testBasicEqSimd4() {
        XCTAssert(relativeEq(SIMD4(1.0, 1.0, 1.0, 1.0), SIMD4(1.0, 1.0, 1.0, 1.0)))
    }
    
    func testBasicNeSimd4() {
        XCTAssert(relativeNe(SIMD4(1.0, 1.0, 1.0, 1.0), SIMD4(2.0, 3.0, 4.0, 5.0)))
    }
    
    func testBasicEqSimd8() {
        XCTAssert(relativeEq(
            SIMD8(1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0),
            SIMD8(1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0)
        ))
    }
    
    func testBasicNeSimd8() {
        XCTAssert(relativeNe(
            SIMD8(1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0),
            SIMD8(2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0)
        ))
    }
    
    func testBasicEqSimd16() {
        XCTAssert(relativeEq(
            SIMD16(
                1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
                1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0
            ),
            SIMD16(
                1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
                1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0
            )
        ))
    }
    
    func testBasicNeSimd16() {
        XCTAssert(relativeNe(
            SIMD16(
                1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
                1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0
            ),
            SIMD16(
                2.0,  3.0,  4.0,  5.0,  6.0,  7.0,  8.0,  9.0,
                10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0, 17.0
            )
        ))
    }
    
    func testBasicEqSimd32() {
        XCTAssert(relativeEq(
            SIMD32(
                1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
                1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
                1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
                1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0
            ),
            SIMD32(
                1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
                1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
                1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
                1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0
            )
        ))
    }
    
    func testBasicNeSimd32() {
        XCTAssert(relativeNe(
            SIMD32(
                1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
                1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
                1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
                1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0
            ),
            SIMD32(
                2.0,  3.0,  4.0,  5.0,  6.0,  7.0,  8.0,  9.0,
                10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0, 17.0,
                18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0, 25.0,
                26.0, 27.0, 28.0, 29.0, 30.0, 31.0, 32.0, 33.0
            )
        ))
    }
    
    func testBasicEqSimd64() {
        XCTAssert(relativeEq(
            SIMD64(
                1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
                1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
                1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
                1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
                1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
                1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
                1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
                1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0
            ),
            SIMD64(
                1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
                1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
                1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
                1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
                1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
                1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
                1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
                1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0
            )
        ))
    }
    
    func testBasicNeSimd64() {
        XCTAssert(relativeNe(
            SIMD64(
                1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
                1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
                1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
                1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
                1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
                1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
                1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
                1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0
            ),
            SIMD64(
                2.0,  3.0,  4.0,  5.0,  6.0,  7.0,  8.0,  9.0,
                10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0, 17.0,
                18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0, 25.0,
                26.0, 27.0, 28.0, 29.0, 30.0, 31.0, 32.0, 33.0,
                34.0, 35.0, 36.0, 37.0, 38.0, 39.0, 40.0, 41.0,
                42.0, 43.0, 44.0, 45.0, 46.0, 47.0, 48.0, 49.0,
                50.0, 51.0, 52.0, 53.0, 54.0, 55.0, 56.0, 57.0,
                58.0, 59.0, 60.0, 61.0, 62.0, 63.0, 64.0, 65.0
            )
        ))
    }
}

