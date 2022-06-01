import XCTest
@testable import Approximate


/// The test cases in this class are derived from
/// ```
/// https://github.com/brendanzab/approx/blob/master/tests/
/// ```
/// and
/// ```
/// https://github.com/Pybonacci/puntoflotante.org/blob/master/content/errors/NearlyEqualsTest.java
/// ```
final class RelativeEqFloatTests: XCTestCase {
    func testBasicEq() throws {
        XCTAssert(relativeEq(Float(1.0), Float(1.0)))
    }

    func testBasicNe() throws {
        XCTAssert(relativeNe(Float(1.0), Float(2.0)))
    }

    func testBig() throws {
        XCTAssert(relativeEq(Float(100000000.0), Float(100000001.0)))
        XCTAssert(relativeEq(Float(100000001.0), Float(100000000.0)))
        XCTAssert(relativeNe(Float(10000.0), Float(10001.0)))
        XCTAssert(relativeNe(Float(10001.0), Float(10000.0)))
    }

    func testBigNeg() throws {
        XCTAssert(relativeEq(Float(-100000000.0), Float(-100000001.0)))
        XCTAssert(relativeEq(Float(-100000001.0), Float(-100000000.0)))
        XCTAssert(relativeNe(Float(-10000.0), Float(-10001.0)))
        XCTAssert(relativeNe(Float(-10001.0), Float(-10000.0)))
    }

    func testMid() throws {
        XCTAssert(relativeEq(Float(1.0000001), Float(1.0000002)))
        XCTAssert(relativeEq(Float(1.0000002), Float(1.0000001)))
        XCTAssert(relativeNe(Float(1.000001), Float(1.000002)))
        XCTAssert(relativeNe(Float(1.000002), Float(1.000001)))
    }

    func testMidNeg() throws {
        XCTAssert(relativeEq(Float(-1.0000001), Float(-1.0000002)))
        XCTAssert(relativeEq(Float(-1.0000002), Float(-1.0000001)))
        XCTAssert(relativeNe(Float(-1.000001), Float(-1.000002)))
        XCTAssert(relativeNe(Float(-1.000002), Float(-1.000001)))
    }

    func testSmall() throws {
        XCTAssert(relativeEq(Float(0.000010001), Float(0.000010002)))
        XCTAssert(relativeEq(Float(0.000010002), Float(0.000010001)))
        XCTAssert(relativeNe(Float(0.000001002), Float(0.0000001001)))
        XCTAssert(relativeNe(Float(0.000001001), Float(0.0000001002)))
    }

    func testSmallNeg() throws {
        XCTAssert(relativeEq(Float(-0.000010001), Float(-0.000010002)))
        XCTAssert(relativeEq(Float(-0.000010002), Float(-0.000010001)))
        XCTAssert(relativeNe(Float(-0.000001002), Float(-0.0000001001)))
        XCTAssert(relativeNe(Float(-0.000001001), Float(-0.0000001002)))
    }

    func testZero() throws {
        XCTAssert(relativeEq(Float(0.0), Float(0.0)))
        XCTAssert(relativeEq(Float(0.0), Float(-0.0)))
        XCTAssert(relativeEq(Float(-0.0), Float(-0.0)))

        XCTAssert(relativeNe(Float(0.000001), Float(0.0)))
        XCTAssert(relativeNe(Float(0.0), Float(0.000001)))
        XCTAssert(relativeNe(Float(-0.000001), Float(0.0)))
        XCTAssert(relativeNe(Float(0.0), Float(-0.000001)))
    }

    func testTolerance() throws {
        XCTAssert(relativeEq(Float(0.0), Float(1e-40), tolerance: Float(1e-40)))
        XCTAssert(relativeEq(Float(1e-40), Float(0.0), tolerance: Float(1e-40)))
        XCTAssert(relativeEq(Float(0.0), Float(-1e-40), tolerance: Float(1e-40)))
        XCTAssert(relativeEq(Float(-1e-40), Float(0.0), tolerance: Float(1e-40)))

        XCTAssert(relativeNe(Float(1e-40), Float(0.0), tolerance: Float(1e-41)))
        XCTAssert(relativeNe(Float(0.0), Float(1e-40), tolerance: Float(1e-41)))
        XCTAssert(relativeNe(Float(-1e-40), Float(0.0), tolerance: Float(1e-41)))
        XCTAssert(relativeNe(Float(0.0), Float(-1e-40), tolerance: Float(1e-41)))
    }

    func testMax() throws {
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

    func testInfinity() throws {
        XCTAssert(relativeEq(Float.infinity, Float.infinity))
        XCTAssert(relativeEq(-Float.infinity, -Float.infinity))
        XCTAssert(relativeNe(-Float.infinity, Float.infinity))
    }

    func testZeroInfinity() throws {
        XCTAssert(relativeNe(Float(0), Float.infinity))
        XCTAssert(relativeNe(Float(0), -Float.infinity))
    }

    func testNAN() throws {
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

    func testOppositeSigns() throws {
        XCTAssert(relativeNe(Float(1.000000001), Float(-1.0)))
        XCTAssert(relativeNe(Float(-1.0), Float(1.000000001)))
        XCTAssert(relativeNe(Float(-1.000000001), Float(1.0)))
        XCTAssert(relativeNe(Float(1.0), Float(-1.000000001)))

        XCTAssert(relativeEq(
            Float(10.0) *  Float.leastNonzeroMagnitude,
            Float(10.0) * -Float.leastNonzeroMagnitude
        ))
    }

    func testCloseToZero() throws {
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


/// The test cases in this class are derived from
/// ```
/// https://github.com/brendanzab/approx/blob/master/tests/
/// ```
/// and
/// ```
/// https://github.com/Pybonacci/puntoflotante.org/blob/master/content/errors/NearlyEqualsTest.java
/// ```
final class RelativeEqDoubleTests: XCTestCase {
    func testBasicEq() throws {
        XCTAssert(relativeEq(Double(1.0), Double(1.0)))
    }

    func testBasicNe() throws {
        XCTAssert(relativeNe(Double(1.0), Double(2.0)))
    }

    func testBig() throws {
        XCTAssert(relativeEq(Double(10000000000000000.0), Double(10000000000000001.0)))
        XCTAssert(relativeEq(Double(10000000000000001.0), Double(10000000000000000.0)))
        XCTAssert(relativeNe(Double(1000000000000000.0), Double(1000000000000001.0)))
        XCTAssert(relativeNe(Double(1000000000000001.0), Double(1000000000000000.0)))
    }

    func testBigNeg() throws {
        XCTAssert(relativeEq(Double(-10000000000000000.0), Double(-10000000000000001.0)))
        XCTAssert(relativeEq(Double(-10000000000000001.0), Double(-10000000000000000.0)))
        XCTAssert(relativeNe(Double(-1000000000000000.0), Double(-1000000000000001.0)))
        XCTAssert(relativeNe(Double(-1000000000000001.0), Double(-1000000000000000.0)))
    }

    func testMid() throws {
        XCTAssert(relativeEq(Double(1.0000000000000001), Double(1.0000000000000002)))
        XCTAssert(relativeEq(Double(1.0000000000000002), Double(1.0000000000000001)))
        XCTAssert(relativeNe(Double(1.000000000000001), Double(1.000000000000002)))
        XCTAssert(relativeNe(Double(1.000000000000002), Double(1.000000000000001)))
    }

    func testMidNeg() throws {
        XCTAssert(relativeEq(Double(-1.0000000000000001), Double(-1.0000000000000002)))
        XCTAssert(relativeEq(Double(-1.0000000000000002), Double(-1.0000000000000001)))
        XCTAssert(relativeNe(Double(-1.000000000000001), Double(-1.000000000000002)))
        XCTAssert(relativeNe(Double(-1.000000000000002), Double(-1.000000000000001)))
    }

    func testSmall() throws {
        XCTAssert(relativeEq(Double(0.0000000100000001), Double(0.0000000100000002)))
        XCTAssert(relativeEq(Double(0.0000000100000002), Double(0.0000000100000001)))
        XCTAssert(relativeNe(Double(0.0000000100000001), Double(0.0000000010000002)))
        XCTAssert(relativeNe(Double(0.0000000100000002), Double(0.0000000010000001)))
    }

    func testSmallNeg() throws {
        XCTAssert(relativeEq(Double(-0.0000000100000001), Double(-0.0000000100000002)))
        XCTAssert(relativeEq(Double(-0.0000000100000002), Double(-0.0000000100000001)))
        XCTAssert(relativeNe(Double(-0.0000000100000001), Double(-0.0000000010000002)))
        XCTAssert(relativeNe(Double(-0.0000000100000002), Double(-0.0000000010000001)))
    }

    func testZero() throws {
        XCTAssert(relativeEq(Double(0.0), Double(0.0)))
        XCTAssert(relativeEq(Double(0.0), Double(-0.0)))
        XCTAssert(relativeEq(Double(-0.0), Double(-0.0)))

        XCTAssert(relativeNe(Double(0.000000000000001), Double(0.0)))
        XCTAssert(relativeNe(Double(0.0), Double(0.000000000000001)))
        XCTAssert(relativeNe(Double(-0.000000000000001), Double(0.0)))
        XCTAssert(relativeNe(Double(0.0), Double(-0.000000000000001)))
    }

    func testTolerance() throws {
        XCTAssert(relativeEq(Double(0.0), Double(1e-40), tolerance: Double(1e-40)))
        XCTAssert(relativeEq(Double(1e-40), Double(0.0), tolerance: Double(1e-40)))
        XCTAssert(relativeEq(Double(0.0), Double(-1e-40), tolerance: Double(1e-40)))
        XCTAssert(relativeEq(Double(-1e-40), Double(0.0), tolerance: Double(1e-40)))

        XCTAssert(relativeNe(Double(1e-40), Double(0.0), tolerance: Double(1e-41)))
        XCTAssert(relativeNe(Double(0.0), Double(1e-40), tolerance: Double(1e-41)))
        XCTAssert(relativeNe(Double(-1e-40), Double(0.0), tolerance: Double(1e-41)))
        XCTAssert(relativeNe(Double(0.0), Double(-1e-40), tolerance: Double(1e-41)))
    }

    func testMax() throws {
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

    func testInfinity() throws {
        XCTAssert(relativeEq(Double.infinity, Double.infinity))
        XCTAssert(relativeEq(-Double.infinity, -Double.infinity))
        XCTAssert(relativeNe(-Double.infinity, Double.infinity))
    }

    func testNAN() throws {
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

    func testOppositeSigns() throws {
        XCTAssert(relativeNe(Double(1.000000001), Double(-1.0)))
        XCTAssert(relativeNe(Double(-1.0), Double(1.000000001)))
        XCTAssert(relativeNe(Double(-1.000000001), Double(1.0)))
        XCTAssert(relativeNe(Double(1.0), Double(-1.000000001)))

        XCTAssert(relativeEq(
            Double(10.0) *  Double.leastNonzeroMagnitude,
            Double(10.0) * -Double.leastNonzeroMagnitude
        ))
    }

    func testCloseToZero() throws {
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


final class RelativeEqSimdTests: XCTestCase {
    func testBasicEqSimd2() throws {
        XCTAssert(relativeEq(SIMD2(1.0, 1.0), SIMD2(1.0, 1.0)))
    }
    
    func testBasicNeSimd2() throws {
        XCTAssert(relativeNe(SIMD2(1.0, 1.0), SIMD2(2.0, 3.0)))
    }
    
    func testBasicEqSimd3() throws {
        XCTAssert(relativeEq(SIMD3(1.0, 1.0, 1.0), SIMD3(1.0, 1.0, 1.0)))
    }
    
    func testBasicNeSimd3() throws {
        XCTAssert(relativeNe(SIMD3(1.0, 1.0, 1.0), SIMD3(2.0, 3.0, 4.0)))
    }
    
    func testBasicEqSimd4() throws {
        XCTAssert(relativeEq(SIMD4(1.0, 1.0, 1.0, 1.0), SIMD4(1.0, 1.0, 1.0, 1.0)))
    }
    
    func testBasicNeSimd4() throws {
        XCTAssert(relativeNe(SIMD4(1.0, 1.0, 1.0, 1.0), SIMD4(2.0, 3.0, 4.0, 5.0)))
    }
    
    func testBasicEqSimd8() throws {
        XCTAssert(relativeEq(
            SIMD8(1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0),
            SIMD8(1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0)
        ))
    }
    
    func testBasicNeSimd8() throws {
        XCTAssert(relativeNe(
            SIMD8(1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0),
            SIMD8(2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0)
        ))
    }
    
    func testBasicEqSimd16() throws {
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
    
    func testBasicNeSimd16() throws {
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
    
    func testBasicEqSimd32() throws {
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
    
    func testBasicNeSimd32() throws {
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
    
    func testBasicEqSimd64() throws {
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
    
    func testBasicNeSimd64() throws {
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

