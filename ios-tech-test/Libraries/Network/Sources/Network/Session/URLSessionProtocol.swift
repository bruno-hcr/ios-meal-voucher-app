import Foundation

public protocol URLSessionProtocol {
    func wrappedDataTask(with request: URLRequest, completionHandler: @escaping @Sendable (Data?, URLResponse?, Error?) -> Void)
}

extension URLSession: URLSessionProtocol {
    public func wrappedDataTask(with request: URLRequest, completionHandler: @escaping @Sendable (Data?, URLResponse?, Error?) -> Void) {
        dataTask(with: request, completionHandler: completionHandler).resume()
    }
}
