import Foundation

public protocol NetworkManager {
    func request(_ request: NetworkRequest, completion: @escaping () -> Void)
}
