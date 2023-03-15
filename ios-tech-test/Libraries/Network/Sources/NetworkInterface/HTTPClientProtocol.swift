import Foundation

public protocol HTTPClientProtocol {
    func request(_ request: NetworkRequest, completion: @escaping () -> Void)
}
