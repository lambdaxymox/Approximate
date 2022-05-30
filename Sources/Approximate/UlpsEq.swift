public protocol UlpsEq: AbsDiffEq {
    static var defaultMaxUlps: UInt32 { get }

    static func ulpsEq(
        _ lhs: Self,
        _ rhs: Self,
        tolerance: Self.Tolerance,
        maxUlps: UInt32
    ) -> Bool


    static func ulpsNe(
        _ lhs: Self,
        _ rhs: Self,
        tolerance: Self.Tolerance,
        maxUlps: UInt32
    ) -> Bool
}

extension Float: UlpsEq {
    public static var defaultMaxUlps: UInt32 { get { 4 } }

    /// Compare two floating point numbers for units in last place (ULPS)
    /// equality.
    ///
    /// The ulps equality comparison for floating point numbers is based on
    /// the contents of the article [Comparing Floating Point Numbers, 2012 Edition]
    /// (https://randomascii.wordpress.com/2012/02/25/comparing-floating-point-numbers-2012-edition/)
    ///
    /// - Returns: A boolean indicating whether or not floating point numbers
    /// with respect to a maximum number `maxUlps` of units in last place.
    public static func ulpsEq(
        _ lhs: Float,
        _ rhs: Float,
        tolerance: Float = defaultTolerance,
        maxUlps: UInt32 = defaultMaxUlps
    ) -> Bool
    {
        // First check whether the two numbers `lhs` and `rhs` are really close
        // together.
        if lhs.absDiffEq(rhs, tolerance: tolerance) {
            return true
        }

        // If they do not fall inside the absolute difference equality closeness
        // threshold, compare their signs. Sign comparison is a cheap check
        // before comparing bit patterns.
        if lhs.sign != rhs.sign {
            return false
        }

        // Compare the two numbers by their bit patterns.
        let bitsLhs: UInt32 = lhs.bitPattern
        let bitsRhs: UInt32 = rhs.bitPattern

        if bitsLhs <= bitsRhs {
            return (bitsRhs - bitsLhs) <= UInt32(maxUlps)
        } else {
            return (bitsLhs - bitsRhs) <= UInt32(maxUlps)
        }
    }
    
    public static func ulpsNe(
        _ lhs: Float,
        _ rhs: Float,
        tolerance: Float = defaultTolerance,
        maxUlps: UInt32 = defaultMaxUlps
    ) -> Bool
    {
        !ulpsEq(lhs, rhs, tolerance: tolerance, maxUlps: maxUlps)
    }
}

extension Double: UlpsEq {
    public static var defaultMaxUlps: UInt32 {
        get { 4 }
    }

    /// Compare two floating point numbers for units in last place (ULPS)
    /// equality.
    ///
    /// The ulps equality comparison for floating point numbers is based on
    /// the contents of the article [Comparing Floating Point Numbers, 2012 Edition]
    /// (https://randomascii.wordpress.com/2012/02/25/comparing-floating-point-numbers-2012-edition/)
    ///
    /// - Returns: A boolean indicating whether or not floating point numbers
    /// with respect to a maximum number `maxUlps` of units in last place.
    public static func ulpsEq(
        _ lhs: Double,
        _ rhs: Double,
        tolerance: Double = defaultTolerance,
        maxUlps: UInt32 = defaultMaxUlps
    ) -> Bool
    {
        // First check whether the two numbers `lhs` and `rhs` are really close
        // together.
        if lhs.absDiffEq(rhs, tolerance: tolerance) {
            return true
        }

        // If they do not fall inside the absolute difference equality closeness
        // threshold, compare their signs. Sign comparison is a cheap check
        // before comparing bit patterns.
        if lhs.sign != rhs.sign {
            return false
        }

        // Compare the two numbers by their bit patterns.
        let bitsLhs: UInt64 = lhs.bitPattern
        let bitsRhs: UInt64 = rhs.bitPattern

        if bitsLhs <= bitsRhs {
            return (bitsRhs - bitsLhs) <= UInt64(maxUlps)
        } else {
            return (bitsLhs - bitsRhs) <= UInt64(maxUlps)
        }
    }
    
    public static func ulpsNe(
        _ lhs: Double,
        _ rhs: Double,
        tolerance: Double = defaultTolerance,
        maxUlps: UInt32 = defaultMaxUlps
    ) -> Bool
    {
        !ulpsEq(lhs, rhs, tolerance: tolerance, maxUlps: maxUlps)
    }
}


extension Array: UlpsEq
where
    Element: UlpsEq
{
    public static var defaultMaxUlps: UInt32 {
        get {
            Element.defaultMaxUlps
        }
    }
    
    public static func ulpsEq(
        _ lhs: Self,
        _ rhs: Self,
        tolerance: Self.Tolerance = defaultTolerance,
        maxUlps: UInt32 = defaultMaxUlps
    ) -> Bool
    {
        lhs.count == rhs.count && zip(lhs, rhs).allSatisfy({ (lhsElem, rhsElem) in
            Element.ulpsEq(
                lhsElem,
                rhsElem,
                tolerance: tolerance,
                maxUlps: maxUlps
            )
        })
    }

    public static func ulpsNe(
        _ lhs: Self,
        _ rhs: Self,
        tolerance: Self.Tolerance = defaultTolerance,
        maxUlps: UInt32 = defaultMaxUlps
    ) -> Bool
    {
        !ulpsEq(lhs, rhs, tolerance: tolerance, maxUlps: maxUlps)
    }
}

