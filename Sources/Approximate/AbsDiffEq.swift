public protocol AbsDiffEq: Equatable {
    associatedtype Tolerance;

    static var defaultTolerance: Self.Tolerance { get }

    func absDiffEq(_ other: Self, tolerance: Self.Tolerance) -> Bool

    func absDiffNe(_ other: Self, tolerance: Self.Tolerance) -> Bool
}

extension UInt8: AbsDiffEq {
    public typealias Tolerance = UInt8
    
    public static var defaultTolerance: UInt8 { get { 0 } }

    public func absDiffEq(_ other: UInt8, tolerance: UInt8 = defaultTolerance) -> Bool {
        let absDiff = self > other ? (self - other) : (other - self)
        
        return absDiff <= tolerance
    }
    
    public func absDiffNe(_ other: UInt8, tolerance: UInt8 = defaultTolerance) -> Bool {
        !self.absDiffEq(other, tolerance: tolerance)
    }
}

extension UInt16: AbsDiffEq {
    public typealias Tolerance = UInt16
    
    public static var defaultTolerance: UInt16 { get { 0 } }

    public func absDiffEq(_ other: UInt16, tolerance: UInt16 = defaultTolerance) -> Bool {
        let absDiff = self > other ? (self - other) : (other - self)
        
        return absDiff <= tolerance
    }
    
    public func absDiffNe(_ other: UInt16, tolerance: UInt16 = defaultTolerance ) -> Bool {
        !self.absDiffEq(other, tolerance: tolerance)
    }
}

extension UInt32: AbsDiffEq {
    public typealias Tolerance = UInt32
    
    public static var defaultTolerance: UInt32 { get { 0 } }

    public func absDiffEq(_ other: UInt32, tolerance: UInt32 = defaultTolerance) -> Bool {
        let absDiff = self > other ? (self - other) : (other - self)
        
        return absDiff <= tolerance
    }
    
    public func absDiffNe(_ other: UInt32, tolerance: UInt32 = defaultTolerance) -> Bool {
        !self.absDiffEq(other, tolerance: tolerance)
    }
}

extension UInt64: AbsDiffEq {
    public typealias Tolerance = UInt64
    
    public static var defaultTolerance: UInt64 { get { 0 } }

    public func absDiffEq(_ other: UInt64, tolerance: UInt64 = defaultTolerance) -> Bool {
        let absDiff = self > other ? (self - other) : (other - self)
        
        return absDiff <= tolerance
    }
    
    public func absDiffNe(_ other: UInt64, tolerance: UInt64 = defaultTolerance) -> Bool {
        !self.absDiffEq(other, tolerance: tolerance)
    }
}

extension UInt: AbsDiffEq {
    public typealias Tolerance = UInt
    
    public static var defaultTolerance: UInt { get { 0 } }

    public func absDiffEq(_ other: UInt, tolerance: UInt = defaultTolerance) -> Bool {
        let absDiff = self > other ? (self - other) : (other - self)
        
        return absDiff <= tolerance
    }
    
    public func absDiffNe(_ other: UInt, tolerance: UInt = defaultTolerance) -> Bool {
        !self.absDiffEq(other, tolerance: tolerance)
    }
}

extension Int8: AbsDiffEq {
    public typealias Tolerance = Int8;
    
    public static var defaultTolerance: Int8 { get { 0 } }

    public func absDiffEq(_ other: Int8, tolerance: Int8 = defaultTolerance) -> Bool {
        abs(self - other) <= tolerance
    }
    
    public func absDiffNe(_ other: Int8, tolerance: Int8 = defaultTolerance) -> Bool {
        !self.absDiffEq(other, tolerance: tolerance)
    }
}

extension Int16: AbsDiffEq {
    public typealias Tolerance = Int16;
    
    public static var defaultTolerance: Int16 { get { 0 } }

    public func absDiffEq(_ other: Int16, tolerance: Int16 = defaultTolerance) -> Bool {
        abs(self - other) <= tolerance
    }
    
    public func absDiffNe(_ other: Int16, tolerance: Int16 = defaultTolerance) -> Bool {
        !self.absDiffEq(other, tolerance: tolerance)
    }
}

extension Int32: AbsDiffEq {
    public typealias Tolerance = Int32;
    
    public static var defaultTolerance: Int32 { get { 0 } }

    public func absDiffEq(_ other: Int32, tolerance: Int32 = defaultTolerance) -> Bool {
        abs(self - other) <= tolerance
    }
    
    public func absDiffNe(_ other: Int32, tolerance: Int32 = defaultTolerance) -> Bool {
        !self.absDiffEq(other, tolerance: tolerance)
    }
}

extension Int64: AbsDiffEq {
    public typealias Tolerance = Int64;
    
    public static var defaultTolerance: Int64 { get { 0 } }

    public func absDiffEq(_ other: Int64, tolerance: Int64 = defaultTolerance) -> Bool {
        abs(self - other) <= tolerance
    }
    
    public func absDiffNe(_ other: Int64, tolerance: Int64 = defaultTolerance) -> Bool {
        !self.absDiffEq(other, tolerance: tolerance)
    }
}

extension Int: AbsDiffEq {
    public typealias Tolerance = Int;
    
    public static var defaultTolerance: Int { get { 0 } }

    public func absDiffEq(_ other: Int, tolerance: Int = defaultTolerance) -> Bool {
        abs(self - other) <= tolerance
    }
    
    public func absDiffNe(_ other: Int, tolerance: Int = defaultTolerance) -> Bool {
        !self.absDiffEq(other, tolerance: tolerance)
    }
}

extension Float: AbsDiffEq {
    public typealias Tolerance = Float;
    
    public static var defaultTolerance: Float { get { Float.ulpOfOne } }

    public func absDiffEq(_ other: Float, tolerance: Float = defaultTolerance) -> Bool {
        abs(self - other) <= tolerance
    }
    
    public func absDiffNe(_ other: Float, tolerance: Float = defaultTolerance) -> Bool {
        !self.absDiffEq(other, tolerance: tolerance)
    }
}

extension Double: AbsDiffEq {
    public typealias Tolerance = Double;
    
    public static var defaultTolerance: Double { get { Double.ulpOfOne } }

    public func absDiffEq(_ other: Double, tolerance: Double = defaultTolerance) -> Bool {
        abs(self - other) <= tolerance
    }
    
    public func absDiffNe(_ other: Double, tolerance: Double = defaultTolerance) -> Bool {
        !self.absDiffEq(other, tolerance: tolerance)
    }
}

extension Array: AbsDiffEq
where
    Element: AbsDiffEq
{
    public typealias Tolerance = Element.Tolerance;
    
    public static var defaultTolerance: Element.Tolerance {
        get {
            Element.defaultTolerance
        }
    }

    public func absDiffEq(
        _ other: Array<Element>,
        tolerance: Element.Tolerance = defaultTolerance) -> Bool
    {
        self.count == other.count && zip(self, other).allSatisfy({ (lhs, rhs) in
            lhs.absDiffEq(rhs, tolerance: tolerance)
        })
    }
    
    public func absDiffNe(
        _ other: Array<Element>,
        tolerance: Element.Tolerance = defaultTolerance) -> Bool
    {
        !self.absDiffEq(other, tolerance: tolerance)
    }
}

