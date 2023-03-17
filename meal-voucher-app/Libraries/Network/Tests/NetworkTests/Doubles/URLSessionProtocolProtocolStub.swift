import Foundation

@testable import Network

final class URLSessionProtocolProtocolStub: URLSessionProtocol {
    private(set) var dataTaskCalledCount = 0
    private(set) var dataTaskUrlRequestPassed: URLRequest?
    var dataTaskCompletionToBeReturned: (data: Data?, response: URLResponse?, error: Error?)?

    func wrappedDataTask(with urlRequest: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        dataTaskCalledCount += 1
        dataTaskUrlRequestPassed = urlRequest

        completionHandler(
            dataTaskCompletionToBeReturned?.data,
            dataTaskCompletionToBeReturned?.response,
            dataTaskCompletionToBeReturned?.error
        )
    }
}
