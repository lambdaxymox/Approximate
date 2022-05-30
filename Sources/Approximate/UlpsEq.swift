public protocol UlpsEq: AbsDiffEq {
    static var defaultMaxUlps: UInt32 { get }

    func ulpsEq(
        _ other: Self,
        tolerance: Self.Tolerance,
        maxUlps: UInt32
    ) -> Bool


    func ulpsNe(
        _ other: Self,
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
    public func ulpsEq(
        _ other: Float,
        tolerance: Float = defaultTolerance,
        maxUlps: UInt32 = defaultMaxUlps
    ) -> Bool
    {
        // First check whether the two numbers `self` and `other` are really close
        // together.
        if self.absDiffEq(other, tolerance: tolerance) {
            return true
        }

        // If they do not fall inside the absolute difference equality closeness
        // threshold, compare their signs. Sign comparison is a cheap check
        // before comparing bit patterns.
        if self.sign != other.sign {
            return false
        }

        // Compare the two numbers by their bit patterns.
        let bitsself: UInt32 = self.bitPattern
        let bitsother: UInt32 = other.bitPattern

        if bitsself <= bitsother {
            return (bitsother - bitsself) <= UInt32(maxUlps)
        } else {
            return (bitsself - bitsother) <= UInt32(maxUlps)
        }
    }
    
    public func ulpsNe(
        _ other: Float,
        tolerance: Float = defaultTolerance,
        maxUlps: UInt32 = defaultMaxUlps
    ) -> Bool
    {
        !self.ulpsEq(other, tolerance: tolerance, maxUlps: maxUlps)
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
    public func ulpsEq(
        _ other: Double,
        tolerance: Double = defaultTolerance,
        maxUlps: UInt32 = defaultMaxUlps
    ) -> Bool
    {
        // First check whether the two numbers `self` and `other` are really close
        // together.
        if self.absDiffEq(other, tolerance: tolerance) {
            return true
        }

        // If they do not fall inside the absolute difference equality closeness
        // threshold, compare their signs. Sign comparison is a cheap check
        // before comparing bit patterns.
        if self.sign != other.sign {
            return false
        }

        // Compare the two numbers by their bit patterns.
        let bitsself: UInt64 = self.bitPattern
        let bitsother: UInt64 = other.bitPattern

        if bitsself <= bitsother {
            return (bitsother - bitsself) <= UInt64(maxUlps)
        } else {
            return (bitsself - bitsother) <= UInt64(maxUlps)
        }
    }
    
    public func ulpsNe(
        _ other: Double,
        tolerance: Double = defaultTolerance,
        maxUlps: UInt32 = defaultMaxUlps
    ) -> Bool
    {
        !self.ulpsEq(other, tolerance: tolerance, maxUlps: maxUlps)
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
    
    public func ulpsEq(
        _ other: Self,
        tolerance: Self.Tolerance = defaultTolerance,
        maxUlps: UInt32 = defaultMaxUlps
    ) -> Bool
    {
        self.count == other.count && zip(self, other).allSatisfy({ (lhs, rhs) in
            lhs.ulpsEq(rhs, tolerance: tolerance, maxUlps: maxUlps)
        })
    }

    public func ulpsNe(
        _ other: Self,
        tolerance: Self.Tolerance = defaultTolerance,
        maxUlps: UInt32 = defaultMaxUlps
    ) -> Bool
    {
        !self.ulpsEq(other, tolerance: tolerance, maxUlps: maxUlps)
    }
}

