import Foundation
import NetworkInterface

public final class URLSessionHTTPClientDispatch: HTTPClientProtocol {
    private let decorate: HTTPClientProtocol

    public init(decorate: HTTPClientProtocol = URLSessionHTTPClient()) {
        self.decorate = decorate
    }

    public func request<T: Codable>(_ request: NetworkRequest, completion: @escaping (Result<T, Error>) -> Void) {
        decorate.request(request) { (result: Result<T, Error>) in
            DispatchQueue.main.async {
                completion(result)
            }
        }
    }
}
