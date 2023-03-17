import Foundation
import ImageFetcherInterface
import Network
import NetworkInterface
import RouterService
import RouterServiceInterface

enum DependencyFactory {
    static func make(with routerService: RouterService) {
        routerService.register(dependencyFactory: {
            routerService
        }, forType: RouterServiceProtocol.self)
        
        routerService.register(dependencyFactory: {
            URLSessionHTTPClientDispatch()
        }, forType: HTTPClientProtocol.self)
        
        routerService.register(dependencyFactory: {
            KingfisherImageFetcher()
        }, forType: ImageFetcherProtocol.self)
    }
}
