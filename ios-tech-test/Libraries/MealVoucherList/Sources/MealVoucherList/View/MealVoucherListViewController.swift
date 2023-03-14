import UIKit

final class MealVoucherListViewController: UIViewController {
    private let customView: MealVoucherListViewProtocol & UIView
    
    init(customView: MealVoucherListViewProtocol & UIView) {
        self.customView = customView
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = customView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
