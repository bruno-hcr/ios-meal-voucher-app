import Foundation

public protocol NetworkRequest {
    var baseUrl: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
}

public enum HTTPMethod: String {
    case get
}

extension NetworkRequest {
    public var baseUrl: String {
        "https://gist.githubusercontent.com/Aurazion/365d587f5917d1478bf03bacabdc69f3/raw/3c92b70e1dc808c8be822698f1cbff6c95ba3ad3/"
    }

    public func urlRequest() throws -> URLRequest {
        guard let components = URLComponents(string: baseUrl + path) else {
            throw NetworkRequestError.invalidURL
        }

        guard let url = components.url else {
            throw NetworkRequestError.invalidURL
        }

        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue

        return request
    }
}

enum NetworkRequestError: Error {
    case invalidURL
}
