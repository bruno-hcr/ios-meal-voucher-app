import Components
import UIKit

protocol MealVoucherListViewProtocol {
    func display(viewModel: MealVoucherListView.ViewModel)
}

final class MealVoucherListView: UIView, MealVoucherListViewProtocol {
    
    struct ViewModel {
        private let mealVouchers: [String]
        
        func numberOfSections() -> Int { 1 }
        func numberOfRowsInSection(_ section: Int) -> Int { 1 }
    }
    
    private var viewModel: ViewModel?
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func display(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
}

extension MealVoucherListView: ViewCode {
    func setupSubViews() {
        addSubview(tableView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
}

extension MealVoucherListView: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel?.numberOfSections() ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.numberOfRowsInSection(section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
