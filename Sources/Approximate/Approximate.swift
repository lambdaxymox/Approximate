/// Compare two floating point numbers for absolute difference equality.
///
/// Two floating point numbers are equal relative to some error if the
/// following condition holds.
///
/// Given floating point numbers `lhs` and `rhs`, and an error `tol`, we say
/// that `lhs` and `rhs` are approximately equal within tolerance `tol`
/// provided that
/// ```
/// abs(lhs - rhs) <= tol
/// ```
///
/// - Returns: A boolean indicating whether or not two floating point
/// numbers are absolute difference equal with respect to a tolerance
/// `tolerance`.
public func absDiffEq<T: AbsDiffEq>(
    _ lhs: T,
    _ rhs: T,
    tolerance: T.Tolerance = T.defaultTolerance) -> Bool
{
    lhs.absDiffEq(rhs, tolerance: tolerance)
}

/// Compare two floating point numbers for absolute difference inequality.
///
/// Two floating point numbers are approximately inequal within tolerance
/// `tol` provided that they are not approximately equal within tolerance
/// `tol`.
///
/// - Returns: A boolean indicating whether or not two floating point
/// numbers are absolute difference inequal with respect to a tolerance
/// `tolerance`.
public func absDiffNe<T: AbsDiffEq>(
    _ lhs: T,
    _ rhs: T,
    tolerance: T.Tolerance = T.defaultTolerance) -> Bool
{
    lhs.absDiffNe(rhs, tolerance: tolerance)
}

/// Compare two floating point numbers for relative equality.
///
/// The relative equality comparison for floating point numbers is based on
/// the contents of the article [Comparing Floating Point Numbers, 2012 Edition]
/// (https://randomascii.wordpress.com/2012/02/25/comparing-floating-point-numbers-2012-edition/)
///
/// - Returns: A boolean indicating whether or not two floating point numbers
/// are relatively equal with respect to a `maxRelative` multiple of the
/// tolerance `tolerance`.
public func relativeEq<T: RelativeEq>(
    _ lhs: T,
    _ rhs: T,
    tolerance: T.Tolerance = T.defaultTolerance,
    maxRelative: T.Tolerance = T.defaultMaxRelative) -> Bool
{
    lhs.relativeEq(rhs, tolerance: tolerance, maxRelative: maxRelative)
}

/// Compare two floating point numbers for relative inequality.
///
/// The relative inequality comparison for floating point numbers is based on
/// the contents of the article [Comparing Floating Point Numbers, 2012 Edition]
/// (https://randomascii.wordpress.com/2012/02/25/comparing-floating-point-numbers-2012-edition/)
///
/// - Returns: A boolean indicating whether or not two floating point numbers
/// are relatively inequal with respect to a `maxRelative` multiple of the
/// tolerance `tolerance`.
public func relativeNe<T: RelativeEq>(
    _ lhs: T,
    _ rhs: T,
    tolerance: T.Tolerance = T.defaultTolerance,
    maxRelative: T.Tolerance = T.defaultMaxRelative) -> Bool
{
    lhs.relativeNe(rhs, tolerance: tolerance, maxRelative: maxRelative)
}

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
public func ulpsEq<T: UlpsEq>(
    _ lhs: T,
    _ rhs: T,
    tolerance: T.Tolerance = T.defaultTolerance,
    maxUlps: UInt32 = T.defaultMaxUlps) -> Bool
{
    lhs.ulpsEq(rhs, tolerance: tolerance, maxUlps: maxUlps)
}

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
public func ulpsNe<T: UlpsEq>(
    _ lhs: T,
    _ rhs: T,
    tolerance: T.Tolerance = T.defaultTolerance,
    maxUlps: UInt32 = T.defaultMaxUlps) -> Bool
{
    lhs.ulpsNe(rhs, tolerance: tolerance, maxUlps: maxUlps)
}

