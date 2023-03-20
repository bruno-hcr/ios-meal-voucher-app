import CommonAssets
import MealVoucherDetailInterface
import MealVoucherListInterface
import RouterServiceInterface
import UIKit
import XCTest

@testable import MealVoucherList

final class MealVoucherListViewControllerTests: XCTestCase {
    private let customViewSpy = MealVoucherListViewProtocolSpy()
    private let serviceStub = TransactionListServiceProtocolStub()
    private let routerServiceSpy = RouterServiceProtocolSpy()
    
    private lazy var sut = MealVoucherListViewController(
        customView: customViewSpy,
        service: serviceStub,
        routerService: routerServiceSpy
    )
    
    func test_viewDidLoad_givenServiceReturnSuccess_shouldCallViewDisplay_withViewModel() {
        serviceStub.getTransactionListCompletionToBeReturned = .success([
            .fixture()
        ])
        
        sut.viewDidLoad()
        
        XCTAssertTrue(serviceStub.getTransactionListCalled)
        XCTAssertTrue(customViewSpy.displayCalled)
        XCTAssertNotNil(customViewSpy.displayViewModelPassed)
    }
    
    func test_viewDidLoad_givenServiceReturnFailure_shouldNotCallViewDisplay() {
        serviceStub.getTransactionListCompletionToBeReturned = .failure(ErrorDummy())
        
        sut.viewDidLoad()
        
        XCTAssertTrue(serviceStub.getTransactionListCalled)
        XCTAssertFalse(customViewSpy.displayCalled)
    }
    
    func test_didSelectRowAt_givenTransactionList_shouldCallRouteToMealVoucherDetail() {
        serviceStub.getTransactionListCompletionToBeReturned = .success([
            .fixture()
        ])
        
        sut.viewDidLoad()
        
        sut.didSelectRowAt(indexPath: IndexPath(row: 0, section: 0))
        
        XCTAssertTrue(routerServiceSpy.navigateCalled)
        XCTAssertNotNil(routerServiceSpy.navigateRoutePassed as? MealVoucherDetailRoute)
        XCTAssertNotNil(routerServiceSpy.navigateViewControllerPassed as? MealVoucherListViewController)
        XCTAssertNotNil(routerServiceSpy.navigatePresentationStylePassed as? Push)
        XCTAssertTrue(routerServiceSpy.navigateAnimatedPassed == false)
        XCTAssertNil(routerServiceSpy.navigateCompletionPassed)
    }
}

struct ErrorDummy: Error {}

extension Transaction {
    static func fixture(
        name: String = "",
        message: String? = nil,
        date: Date = Date(),
        amount: Amount = .fixture(),
        smallIcon: Icon = .category(.none),
        largeIcon: Icon = .category(.none)
    ) -> Self {
        .init(
            name: name,
            message: message,
            date: date,
            amount: amount,
            smallIcon: smallIcon,
            largeIcon: largeIcon
        )
    }
}

extension Transaction.Amount {
    static func fixture(
        value: Double = 0.0,
        symbol: String = ""
    ) -> Self {
        .init(
            value: value,
            symbol: symbol
        )
    }
}

final class MealVoucherListViewProtocolSpy: UIView, MealVoucherListViewProtocol {
    
    private(set) var displayCalled = false
    private(set) var displayViewModelPassed: [MealVoucherListView.ViewModel]?
    
    func display(viewModel: [MealVoucherListView.ViewModel]) {
        displayCalled = true
        displayViewModelPassed = viewModel
    }
}

final class TransactionListServiceProtocolStub: TransactionListServiceProtocol {
    
    private(set) var getTransactionListCalled = false
    var getTransactionListCompletionToBeReturned: Result<[Transaction], Error>?

    func getTransactionList(completion: @escaping (Result<[Transaction], Error>) -> Void) {
        getTransactionListCalled = true
        if let getTransactionListCompletionToBeReturned {
            completion(getTransactionListCompletionToBeReturned)
        }
    }
}

final class RouterServiceProtocolSpy: RouterServiceProtocol {
    
    private(set) var navigateCalled = false
    private(set) var navigateRoutePassed: Route?
    private(set) var navigateViewControllerPassed: UIViewController?
    private(set) var navigatePresentationStylePassed: PresentationStyle?
    private(set) var navigateAnimatedPassed: Bool?
    private(set) var navigateCompletionPassed: (() -> Void)?
    
    func navigate(
        toRoute route: Route,
        fromView viewController: UIViewController,
        presentationStyle: PresentationStyle,
        animated: Bool,
        completion: (() -> Void)?
    ) {
        navigateCalled = true
        navigateRoutePassed = route
        navigateViewControllerPassed = viewController
        navigatePresentationStylePassed = presentationStyle
        navigateAnimatedPassed = animated
        navigateCompletionPassed = completion
    }
}

