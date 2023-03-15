import UIKit
import MealVoucherList
import MealVoucherListInterface

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = scene as? UIWindowScene else { return }

        RouteHandlerFactory.make(with: routerService)
        DependencyFactory.make(with: routerService)

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = makeInitialNavigationController()
        window?.windowScene = windowScene
        window?.makeKeyAndVisible()
    }

    func makeInitialNavigationController() -> UIViewController {
        let routeHandler = MealVoucherListRouteHandler()
        let route = MealVoucherListRoute()
        let feature = routeHandler.destination(forRoute: route, fromViewController: UIViewController())
        return routerService.navigationController(withInitialFeature: feature)
    }
}
