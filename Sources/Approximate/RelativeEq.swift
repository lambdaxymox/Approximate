public protocol RelativeEq: AbsDiffEq {
    static var defaultMaxRelative: Self.Tolerance { get }

    static func relativeEq(
        _ lhs: Self,
        _ rhs: Self,
        tolerance: Self.Tolerance,
        maxRelative: Self.Tolerance
    ) -> Bool

    static func relativeNe(
        _ lhs: Self,
        _ rhs: Self,
        tolerance: Self.Tolerance,
        maxRelative: Self.Tolerance
    ) -> Bool
}

extension Float: RelativeEq {
    public static var defaultMaxRelative: Float {
        get {
            Float.ulpOfOne
        }
    }

    /// Compare two floating point numbers for relative equality.
    ///
    /// The relative equality comparison for floating point numbers is based on
    /// the contents of the article [Comparing Floating Point Numbers, 2012 Edition]
    /// (https://randomascii.wordpress.com/2012/02/25/comparing-floating-point-numbers-2012-edition/)
    ///
    /// - Returns: A boolean indicating whether or not floating point numbers
    /// are relatively equal with respect to a `maxRelative` multiple of the tolerance
    /// `tolerance`.
    public static func relativeEq(
        _ lhs: Float,
        _ rhs: Float,
        tolerance: Float,
        maxRelative: Float) -> Bool
    {
        // If `lhs` and `rhs` are finite and bitwise identical, They are relatively
        // equal. If `lhs` and `rhs` are infinite and bitwise identical, they are
        // the same kind of infinity, and therefore also equal.
        if lhs == rhs {
            return true
        }

        // If `lhs` and `rhs` are finite, this clause does not apply. If one
        // of `lhs` and `rhs` is finite, and the other one is infinite, they
        // are not equal.
        if lhs.isInfinite || rhs.isInfinite {
            return false
        }
        
        // Now check whether `lhs` and `rhs` are really close together.
        let absDiff = abs(lhs - rhs)
        if absDiff <= tolerance {
            return true
        }

        // Finally, if the other cases have failed, we check their relative
        // absolute difference against the largest absolute value of `rhs` and
        // `lhs`.
        let absLhs = abs(lhs)
        let absRhs = abs(rhs)
        let largest = absRhs > absLhs ? absRhs : absLhs

        return absDiff <= largest * maxRelative
    }

    public static func relativeNe(
        _ lhs: Float,
        _ rhs: Float,
        tolerance: Float,
        maxRelative: Float) -> Bool
    {
        !(relativeEq(lhs, rhs, tolerance: tolerance, maxRelative: maxRelative))
    }
}

extension Double: RelativeEq {
    public static var defaultMaxRelative: Double {
        get {
            Double.ulpOfOne
        }
    }

    /// Compare two floating point numbers for relative equality.
    ///
    /// The relative equality comparison for floating point numbers is based on
    /// the contents of the article [Comparing Floating Point Numbers, 2012 Edition]
    /// (https://randomascii.wordpress.com/2012/02/25/comparing-floating-point-numbers-2012-edition/)
    ///
    /// - Returns: A boolean indicating whether or not floating point numbers
    /// are relatively equal with respect to a `maxRelative` multiple of the tolerance
    /// `tolerance`.
    public static func relativeEq(
        _ lhs: Double,
        _ rhs: Double,
        tolerance: Double,
        maxRelative: Double) -> Bool
    {
        // If `lhs` and `rhs` are finite and bitwise identical, They are relatively
        // equal. If `lhs` and `rhs` are infinite and bitwise identical, they are
        // the same kind of infinity, and therefore also equal.
        if lhs == rhs {
            return true
        }

        // If `lhs` and `rhs` are finite, this clause does not apply. If one
        // of `lhs` and `rhs` is finite, and the other one is infinite, they
        // are not equal.
        if lhs.isInfinite || rhs.isInfinite {
            return false
        }
        
        // Now check whether `lhs` and `rhs` are really close together.
        let absDiff = abs(lhs - rhs)
        if absDiff <= tolerance {
            return true
        }

        // Finally, if the other cases have failed, we check their relative
        // absolute difference against the largest absolute value of `rhs` and
        // `lhs`.
        let absLhs = abs(lhs)
        let absRhs = abs(rhs)
        let largest = absRhs > absLhs ? absRhs : absLhs

        return absDiff <= largest * maxRelative
    }

    public static func relativeNe(
        _ lhs: Double,
        _ rhs: Double,
        tolerance: Double,
        maxRelative: Double) -> Bool
    {
        !(relativeEq(lhs, rhs, tolerance: tolerance, maxRelative: maxRelative))
    }
}

extension Array: RelativeEq
where
    Element: RelativeEq
{
    public static var defaultMaxRelative: Element.Tolerance {
        get {
            Element.defaultMaxRelative
        }
    }

    public static func relativeEq(
        _ lhs: Array<Element>,
        _ rhs: Array<Element>,
        tolerance: Element.Tolerance,
        maxRelative: Element.Tolerance) -> Bool
    {
        lhs.count == rhs.count && zip(lhs, rhs).allSatisfy({ (lhsElem, rhsElem) in
            Element.relativeEq(
                lhsElem,
                rhsElem,
                tolerance: tolerance,
                maxRelative: maxRelative
            )
        })
    }
    
    public static func relativeNe(
        _ lhs: Array<Element>,
        _ rhs: Array<Element>,
        tolerance: Element.Tolerance,
        maxRelative: Element.Tolerance) -> Bool
    {
        !(relativeEq(lhs, rhs, tolerance: tolerance, maxRelative: maxRelative))
    }
}

