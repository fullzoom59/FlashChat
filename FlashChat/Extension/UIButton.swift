import UIKit

extension UIButton {
    convenience init(text: String? = "", textColor: UIColor? = .clear, backgroundColor: UIColor? = .clear, font: UIFont? = .systemFont(ofSize: 30)) {
        self.init(type: .system)
        self.titleLabel?.font = font
        self.setTitleColor(textColor, for: .normal)
        self.setTitle(text, for: .normal)
        self.backgroundColor = backgroundColor
    }
}
