import UIKit

public enum MealVoucherDetailFactory {
    static func make() -> UIViewController {
        let view = MealVoucherDetailView()
        let viewController = MealVoucherDetailViewController(
            customView: view
        )
        return viewController
    }
}
