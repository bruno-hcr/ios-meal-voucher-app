import UIKit

public enum Image {
    public static let arrow = UIImageInModule(named: "arrow")
    public static let bike = UIImageInModule(named: "bike")
    public static let burger = UIImageInModule(named: "burger")
    public static let croissant = UIImageInModule(named: "croissant")
    public static let drink = UIImageInModule(named: "drink")
    public static let forkKnife = UIImageInModule(named: "fork_knife")
    public static let gift = UIImageInModule(named: "gift")
    public static let subway = UIImageInModule(named: "subway")
    public static let sushi = UIImageInModule(named: "sushi")
    public static let tech = UIImageInModule(named: "tech")

    private static func UIImageInModule(named: String) -> UIImage? {
        UIImage(named: named, in: .module, compatibleWith: nil)
    }
}
