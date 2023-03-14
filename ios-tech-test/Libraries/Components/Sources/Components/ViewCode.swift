import Foundation

public protocol ViewCode {
    func setup()
    func setupSubViews()
    func setupConstraints()
    func setupExtraConfiguration()
}

extension ViewCode {
    public func setup() {
        setupSubViews()
        setupConstraints()
        setupExtraConfiguration()
    }

    public func setupExtraConfiguration() {}
}
