import Foundation
import RouterServiceInterface
import UIKit

public final class RouterService: RouterServiceProtocol, RouterServiceRegistrationProtocol {
    let store: StoreInterface
    let failureHandler: () -> Void

    private(set) var registeredRoutes = [String: RouteHandler]()

    public init(
        store: StoreInterface? = nil,
        failureHandler: @escaping () -> Void = { preconditionFailure() }
    ) {
        self.store = store ?? Store()
        self.failureHandler = failureHandler
        register(dependencyFactory: { [unowned self] in
            self
        }, forType: RouterServiceProtocol.self)
    }

    public func register<T>(
        dependencyFactory: @escaping DependencyFactory,
        forType metaType: T.Type
    ) {
        store.register(dependencyFactory, forMetaType: metaType)
    }

    public func register(routeHandler: RouteHandler) {
        routeHandler.routes.forEach {
            registeredRoutes[$0.identifier] = routeHandler
        }
    }

    public func navigationController(withInitialRoute route: Route) -> UINavigationController {
        guard let handler = handler(forRoute: route) else {
            return UINavigationController()
        }
        let feature = handler.destination(forRoute: route)
        let instance = feature.initialize(withStore: store)
        let rootViewController = instance.build(fromRoute: route)
        return UINavigationController(rootViewController: rootViewController)
    }

    public func navigate(
        toRoute route: Route,
        fromView viewController: UIViewController,
        presentationStyle: PresentationStyle,
        animated: Bool,
        completion: (() -> Void)? = nil
    ) {
        guard let handler = handler(forRoute: route) else {
            failureHandler()
            return
        }
        let destinationFeatureType = handler.destination(
            forRoute: route
        )
        let destinationFeature = destinationFeatureType.initialize(withStore: store)
        let destinationViewController: UIViewController

        if destinationFeature.isEnabled() {
            destinationViewController = destinationFeature.build(fromRoute: route)
        } else {
            let fallbackFeatureType = destinationFeature.fallback(forRoute: route)
            guard let fallbackDestinationFeature = fallbackFeatureType?.initialize(withStore: store) else {
                failureHandler()
                return
            }

            destinationViewController = fallbackDestinationFeature.build(fromRoute: route)
        }

        presentationStyle.present(
            viewController: destinationViewController,
            fromViewController: viewController,
            animated: animated,
            completion: completion
        )
    }

    func handler(forRoute route: Route) -> RouteHandler? {
        let routeIdentifier = type(of: route).identifier
        return registeredRoutes[routeIdentifier]
    }
}
