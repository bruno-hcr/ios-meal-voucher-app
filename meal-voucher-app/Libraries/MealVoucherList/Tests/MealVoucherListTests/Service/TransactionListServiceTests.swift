import Foundation
import MealVoucherListInterface
import NetworkInterface
import XCTest

@testable import MealVoucherList

final class TransactionListServiceTests: XCTestCase {
    private let networkStub = HTTPClientProtocolStub()
    private lazy var sut = TransactionListService(network: networkStub)

    func test_getTransactionList_givenNetworkReturnSuccess_shouldReturnSuccess() {
        let expectedResult: Result<TransactionResponse, Error> = Result.success(
            .init(
                transactions: []
            )
        )

        networkStub.requestCompletionToBeReturned = expectedResult

        var result: Result<[Transaction], Error>?
        sut.getTransactionList {
            result = $0
        }

        XCTAssertTrue(networkStub.requestCalled)
        XCTAssertNotNil(networkStub.requestPassed as? TransactionsRequest)

        guard case .success = result else {
            XCTFail("Result should be success")
            return
        }
    }

    func test_getTransactionList_givenNetworkReturnFailure_shouldReturnFailure() {
        let expectedResult: Result<TransactionResponse, Error> = Result.failure(ErrorDummy())

        networkStub.requestCompletionToBeReturned = expectedResult

        var result: Result<[Transaction], Error>?
        sut.getTransactionList {
            result = $0
        }

        XCTAssertTrue(networkStub.requestCalled)
        XCTAssertNotNil(networkStub.requestPassed as? TransactionsRequest)

        guard case .failure(let error) = result else {
            XCTFail("Result should be success")
            return
        }

        XCTAssertNotNil(error as? ErrorDummy)
    }
}

final class HTTPClientProtocolStub: HTTPClientProtocol {

    private(set) var requestCalled = false
    private(set) var requestPassed: NetworkRequest?
    var requestCompletionToBeReturned: Any?

    func request<T: Codable>(_ request: NetworkRequest, completion: @escaping (Result<T, Error>) -> Void) {
        requestCalled = true
        requestPassed = request

        if let requestCompletionToBeReturned = requestCompletionToBeReturned,
            let expectedRequest = requestCompletionToBeReturned as? Result<T, Error> {
            completion(expectedRequest)
        }
    }
}
