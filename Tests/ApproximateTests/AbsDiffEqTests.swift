import XCTest
@testable import Approximate


final class AbsDiffEqFloatTests: XCTestCase {
    func testBasic() {
        XCTAssert(Float(1.0).absDiffEq(Float(1.0)))
        XCTAssert(Float(1.0).absDiffNe(Float(2.0)))
    }

    /*
    #[should_panic]
    func testBasicPanicEq() {
        assert_abs_diff_eq!(1.0f32, 2.0f32);
    }

    #[should_panic]
    func testBasicPanicNe() {
        assert_abs_diff_ne!(1.0f32, 1.0f32);
    }

    func testBig() {
        assert_abs_diff_eq!(100000000.0f32, 100000001.0f32);
        assert_abs_diff_eq!(100000001.0f32, 100000000.0f32);
        assert_abs_diff_ne!(10000.0f32, 10001.0f32);
        assert_abs_diff_ne!(10001.0f32, 10000.0f32);
    }

    func testBigNeg() {
        assert_abs_diff_eq!(-100000000.0f32, -100000001.0f32);
        assert_abs_diff_eq!(-100000001.0f32, -100000000.0f32);
        assert_abs_diff_ne!(-10000.0f32, -10001.0f32);
        assert_abs_diff_ne!(-10001.0f32, -10000.0f32);
    }

    func testMid() {
        assert_abs_diff_eq!(1.0000001f32, 1.0000002f32);
        assert_abs_diff_eq!(1.0000002f32, 1.0000001f32);
        assert_abs_diff_ne!(1.000001f32, 1.000002f32);
        assert_abs_diff_ne!(1.000002f32, 1.000001f32);
    }

    func testMidNeg() {
        assert_abs_diff_eq!(-1.0000001f32, -1.0000002f32);
        assert_abs_diff_eq!(-1.0000002f32, -1.0000001f32);
        assert_abs_diff_ne!(-1.000001f32, -1.000002f32);
        assert_abs_diff_ne!(-1.000002f32, -1.000001f32);
    }

    func testSmall() {
        assert_abs_diff_eq!(0.000010001f32, 0.000010002f32);
        assert_abs_diff_eq!(0.000010002f32, 0.000010001f32);
        assert_abs_diff_ne!(0.000001002f32, 0.0000001001f32);
        assert_abs_diff_ne!(0.000001001f32, 0.0000001002f32);
    }

    func testSmallNeg() {
        assert_abs_diff_eq!(-0.000010001f32, -0.000010002f32);
        assert_abs_diff_eq!(-0.000010002f32, -0.000010001f32);
        assert_abs_diff_ne!(-0.000001002f32, -0.0000001001f32);
        assert_abs_diff_ne!(-0.000001001f32, -0.0000001002f32);
    }

    func testZero() {
        assert_abs_diff_eq!(0.0f32, 0.0f32);
        assert_abs_diff_eq!(0.0f32, -0.0f32);
        assert_abs_diff_eq!(-0.0f32, -0.0f32);

        assert_abs_diff_ne!(0.000001f32, 0.0f32);
        assert_abs_diff_ne!(0.0f32, 0.000001f32);
        assert_abs_diff_ne!(-0.000001f32, 0.0f32);
        assert_abs_diff_ne!(0.0f32, -0.000001f32);
    }

    func testTolerance() {
        assert_abs_diff_eq!(0.0f32, 1e-40f32, epsilon = 1e-40f32);
        assert_abs_diff_eq!(1e-40f32, 0.0f32, epsilon = 1e-40f32);
        assert_abs_diff_eq!(0.0f32, -1e-40f32, epsilon = 1e-40f32);
        assert_abs_diff_eq!(-1e-40f32, 0.0f32, epsilon = 1e-40f32);

        assert_abs_diff_ne!(1e-40f32, 0.0f32, epsilon = 1e-41f32);
        assert_abs_diff_ne!(0.0f32, 1e-40f32, epsilon = 1e-41f32);
        assert_abs_diff_ne!(-1e-40f32, 0.0f32, epsilon = 1e-41f32);
        assert_abs_diff_ne!(0.0f32, -1e-40f32, epsilon = 1e-41f32);
    }

    func testMax() {
        assert_abs_diff_eq!(f32::MAX, f32::MAX);
        assert_abs_diff_ne!(f32::MAX, -f32::MAX);
        assert_abs_diff_ne!(-f32::MAX, f32::MAX);
        assert_abs_diff_ne!(f32::MAX, f32::MAX / 2.0);
        assert_abs_diff_ne!(f32::MAX, -f32::MAX / 2.0);
        assert_abs_diff_ne!(-f32::MAX, f32::MAX / 2.0);
    }

    // NOTE: abs_diff_eq fails as numbers begin to get very large

    // #[test]
    // func test_infinity() {
    //     assert_abs_diff_eq!(f32::INFINITY, f32::INFINITY);
    //     assert_abs_diff_eq!(f32::NEG_INFINITY, f32::NEG_INFINITY);
    //     assert_abs_diff_ne!(f32::NEG_INFINITY, f32::INFINITY);
    //     assert_abs_diff_eq!(f32::INFINITY, f32::MAX);
    //     assert_abs_diff_eq!(f32::NEG_INFINITY, -f32::MAX);
    // }


    func testNAN() {
        assert_abs_diff_ne!(f32::NAN, f32::NAN);

        assert_abs_diff_ne!(f32::NAN, 0.0);
        assert_abs_diff_ne!(-0.0, f32::NAN);
        assert_abs_diff_ne!(f32::NAN, -0.0);
        assert_abs_diff_ne!(0.0, f32::NAN);

        assert_abs_diff_ne!(f32::NAN, f32::INFINITY);
        assert_abs_diff_ne!(f32::INFINITY, f32::NAN);
        assert_abs_diff_ne!(f32::NAN, f32::NEG_INFINITY);
        assert_abs_diff_ne!(f32::NEG_INFINITY, f32::NAN);

        assert_abs_diff_ne!(f32::NAN, f32::MAX);
        assert_abs_diff_ne!(f32::MAX, f32::NAN);
        assert_abs_diff_ne!(f32::NAN, -f32::MAX);
        assert_abs_diff_ne!(-f32::MAX, f32::NAN);

        assert_abs_diff_ne!(f32::NAN, f32::MIN_POSITIVE);
        assert_abs_diff_ne!(f32::MIN_POSITIVE, f32::NAN);
        assert_abs_diff_ne!(f32::NAN, -f32::MIN_POSITIVE);
        assert_abs_diff_ne!(-f32::MIN_POSITIVE, f32::NAN);
    }


    func testOppositeSigns() {
        assert_abs_diff_ne!(1.000000001f32, -1.0f32);
        assert_abs_diff_ne!(-1.0f32, 1.000000001f32);
        assert_abs_diff_ne!(-1.000000001f32, 1.0f32);
        assert_abs_diff_ne!(1.0f32, -1.000000001f32);

        assert_abs_diff_eq!(10.0 * f32::MIN_POSITIVE, 10.0 * -f32::MIN_POSITIVE);
    }


    func testCloseToZero() {
        assert_abs_diff_eq!(f32::MIN_POSITIVE, f32::MIN_POSITIVE);
        assert_abs_diff_eq!(f32::MIN_POSITIVE, -f32::MIN_POSITIVE);
        assert_abs_diff_eq!(-f32::MIN_POSITIVE, f32::MIN_POSITIVE);

        assert_abs_diff_eq!(f32::MIN_POSITIVE, 0.0f32);
        assert_abs_diff_eq!(0.0f32, f32::MIN_POSITIVE);
        assert_abs_diff_eq!(-f32::MIN_POSITIVE, 0.0f32);
        assert_abs_diff_eq!(0.0f32, -f32::MIN_POSITIVE);

        assert_abs_diff_ne!(0.000001f32, -f32::MIN_POSITIVE);
        assert_abs_diff_ne!(0.000001f32, f32::MIN_POSITIVE);
        assert_abs_diff_ne!(f32::MIN_POSITIVE, 0.000001f32);
        assert_abs_diff_ne!(-f32::MIN_POSITIVE, 0.000001f32);
    }
     */
}
