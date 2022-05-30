

public struct AbsDiff<T>
where
    T: AbsDiffEq
{
    var tolerance: T.Tolerance

    private init(_ tolerance: T.Tolerance) {
        self.tolerance = tolerance
    }

    func tolerance(tolerance: T.Tolerance) -> AbsDiff<T> {
        AbsDiff(tolerance)
    }

    func eq(lhs: T, rhs: T) -> Bool {
        T.absDiffEq(lhs, rhs, tolerance: tolerance)
    }

    func ne(lhs: T, rhs: T) -> Bool {
        T.absDiffNe(lhs, rhs, tolerance: tolerance)
    }
}

