public protocol UlpsEq: AbsDiffEq {
    /// The default maximum number of units in last place when one is not
    /// specified at the time of comparison.
    static var defaultMaxUlps: UInt32 { get }

    /// Compare two floating point numbers for units in last place (ULPS)
    /// equality.
    ///
    /// The ulps equality comparison for floating point numbers is based on
    /// the contents of the article [Comparing Floating Point Numbers, 2012 Edition]
    /// (https://randomascii.wordpress.com/2012/02/25/comparing-floating-point-numbers-2012-edition/)
    ///
    /// - Returns: A boolean indicating whether or not two are floating point
    /// numbers are equal with respect to a maximum number `maxUlps` of units
    /// in last place.
    func ulpsEq(_ other: Self, tolerance: Self.Tolerance, maxUlps: UInt32) -> Bool

    /// Compare two floating point numbers for units in last place (ULPS)
    /// inequality.
    ///
    /// The ulps inequality comparison for floating point numbers is based on
    /// the contents of the article [Comparing Floating Point Numbers, 2012 Edition]
    /// (https://randomascii.wordpress.com/2012/02/25/comparing-floating-point-numbers-2012-edition/)
    ///
    /// - Returns: A boolean indicating whether or not two are floating point
    /// numbers are inequal with respect to a maximum number `maxUlps` of units
    /// in last place.
    func ulpsNe(_ other: Self, tolerance: Self.Tolerance, maxUlps: UInt32) -> Bool
}

extension Float: UlpsEq {
    public static var defaultMaxUlps: UInt32 { get { 4 } }

    public func ulpsEq(
        _ other: Float,
        tolerance: Float = defaultTolerance, maxUlps: UInt32 = defaultMaxUlps) -> Bool
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
        tolerance: Float = defaultTolerance, maxUlps: UInt32 = defaultMaxUlps) -> Bool
    {
        !self.ulpsEq(other, tolerance: tolerance, maxUlps: maxUlps)
    }
}

extension Double: UlpsEq {
    public static var defaultMaxUlps: UInt32 {
        get { 4 }
    }

    public func ulpsEq(
        _ other: Double,
        tolerance: Double = defaultTolerance, maxUlps: UInt32 = defaultMaxUlps) -> Bool
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
        tolerance: Double = defaultTolerance, maxUlps: UInt32 = defaultMaxUlps) -> Bool
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
        tolerance: Self.Tolerance = defaultTolerance, maxUlps: UInt32 = defaultMaxUlps) -> Bool
    {
        if self.count != other.count {
            return false
        }
        
        // PEFORMANCE: Is Swift/LLVM smart enough to vectorize this loop?
        var result = true
        for i in 0...self.count {
            result = result && self[i].ulpsEq(other[i], tolerance: tolerance, maxUlps: maxUlps)
        }
        
        return result
    }

    public func ulpsNe(
        _ other: Self,
        tolerance: Self.Tolerance = defaultTolerance, maxUlps: UInt32 = defaultMaxUlps) -> Bool
    {
        !self.ulpsEq(other, tolerance: tolerance, maxUlps: maxUlps)
    }
}

extension SIMD2: UlpsEq
where
    Scalar: UlpsEq,
    Scalar: FloatingPoint
{
    public static var defaultMaxUlps: UInt32 {
        get {
            Scalar.defaultMaxUlps
        }
    }
    
    public func ulpsEq(
        _ other: SIMD2<Scalar>,
        tolerance: Scalar.Tolerance = defaultTolerance, maxUlps: UInt32 = defaultMaxUlps) -> Bool
    {
        // PEFORMANCE: Is Swift/LLVM smart enough to vectorize this loop?
        var result = true
        for i in 0..<self.scalarCount {
            result = result && self[i].ulpsEq(other[i], tolerance: tolerance, maxUlps: maxUlps)
        }
        
        return result
    }
    
    public func ulpsNe(
        _ other: SIMD2<Scalar>,
        tolerance: Scalar.Tolerance = defaultTolerance, maxUlps: UInt32 = defaultMaxUlps) -> Bool
    {
        !self.ulpsEq(other, tolerance: tolerance, maxUlps: maxUlps)
    }
}

extension SIMD3: UlpsEq
where
    Scalar: UlpsEq,
    Scalar: FloatingPoint
{
    public static var defaultMaxUlps: UInt32 {
        get {
            Scalar.defaultMaxUlps
        }
    }
    
    public func ulpsEq(
        _ other: SIMD3<Scalar>,
        tolerance: Scalar.Tolerance = defaultTolerance, maxUlps: UInt32 = defaultMaxUlps) -> Bool
    {
        // PEFORMANCE: Is Swift/LLVM smart enough to vectorize this loop?
        var result = true
        for i in 0..<self.scalarCount {
            result = result && self[i].ulpsEq(other[i], tolerance: tolerance, maxUlps: maxUlps)
        }
        
        return result
    }
    
    public func ulpsNe(
        _ other: SIMD3<Scalar>,
        tolerance: Scalar.Tolerance = defaultTolerance, maxUlps: UInt32 = defaultMaxUlps) -> Bool
    {
        !self.ulpsEq(other, tolerance: tolerance, maxUlps: maxUlps)
    }
}

extension SIMD4: UlpsEq
where
    Scalar: UlpsEq,
    Scalar: FloatingPoint
{
    public static var defaultMaxUlps: UInt32 {
        get {
            Scalar.defaultMaxUlps
        }
    }
    
    public func ulpsEq(
        _ other: SIMD4<Scalar>,
        tolerance: Scalar.Tolerance = defaultTolerance, maxUlps: UInt32 = defaultMaxUlps) -> Bool
    {
        // PEFORMANCE: Is Swift/LLVM smart enough to vectorize this loop?
        var result = true
        for i in 0..<self.scalarCount {
            result = result && self[i].ulpsEq(other[i], tolerance: tolerance, maxUlps: maxUlps)
        }
        
        return result
    }
    
    public func ulpsNe(
        _ other: SIMD4<Scalar>,
        tolerance: Scalar.Tolerance = defaultTolerance, maxUlps: UInt32 = defaultMaxUlps) -> Bool
    {
        !self.ulpsEq(other, tolerance: tolerance, maxUlps: maxUlps)
    }
}

extension SIMD8: UlpsEq
where
    Scalar: UlpsEq,
    Scalar: FloatingPoint
{
    public static var defaultMaxUlps: UInt32 {
        get {
            Scalar.defaultMaxUlps
        }
    }
    
    public func ulpsEq(
        _ other: SIMD8<Scalar>,
        tolerance: Scalar.Tolerance = defaultTolerance, maxUlps: UInt32 = defaultMaxUlps) -> Bool
    {
        // PEFORMANCE: Is Swift/LLVM smart enough to vectorize this loop?
        var result = true
        for i in 0..<self.scalarCount {
            result = result && self[i].ulpsEq(other[i], tolerance: tolerance, maxUlps: maxUlps)
        }
        
        return result
    }
    
    public func ulpsNe(
        _ other: SIMD8<Scalar>,
        tolerance: Scalar.Tolerance = defaultTolerance, maxUlps: UInt32 = defaultMaxUlps) -> Bool
    {
        !self.ulpsEq(other, tolerance: tolerance, maxUlps: maxUlps)
    }
}

extension SIMD16: UlpsEq
where
    Scalar: UlpsEq,
    Scalar: FloatingPoint
{
    public static var defaultMaxUlps: UInt32 {
        get {
            Scalar.defaultMaxUlps
        }
    }
    
    public func ulpsEq(
        _ other: SIMD16<Scalar>,
        tolerance: Scalar.Tolerance = defaultTolerance, maxUlps: UInt32 = defaultMaxUlps) -> Bool
    {
        // PEFORMANCE: Is Swift/LLVM smart enough to vectorize this loop?
        var result = true
        for i in 0..<self.scalarCount {
            result = result && self[i].ulpsEq(other[i], tolerance: tolerance, maxUlps: maxUlps)
        }
        
        return result
    }
    
    public func ulpsNe(
        _ other: SIMD16<Scalar>,
        tolerance: Scalar.Tolerance = defaultTolerance, maxUlps: UInt32 = defaultMaxUlps) -> Bool
    {
        !self.ulpsEq(other, tolerance: tolerance, maxUlps: maxUlps)
    }
}

extension SIMD32: UlpsEq
where
    Scalar: UlpsEq,
    Scalar: FloatingPoint
{
    public static var defaultMaxUlps: UInt32 {
        get {
            Scalar.defaultMaxUlps
        }
    }
    
    public func ulpsEq(
        _ other: SIMD32<Scalar>,
        tolerance: Scalar.Tolerance = defaultTolerance, maxUlps: UInt32 = defaultMaxUlps) -> Bool
    {
        // PEFORMANCE: Is Swift/LLVM smart enough to vectorize this loop?
        var result = true
        for i in 0..<self.scalarCount {
            result = result && self[i].ulpsEq(other[i], tolerance: tolerance, maxUlps: maxUlps)
        }
        
        return result
    }
    
    public func ulpsNe(
        _ other: SIMD32<Scalar>,
        tolerance: Scalar.Tolerance = defaultTolerance, maxUlps: UInt32 = defaultMaxUlps) -> Bool
    {
        !self.ulpsEq(other, tolerance: tolerance, maxUlps: maxUlps)
    }
}

extension SIMD64: UlpsEq
where
    Scalar: UlpsEq,
    Scalar: FloatingPoint
{
    public static var defaultMaxUlps: UInt32 {
        get {
            Scalar.defaultMaxUlps
        }
    }
    
    public func ulpsEq(
        _ other: SIMD64<Scalar>,
        tolerance: Scalar.Tolerance = defaultTolerance, maxUlps: UInt32 = defaultMaxUlps) -> Bool
    {
        // PEFORMANCE: Is Swift/LLVM smart enough to vectorize this loop?
        var result = true
        for i in 0..<self.scalarCount {
            result = result && self[i].ulpsEq(other[i], tolerance: tolerance, maxUlps: maxUlps)
        }
        
        return result
    }
    
    public func ulpsNe(
        _ other: SIMD64<Scalar>,
        tolerance: Scalar.Tolerance = defaultTolerance, maxUlps: UInt32 = defaultMaxUlps) -> Bool
    {
        !self.ulpsEq(other, tolerance: tolerance, maxUlps: maxUlps)
    }
}

