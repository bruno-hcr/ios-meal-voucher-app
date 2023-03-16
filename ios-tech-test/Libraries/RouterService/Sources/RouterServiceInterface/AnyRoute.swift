import Foundation

/// A type-erased container for a `Route`, used for route decoding purposes.
public struct AnyRoute {
    public let value: Route
    public let routeString: String
}

extension AnyRoute: Hashable {
    public static func == (lhs: AnyRoute, rhs: AnyRoute) -> Bool {
        return lhs.routeString == rhs.routeString
    }

    public func hash(into hasher: inout Hasher) {
        routeString.hash(into: &hasher)
    }
}
