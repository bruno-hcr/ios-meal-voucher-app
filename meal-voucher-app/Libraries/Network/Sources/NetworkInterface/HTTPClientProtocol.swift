import Foundation

public protocol HTTPClientProtocol {
    func request<T: Codable>(_ request: NetworkRequest, completion: @escaping (Result<T, Error>) -> Void)
}
