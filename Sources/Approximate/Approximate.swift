public func absDiffEq<T: AbsDiffEq>(
    _ lhs: T,
    _ rhs: T,
    tolerance: T.Tolerance = T.defaultTolerance) -> Bool
{
    lhs.absDiffEq(rhs, tolerance: tolerance)
}

public func absDiffNe<T: AbsDiffEq>(
    _ lhs: T,
    _ rhs: T,
    tolerance: T.Tolerance = T.defaultTolerance) -> Bool
{
    lhs.absDiffNe(rhs, tolerance: tolerance)
}

public func relativeEq<T: RelativeEq>(
    _ lhs: T,
    _ rhs: T,
    tolerance: T.Tolerance = T.defaultTolerance,
    maxRelative: T.Tolerance = T.defaultMaxRelative) -> Bool
{
    lhs.relativeEq(rhs, tolerance: tolerance, maxRelative: maxRelative)
}

public func relativeNe<T: RelativeEq>(
    _ lhs: T,
    _ rhs: T,
    tolerance: T.Tolerance = T.defaultTolerance,
    maxRelative: T.Tolerance = T.defaultMaxRelative) -> Bool
{
    lhs.relativeNe(rhs, tolerance: tolerance, maxRelative: maxRelative)
}

public func ulpsEq<T: UlpsEq>(
    _ lhs: T,
    _ rhs: T,
    tolerance: T.Tolerance = T.defaultTolerance,
    maxUlps: UInt32 = T.defaultMaxUlps) -> Bool
{
    lhs.ulpsEq(rhs, tolerance: tolerance, maxUlps: maxUlps)
}

public func ulpsNe<T: UlpsEq>(
    _ lhs: T,
    _ rhs: T,
    tolerance: T.Tolerance = T.defaultTolerance,
    maxUlps: UInt32 = T.defaultMaxUlps) -> Bool
{
    lhs.ulpsNe(rhs, tolerance: tolerance, maxUlps: maxUlps)
}

