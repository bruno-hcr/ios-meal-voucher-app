import UIKit
import MealVoucherListInterface
import RouterServiceInterface

public final class MealVoucherListRouteHandler: RouteHandler {
    public let routes: [Route.Type] = [
        MealVoucherListRoute.self
    ]

    public init() {}

    public func destination(
        forRoute route: Route,
        fromViewController viewController: UIViewController
    ) -> Feature.Type {
        guard route is MealVoucherListRoute else {
            preconditionFailure()
        }

        return MealVoucherListFeature.self
    }
}
