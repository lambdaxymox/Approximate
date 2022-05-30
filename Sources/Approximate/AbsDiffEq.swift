public protocol AbsDiffEq: Equatable {
    associatedtype Tolerance;

    static var defaultTolerance: Self.Tolerance { get }

    static func absDiffEq(_ lhs: Self, _ rhs: Self, tolerance: Self.Tolerance) -> Bool

    static func absDiffNe(_ lhs: Self, _ rhs: Self, tolerance: Self.Tolerance) -> Bool
}

extension UInt8: AbsDiffEq {
    public typealias Tolerance = UInt8
    
    public static var defaultTolerance: UInt8 { get { 0 } }

    public static func absDiffEq(_ lhs: UInt8, _ rhs: UInt8, tolerance: UInt8) -> Bool {
        let absDiff: UInt8 = {
            if lhs > rhs {
                return lhs - rhs
            } else {
                return rhs - lhs
            }
        }()
        
        return absDiff <= tolerance
    }
    
    public static func absDiffNe(_ lhs: UInt8, _ rhs: UInt8, tolerance: UInt8) -> Bool {
        !(absDiffEq(lhs, rhs, tolerance: tolerance))
    }
}

extension UInt16: AbsDiffEq {
    public typealias Tolerance = UInt16
    
    public static var defaultTolerance: UInt16 { get { 0 } }

    public static func absDiffEq(_ lhs: UInt16, _ rhs: UInt16, tolerance: UInt16) -> Bool {
        let absDiff: UInt16 = {
            if lhs > rhs {
                return lhs - rhs
            } else {
                return rhs - lhs
            }
        }()
        
        return absDiff <= tolerance
    }
    
    public static func absDiffNe(_ lhs: UInt16, _ rhs: UInt16, tolerance: UInt16) -> Bool {
        !(absDiffEq(lhs, rhs, tolerance: tolerance))
    }
}

extension UInt32: AbsDiffEq {
    public typealias Tolerance = UInt32
    
    public static var defaultTolerance: UInt32 { get { 0 } }

    public static func absDiffEq(_ lhs: UInt32, _ rhs: UInt32, tolerance: UInt32) -> Bool {
        let absDiff: UInt32 = {
            if lhs > rhs {
                return lhs - rhs
            } else {
                return rhs - lhs
            }
        }()
        
        return absDiff <= tolerance
    }
    
    public static func absDiffNe(_ lhs: UInt32, _ rhs: UInt32, tolerance: UInt32) -> Bool {
        !(absDiffEq(lhs, rhs, tolerance: tolerance))
    }
}

extension UInt64: AbsDiffEq {
    public typealias Tolerance = UInt64
    
    public static var defaultTolerance: UInt64 { get { 0 } }

    public static func absDiffEq(_ lhs: UInt64, _ rhs: UInt64, tolerance: UInt64) -> Bool {
        let absDiff: UInt64 = {
            if lhs > rhs {
                return lhs - rhs
            } else {
                return rhs - lhs
            }
        }()
        
        return absDiff <= tolerance
    }
    
    public static func absDiffNe(_ lhs: UInt64, _ rhs: UInt64, tolerance: UInt64) -> Bool {
        !(absDiffEq(lhs, rhs, tolerance: tolerance))
    }
}

extension UInt: AbsDiffEq {
    public typealias Tolerance = UInt
    
    public static var defaultTolerance: UInt { get { 0 } }

    public static func absDiffEq(_ lhs: UInt, _ rhs: UInt, tolerance: UInt) -> Bool {
        let absDiff: UInt = {
            if lhs > rhs {
                return lhs - rhs
            } else {
                return rhs - lhs
            }
        }()
        
        return absDiff <= tolerance
    }
    
    public static func absDiffNe(_ lhs: UInt, _ rhs: UInt, tolerance: UInt) -> Bool {
        !(absDiffEq(lhs, rhs, tolerance: tolerance))
    }
}

extension Int8: AbsDiffEq {
    public typealias Tolerance = Int8;
    
    public static var defaultTolerance: Int8 { get { 0 } }

    public static func absDiffEq(_ lhs: Int8, _ rhs: Int8, tolerance: Int8) -> Bool {
        abs(lhs - rhs) <= tolerance
    }
    
    public static func absDiffNe(_ lhs: Int8, _ rhs: Int8, tolerance: Int8) -> Bool {
        !(absDiffEq(lhs, rhs, tolerance: tolerance))
    }
}

extension Int16: AbsDiffEq {
    public typealias Tolerance = Int16;
    
    public static var defaultTolerance: Int16 { get { 0 } }

    public static func absDiffEq(_ lhs: Int16, _ rhs: Int16, tolerance: Int16) -> Bool {
        abs(lhs - rhs) <= tolerance
    }
    
    public static func absDiffNe(_ lhs: Int16, _ rhs: Int16, tolerance: Int16) -> Bool {
        !(absDiffEq(lhs, rhs, tolerance: tolerance))
    }
}

extension Int32: AbsDiffEq {
    public typealias Tolerance = Int32;
    
    public static var defaultTolerance: Int32 { get { 0 } }

    public static func absDiffEq(_ lhs: Int32, _ rhs: Int32, tolerance: Int32) -> Bool {
        abs(lhs - rhs) <= tolerance
    }
    
    public static func absDiffNe(_ lhs: Int32, _ rhs: Int32, tolerance: Int32) -> Bool {
        !(absDiffEq(lhs, rhs, tolerance: tolerance))
    }
}

extension Int64: AbsDiffEq {
    public typealias Tolerance = Int64;
    
    public static var defaultTolerance: Int64 { get { 0 } }

    public static func absDiffEq(_ lhs: Int64, _ rhs: Int64, tolerance: Int64) -> Bool {
        abs(lhs - rhs) <= tolerance
    }
    
    public static func absDiffNe(_ lhs: Int64, _ rhs: Int64, tolerance: Int64) -> Bool {
        !(absDiffEq(lhs, rhs, tolerance: tolerance))
    }
}

extension Int: AbsDiffEq {
    public typealias Tolerance = Int;
    
    public static var defaultTolerance: Int { get { 0 } }

    public static func absDiffEq(_ lhs: Int, _ rhs: Int, tolerance: Int) -> Bool {
        abs(lhs - rhs) <= tolerance
    }
    
    public static func absDiffNe(_ lhs: Int, _ rhs: Int, tolerance: Int) -> Bool {
        !(absDiffEq(lhs, rhs, tolerance: tolerance))
    }
}

extension Float: AbsDiffEq {
    public typealias Tolerance = Float;
    
    public static var defaultTolerance: Float { get { Float.ulpOfOne } }

    public static func absDiffEq(_ lhs: Float, _ rhs: Float, tolerance: Float) -> Bool {
        abs(lhs - rhs) <= tolerance
    }
    
    public static func absDiffNe(_ lhs: Float, _ rhs: Float, tolerance: Float) -> Bool {
        !(absDiffEq(lhs, rhs, tolerance: tolerance))
    }
}

extension Double: AbsDiffEq {
    public typealias Tolerance = Double;
    
    public static var defaultTolerance: Double { get { Double.ulpOfOne } }

    public static func absDiffEq(_ lhs: Double, _ rhs: Double, tolerance: Double) -> Bool {
        abs(lhs - rhs) <= tolerance
    }
    
    public static func absDiffNe(_ lhs: Double, _ rhs: Double, tolerance: Double) -> Bool {
        !(absDiffEq(lhs, rhs, tolerance: tolerance))
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

    public static func absDiffEq(
        _ lhs: Array<Element>, _ rhs: Array<Element>, tolerance: Element.Tolerance) -> Bool
    {
        lhs.count == rhs.count && zip(lhs, rhs).allSatisfy({ (lhsElem, rhsElem) in
            Element.absDiffEq(lhsElem, rhsElem, tolerance: tolerance)
        })
    }
    
    public static func absDiffNe(
        _ lhs: Array<Element>, _ rhs: Array<Element>, tolerance: Element.Tolerance) -> Bool
    {
        !(absDiffEq(lhs, rhs, tolerance: tolerance))
    }
}

