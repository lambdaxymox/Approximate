public protocol RelativeEq: AbsDiffEq {
    static var defaultMaxRelative: Self.Tolerance { get }

    func relativeEq(
        _ other: Self,
        tolerance: Self.Tolerance,
        maxRelative: Self.Tolerance
    ) -> Bool

    func relativeNe(
        _ other: Self,
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
    public func relativeEq(
        _ other: Float,
        tolerance: Float = defaultTolerance, maxRelative: Float = defaultMaxRelative) -> Bool
    {
        // If `self` and `other` are finite and bitwise identical, They are relatively
        // equal. If `self` and `other` are infinite and bitwise identical, they are
        // the same kind of infinity, and therefore also equal.
        if self == other {
            return true
        }

        // If `self` and `other` are finite, this clause does not apply. If one
        // of `self` and `other` is finite, and the other one is infinite, they
        // are not equal.
        if self.isInfinite || other.isInfinite {
            return false
        }
        
        // Now check whether `self` and `other` are really close together.
        let absDiff = abs(self - other)
        if absDiff <= tolerance {
            return true
        }

        // Finally, if the other cases have failed, we check their relative
        // absolute difference against the largest absolute value of `other` and
        // `self`.
        let absself = abs(self)
        let absother = abs(other)
        let largest = absother > absself ? absother : absself

        return absDiff <= largest * maxRelative
    }

    public func relativeNe(
        _ other: Float,
        tolerance: Float = defaultTolerance, maxRelative: Float = defaultMaxRelative) -> Bool
    {
        !self.relativeEq(other, tolerance: tolerance, maxRelative: maxRelative)
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
    public func relativeEq(
        _ other: Double,
        tolerance: Double = defaultTolerance, maxRelative: Double = defaultMaxRelative) -> Bool
    {
        // If `self` and `other` are finite and bitwise identical, They are relatively
        // equal. If `self` and `other` are infinite and bitwise identical, they are
        // the same kind of infinity, and therefore also equal.
        if self == other {
            return true
        }

        // If `self` and `other` are finite, this clause does not apply. If one
        // of `self` and `other` is finite, and the other one is infinite, they
        // are not equal.
        if self.isInfinite || other.isInfinite {
            return false
        }
        
        // Now check whether `self` and `other` are really close together.
        let absDiff = abs(self - other)
        if absDiff <= tolerance {
            return true
        }

        // Finally, if the other cases have failed, we check their relative
        // absolute difference against the largest absolute value of `other` and
        // `self`.
        let absself = abs(self)
        let absother = abs(other)
        let largest = absother > absself ? absother : absself

        return absDiff <= largest * maxRelative
    }

    public func relativeNe(
        _ other: Double,
        tolerance: Double = defaultTolerance, maxRelative: Double = defaultMaxRelative) -> Bool
    {
        !self.relativeEq(other, tolerance: tolerance, maxRelative: maxRelative)
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

    public func relativeEq(
        _ other: Array<Element>,
        tolerance: Element.Tolerance = defaultTolerance,
        maxRelative: Element.Tolerance = defaultMaxRelative) -> Bool
    {
        self.count == other.count && zip(self, other).allSatisfy({ (lhs, rhs) in
            lhs.relativeEq(rhs, tolerance: tolerance, maxRelative: maxRelative)
        })
    }
    
    public func relativeNe(
        _ other: Array<Element>,
        tolerance: Element.Tolerance = defaultTolerance,
        maxRelative: Element.Tolerance = defaultMaxRelative) -> Bool
    {
        !self.relativeEq(other, tolerance: tolerance, maxRelative: maxRelative)
    }
}

