import Foundation
import MealVoucherDetailInterface
import XCTest

@testable import MealVoucherDetail

final class MealVoucherDetailViewControllerTests: XCTestCase {
    private let customViewSpy = MealVoucherDetailViewProtocolSpy()
    private let serviceStub = TransactionDetailServiceProtocolStub()
    
    private lazy var sut = MealVoucherDetailViewController(
        customView: customViewSpy,
        service: serviceStub
    )
    
    func test_getTransactionDetail_givenServiceReturnSuccess_shouldCallViewDisplay() {
        serviceStub.getTransactionDetailCompletionToBeReturned = .success(.fixture())
        
        sut.viewDidLoad()
        
        XCTAssertTrue(serviceStub.getTransactionDetailCalled)
        XCTAssertTrue(customViewSpy.displayCalled)
        XCTAssertNotNil(customViewSpy.displayViewModelPassed)
    }
}


final class MealVoucherDetailViewProtocolSpy: UIView, MealVoucherDetailViewProtocol {
    
    private(set) var displayCalled = false
    private(set) var displayViewModelPassed: MealVoucherDetailView.ViewModel?
    
    func display(viewModel: MealVoucherDetail.MealVoucherDetailView.ViewModel) {
        displayCalled = true
        displayViewModelPassed = viewModel
    }
}

final class TransactionDetailServiceProtocolStub: TransactionDetailServiceProtocol {
    
    private(set) var getTransactionDetailCalled = false
    var getTransactionDetailCompletionToBeReturned: Result<TransactionDetail, Never>?
    
    func getTransactionDetail(completion: @escaping (Result<TransactionDetail, Never>) -> Void) {
        getTransactionDetailCalled = true
        if let getTransactionDetailCompletionToBeReturned {
            completion(getTransactionDetailCompletionToBeReturned)
        }
    }
}
