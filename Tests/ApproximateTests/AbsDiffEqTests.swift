import XCTest
@testable import Approximate


final class AbsDiffEqFloatTests: XCTestCase {
    func testBasicEq() throws {
        XCTAssert(absDiffEq(Float(1.0), Float(1.0)))
    }

    func testBasicNe() throws {
        XCTAssert(absDiffNe(Float(1.0), Float(2.0)))
    }

    func testBig() throws {
        XCTAssert(absDiffEq(Float(100000000.0), Float(100000001.0)))
        XCTAssert(absDiffEq(Float(100000001.0), Float(100000000.0)))
        XCTAssert(absDiffNe(Float(10000.0), Float(10001.0)))
        XCTAssert(absDiffNe(Float(10001.0), Float(10000.0)))
    }

    func testBigNeg() throws {
        XCTAssert(absDiffEq(Float(-100000000.0), Float(-100000001.0)))
        XCTAssert(absDiffEq(Float(-100000001.0), Float(-100000000.0)))
        XCTAssert(absDiffNe(Float(-10000.0), Float(-10001.0)))
        XCTAssert(absDiffNe(Float(-10001.0), Float(-10000.0)))
    }

    func testMid() throws {
        XCTAssert(absDiffEq(Float(1.0000001), Float(1.0000002)))
        XCTAssert(absDiffEq(Float(1.0000002), Float(1.0000001)))
        XCTAssert(absDiffNe(Float(1.000001), Float(1.000002)))
        XCTAssert(absDiffNe(Float(1.000002), Float(1.000001)))
    }

    func testMidNeg() throws {
        XCTAssert(absDiffEq(Float(-1.0000001), Float(-1.0000002)))
        XCTAssert(absDiffEq(Float(-1.0000002), Float(-1.0000001)))
        XCTAssert(absDiffNe(Float(-1.000001), Float(-1.000002)))
        XCTAssert(absDiffNe(Float(-1.000002), Float(-1.000001)))
    }

    func testSmall() throws {
        XCTAssert(absDiffEq(Float(0.000010001), Float(0.000010002)))
        XCTAssert(absDiffEq(Float(0.000010002), Float(0.000010001)))
        XCTAssert(absDiffNe(Float(0.000001002), Float(0.0000001001)))
        XCTAssert(absDiffNe(Float(0.000001001), Float(0.0000001002)))
    }

    func testSmallNeg() throws {
        XCTAssert(absDiffEq(Float(-0.000010001), Float(-0.000010002)))
        XCTAssert(absDiffEq(Float(-0.000010002), Float(-0.000010001)))
        XCTAssert(absDiffNe(Float(-0.000001002), Float(-0.0000001001)))
        XCTAssert(absDiffNe(Float(-0.000001001), Float(-0.0000001002)))
    }

    func testZero() throws {
        XCTAssert(absDiffEq(Float(0.0), Float(0.0)))
        XCTAssert(absDiffEq(Float(0.0), Float(-0.0)))
        XCTAssert(absDiffEq(Float(-0.0), Float(-0.0)))

        XCTAssert(absDiffNe(Float(0.000001), Float(0.0)))
        XCTAssert(absDiffNe(Float(0.0), Float(0.000001)))
        XCTAssert(absDiffNe(Float(-0.000001), Float(0.0)))
        XCTAssert(absDiffNe(Float(0.0), Float(-0.000001)))
    }

    func testTolerance() throws {
        XCTAssert(absDiffEq(Float(0.0), Float(1e-40), tolerance: 1e-40))
        XCTAssert(absDiffEq(Float(1e-40), Float(0.0), tolerance: 1e-40))
        XCTAssert(absDiffEq(Float(0.0), Float(-1e-40), tolerance: 1e-40))
        XCTAssert(absDiffEq(Float(-1e-40), Float(0.0), tolerance: 1e-40))

        XCTAssert(absDiffNe(Float(1e-40), Float(0.0), tolerance: 1e-41))
        XCTAssert(absDiffNe(Float(0.0), Float(1e-40), tolerance: 1e-41))
        XCTAssert(absDiffNe(Float(-1e-40), Float(0.0), tolerance: 1e-41))
        XCTAssert(absDiffNe(Float(0.0), Float(-1e-40), tolerance: 1e-41))
    }

    func testMax() throws {
        XCTAssert(absDiffEq(Float.greatestFiniteMagnitude, Float.greatestFiniteMagnitude))
        XCTAssert(absDiffNe(Float.greatestFiniteMagnitude, -Float.greatestFiniteMagnitude))
        XCTAssert(absDiffNe((-Float.greatestFiniteMagnitude), Float.greatestFiniteMagnitude))
        XCTAssert(absDiffNe(Float.greatestFiniteMagnitude, Float.greatestFiniteMagnitude / Float(2.0)))
        XCTAssert(absDiffNe(Float.greatestFiniteMagnitude, -Float.greatestFiniteMagnitude / Float(2.0)))
        XCTAssert(absDiffNe(-Float.greatestFiniteMagnitude, Float.greatestFiniteMagnitude / Float(2.0)))
    }

    func testNAN() throws {
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


    func testOppositeSigns() throws {
        XCTAssert(absDiffNe(Float(1.000000001), Float(-1.0)))
        XCTAssert(absDiffNe(Float(-1.0), Float(1.000000001)))
        XCTAssert(absDiffNe(Float(-1.000000001), Float(1.0)))
        XCTAssert(absDiffNe(Float(1.0), Float(-1.000000001)))
        XCTAssert(absDiffEq(
            Float(10.0) * Float.leastNonzeroMagnitude,
            Float(10.0) * -Float.leastNonzeroMagnitude
        ))
    }


    func testCloseToZero() throws {
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
    func testBasicEq() throws {
        XCTAssert(absDiffEq(Double(1.0), Double(1.0)))
    }

    func testBasicNe() throws {
        XCTAssert(absDiffNe(Double(1.0), Double(2.0)))
    }

    func testBig() throws {
        XCTAssert(absDiffEq(Double(10000000000000000.0), Double(10000000000000001.0)))
        XCTAssert(absDiffEq(Double(10000000000000001.0), Double(10000000000000000.0)))
        XCTAssert(absDiffNe(Double(1000000000000000.0), Double(1000000000000001.0)))
        XCTAssert(absDiffNe(Double(1000000000000001.0), Double(1000000000000000.0)))
    }

    func testBigNeg() throws {
        XCTAssert(absDiffEq(Double(-10000000000000000.0), Double(-10000000000000001.0)))
        XCTAssert(absDiffEq(Double(-10000000000000001.0), Double(-10000000000000000.0)))
        XCTAssert(absDiffNe(Double(-1000000000000000.0), Double(-1000000000000001.0)))
        XCTAssert(absDiffNe(Double(-1000000000000001.0), Double(-1000000000000000.0)))
    }

    func testMid() throws {
        XCTAssert(absDiffEq(Double(1.0000000000000001), Double(1.0000000000000002)))
        XCTAssert(absDiffEq(Double(1.0000000000000002), Double(1.0000000000000001)))
        XCTAssert(absDiffNe(Double(1.000000000000001), Double(1.000000000000002)))
        XCTAssert(absDiffNe(Double(1.000000000000002), Double(1.000000000000001)))
    }

    func testMidNeg() throws {
        XCTAssert(absDiffEq(Double(-1.0000000000000001), Double(-1.0000000000000002)))
        XCTAssert(absDiffEq(Double(-1.0000000000000002), Double(-1.0000000000000001)))
        XCTAssert(absDiffNe(Double(-1.000000000000001), Double(-1.000000000000002)))
        XCTAssert(absDiffNe(Double(-1.000000000000002), Double(-1.000000000000001)))
    }

    func testSmall() throws {
        XCTAssert(absDiffEq(Double(0.0000000100000001), Double(0.0000000100000002)))
        XCTAssert(absDiffEq(Double(0.0000000100000002), Double(0.0000000100000001)))
        XCTAssert(absDiffNe(Double(0.0000000100000001), Double(0.0000000010000002)))
        XCTAssert(absDiffNe(Double(0.0000000100000002), Double(0.0000000010000001)))
    }

    func testSmallNeg() throws {
        XCTAssert(absDiffEq(Double(-0.0000000100000001), Double(-0.0000000100000002)))
        XCTAssert(absDiffEq(Double(-0.0000000100000002), Double(-0.0000000100000001)))
        XCTAssert(absDiffNe(Double(-0.0000000100000001), Double(-0.0000000010000002)))
        XCTAssert(absDiffNe(Double(-0.0000000100000002), Double(-0.0000000010000001)))
    }

    func testZero() throws {
        XCTAssert(absDiffEq(Double(0.0), Double(0.0)))
        XCTAssert(absDiffEq(Double(0.0), Double(-0.0)))
        XCTAssert(absDiffEq(Double(-0.0), Double(-0.0)))

        XCTAssert(absDiffNe(Double(0.000000000000001), Double(0.0)))
        XCTAssert(absDiffNe(Double(0.0), Double(0.000000000000001)))
        XCTAssert(absDiffNe(Double(-0.000000000000001), Double(0.0)))
        XCTAssert(absDiffNe(Double(0.0), Double(-0.000000000000001)))
    }

    func testTolerance() throws {
        XCTAssert(absDiffEq(Double(0.0), Double(1e-40), tolerance: 1e-40))
        XCTAssert(absDiffEq(Double(1e-40), Double(0.0), tolerance: 1e-40))
        XCTAssert(absDiffEq(Double(0.0), Double(-1e-40), tolerance: 1e-40))
        XCTAssert(absDiffEq(Double(-1e-40), Double(0.0), tolerance: 1e-40))

        XCTAssert(absDiffNe(Double(1e-40), Double(0.0), tolerance: 1e-41))
        XCTAssert(absDiffNe(Double(0.0), Double(1e-40), tolerance: 1e-41))
        XCTAssert(absDiffNe(Double(-1e-40), Double(0.0), tolerance: 1e-41))
        XCTAssert(absDiffNe(Double(0.0), Double(-1e-40), tolerance: 1e-41))
    }

    func testMax() throws {
        XCTAssert(absDiffEq(Double.greatestFiniteMagnitude, Double.greatestFiniteMagnitude))
        XCTAssert(absDiffNe(Double.greatestFiniteMagnitude, -Double.greatestFiniteMagnitude))
        XCTAssert(absDiffNe(-Double.greatestFiniteMagnitude, Double.greatestFiniteMagnitude))
        XCTAssert(absDiffNe(Double.greatestFiniteMagnitude, Double.greatestFiniteMagnitude / Double(2.0)))
        XCTAssert(absDiffNe(Double.greatestFiniteMagnitude, -Double.greatestFiniteMagnitude / Double(2.0)))
        XCTAssert(absDiffNe(-Double.greatestFiniteMagnitude, Double.greatestFiniteMagnitude / Double(2.0)))
    }

    func testNAN() throws {
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

    func testOppositeSigns() throws {
        XCTAssert(absDiffNe(Double(1.000000001), Double(-1.0)))
        XCTAssert(absDiffNe(Double(-1.0), Double(1.000000001)))
        XCTAssert(absDiffNe(Double(-1.000000001), Double(1.0)))
        XCTAssert(absDiffNe(Double(1.0), Double(-1.000000001)))

        XCTAssert(absDiffEq(
            10.0 * Double.leastNonzeroMagnitude,
            10.0 * -Double.leastNonzeroMagnitude
        ))
    }

    func testCloseToZero() throws {
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


final class AbsDiffSimdTest: XCTestCase {
    func testBasicEqSimd2() throws {
        XCTAssert(absDiffEq(SIMD2(1.0, 1.0), SIMD2(1.0, 1.0)))
    }
    
    func testBasicNeSimd2() throws {
        XCTAssert(absDiffNe(SIMD2(1.0, 1.0), SIMD2(2.0, 3.0)))
    }
    
    func testBasicEqSimd3() throws {
        XCTAssert(absDiffEq(SIMD3(1.0, 1.0, 1.0), SIMD3(1.0, 1.0, 1.0)))
    }
    
    func testBasicNeSimd3() throws {
        XCTAssert(absDiffNe(SIMD3(1.0, 1.0, 1.0), SIMD3(2.0, 3.0, 4.0)))
    }
    
    func testBasicEqSimd4() throws {
        XCTAssert(absDiffEq(SIMD4(1.0, 1.0, 1.0, 1.0), SIMD4(1.0, 1.0, 1.0, 1.0)))
    }
    
    func testBasicNeSimd4() throws {
        XCTAssert(absDiffNe(SIMD4(1.0, 1.0, 1.0, 1.0), SIMD4(2.0, 3.0, 4.0, 5.0)))
    }
    
    func testBasicEqSimd8() throws {
        XCTAssert(absDiffEq(
            SIMD8(1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0),
            SIMD8(1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0)
        ))
    }
    
    func testBasicNeSimd8() throws {
        XCTAssert(absDiffNe(
            SIMD8(1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0),
            SIMD8(2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0)
        ))
    }
    
    func testBasicEqSimd16() throws {
        XCTAssert(absDiffEq(
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
        XCTAssert(absDiffNe(
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
        XCTAssert(absDiffEq(
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
        XCTAssert(absDiffNe(
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
        XCTAssert(absDiffEq(
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
        XCTAssert(absDiffNe(
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
