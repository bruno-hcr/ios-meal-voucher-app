import Foundation
import Network
import NetworkInterface
import RouterService
import RouterServiceInterface

enum DependencyFactory {
    static func make(with routerService: RouterService) {
        routerService.register(dependencyFactory: {
            URLSessionHTTPClient(urlSession: URLSession.shared)
        }, forType: HTTPClientProtocol.self)

        routerService.register(dependencyFactory: {
            routerService
        }, forType: RouterServiceProtocol.self)
    }
}
