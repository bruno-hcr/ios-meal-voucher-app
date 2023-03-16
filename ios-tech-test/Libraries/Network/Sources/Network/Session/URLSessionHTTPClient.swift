import Foundation
import NetworkInterface

public final class URLSessionHTTPClient: HTTPClientProtocol {
    private let session: URLSessionProtocol

    public init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }

    public func request<T: Codable>(_ request: NetworkRequest, completion: @escaping (Result<T, Error>) -> Void) {
        do {
            let urlRequest = try request.urlRequest()

            session.wrappedDataTask(with: urlRequest) { data, response, error in
                if let _ = error {
                    completion(.failure(NetworkRequestFailed()))
                    return
                }

                guard let httpURLResponse = response as? HTTPURLResponse, 200...299 ~= httpURLResponse.statusCode else {
                    completion(.failure(NetworkRequestFailed()))
                    return
                }

                guard let data = data else {
                    completion(.failure(NetworkInvalidData()))
                    return
                }

                do {
                    let decode = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(decode))
                } catch {
                    completion(.failure(error))
                }
            }
        } catch {
            completion(.failure(error))
        }
    }
}

public struct NetworkRequestFailed: Error {}
public struct NetworkInvalidData: Error {}
