import Foundation
import MealVoucherDetailInterface
import XCTest

@testable import MealVoucherDetail

final class MealVoucherDetailRouteHandlerTests: XCTestCase {
    private let sut = MealVoucherDetailRouteHandler()
    
    func test_routes_shouldHasValidRoutes() {
        XCTAssertTrue(sut.routes.contains(where: { $0 is MealVoucherDetailRoute.Type }))
    }
    
    func test_destination_givenRoute_shouldReturnFeature() {
        let featureType = sut.destination(forRoute: MealVoucherDetailRoute(transactionDetail: .fixture()))
        
        XCTAssertTrue(featureType is MealVoucherDetailFeature.Type)
    }
}
