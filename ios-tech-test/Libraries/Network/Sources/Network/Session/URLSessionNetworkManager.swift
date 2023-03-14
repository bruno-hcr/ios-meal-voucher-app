import Foundation

public final class URLSessionNetworkManager: NetworkManager {
    private let urlSession: URLSessionProtocol
    
    public init(urlSession: URLSessionProtocol) {
        self.urlSession = urlSession
    }
    
    public func request(_ request: NetworkRequest, completion: @escaping () -> Void) {
        do {
            let urlRequest = try request.urlRequest()
            
            urlSession.wrappedDataTask(with: urlRequest) { data, response, error in
                guard error != nil else {
                    completion()
                    return
                }
                
                completion()
            }
        } catch {
            completion()
        }
    }
}
