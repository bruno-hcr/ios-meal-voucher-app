import Foundation
import MealVoucherDetail
import MealVoucherList
import RouterService
import RouterServiceInterface

enum RouteHandlerFactory {
    static func make(with routerService: RouterService) {
        routerService.register(routeHandler: MealVoucherListRouteHandler())
        routerService.register(routeHandler: MealVoucherDetailRouteHandler())
    }
}
