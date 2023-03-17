import Foundation
import XCTest

@testable import Network

final class URLSessionHTTPClientTests: XCTestCase {
    private let dataTaskStub = URLSessionProtocolProtocolStub()

    private lazy var sut = URLSessionHTTPClient(session: dataTaskStub)

    private typealias DataTaskResult = Result<DataTaskMocks.ValidResponse, Error>

    func test_request_givenCompletionWithError_shouldReturnCustomError() {
        dataTaskStub.dataTaskCompletionToBeReturned = (nil, nil, ErrorDummy())

        var expectedResult: DataTaskResult?
        sut.request(DataTaskMocks.NetworkRequestDummy()) { expectedResult = $0 }

        XCTAssertEqual(dataTaskStub.dataTaskCalledCount, 1)
        XCTAssertNotNil(dataTaskStub.dataTaskUrlRequestPassed)
        switch expectedResult {
        case .failure(let error):
            XCTAssertNotNil(error as? NetworkRequestFailed)
        default:
            XCTFail("expected result should be failure")
        }
    }

    func test_request_givenAValidData_andNilError_shouldReturnSerializedObjectWithSuccess() {
        dataTaskStub.dataTaskCompletionToBeReturned = (DataTaskMocks.validData, DataTaskMocks.HTTPURLResponse200, nil)

        var expectedResult: DataTaskResult?
        sut.request(DataTaskMocks.NetworkRequestDummy()) { expectedResult = $0 }

        XCTAssertEqual(dataTaskStub.dataTaskCalledCount, 1)
        XCTAssertNotNil(dataTaskStub.dataTaskUrlRequestPassed)

        switch expectedResult {
        case .success(let weather):
            XCTAssertEqual(weather.main, "Clouds")
        default:
            XCTFail("expected result should be failure")
        }
    }

    func test_request_givenNilData_andNilError_shouldReturnCustomError() {
        dataTaskStub.dataTaskCompletionToBeReturned = (nil, DataTaskMocks.HTTPURLResponse200, nil)

        var expectedResult: DataTaskResult?
        sut.request(DataTaskMocks.NetworkRequestDummy()) { expectedResult = $0 }

        XCTAssertEqual(dataTaskStub.dataTaskCalledCount, 1)
        XCTAssertNotNil(dataTaskStub.dataTaskUrlRequestPassed)

        switch expectedResult {
        case .failure(let error):
            XCTAssertNotNil(error as? NetworkInvalidData)
        default:
            XCTFail("expected result should be failure")
        }
    }

    func test_request_givenValidData_andInvalidResponse_andNilError_shouldReturnDecodeError() {
        dataTaskStub.dataTaskCompletionToBeReturned = (DataTaskMocks.validData, DataTaskMocks.HTTPURLResponse200, nil)

        var expectedResult: Result<[DataTaskMocks.InvalidResponse], Error>?
        sut.request(DataTaskMocks.NetworkRequestDummy()) { expectedResult = $0 }

        XCTAssertEqual(dataTaskStub.dataTaskCalledCount, 1)
        XCTAssertNotNil(dataTaskStub.dataTaskUrlRequestPassed)

        switch expectedResult {
        case .failure(let error):
            XCTAssertNotNil(error as? DecodingError)
        default:
            XCTFail("expected result should be failure")
        }
    }

    func test_request_givenNilError_andResponseDifferentFrom200To299_shouldReturnCustomError() {
        dataTaskStub.dataTaskCompletionToBeReturned = (nil, DataTaskMocks.HTTPURLResponse300, nil)

        var expectedResult: Result<[DataTaskMocks.InvalidResponse], Error>?
        sut.request(DataTaskMocks.NetworkRequestDummy()) { expectedResult = $0 }

        XCTAssertEqual(dataTaskStub.dataTaskCalledCount, 1)
        XCTAssertNotNil(dataTaskStub.dataTaskUrlRequestPassed)

        switch expectedResult {
        case .failure(let error):
            XCTAssertNotNil(error as? NetworkRequestFailed)
        default:
            XCTFail("expected result should be failure")
        }
    }
}
