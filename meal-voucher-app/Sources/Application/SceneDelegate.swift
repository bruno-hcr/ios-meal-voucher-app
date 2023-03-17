import UIKit
import MealVoucherList
import MealVoucherListInterface
import RouterService

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    private let routerService = RouterService()

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
        window?.rootViewController = makeNavigationController()
        window?.windowScene = windowScene
        window?.makeKeyAndVisible()
    }

    func makeNavigationController() -> UINavigationController {
        let navigationController = routerService.navigationController(withInitialRoute: MealVoucherListRoute())
        navigationController.navigationBar.prefersLargeTitles = true
        return navigationController
    }
}
