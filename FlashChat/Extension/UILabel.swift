import UIKit

extension UILabel {
    convenience init(text: String = "", font: UIFont? = nil, textColor: UIColor, numberOfLines: Int) {
        self.init()
        self.text = text
        self.font = font
        self.textColor = textColor
        self.numberOfLines = numberOfLines
    }
}

