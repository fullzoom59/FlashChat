import UIKit

class EmailTextField: UITextField {
    init(placeholder: String? = "") {
        super.init(frame: .zero)
        self.backgroundColor = .white
        self.textAlignment = .center
        self.placeholder = placeholder
        self.layer.cornerRadius = 25
        self.font = .systemFont(ofSize: 25)
        self.textColor = .brandBlue
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class PasswordTextField: EmailTextField {
    override init(placeholder: String? = "") {
        super.init(placeholder: placeholder)
        self.isSecureTextEntry = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
