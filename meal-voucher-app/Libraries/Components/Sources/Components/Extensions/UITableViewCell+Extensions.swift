import UIKit

extension UITableViewCell {
    public static var reuseIdentifier: String {
        return NSStringFromClass(self)
    }
}
