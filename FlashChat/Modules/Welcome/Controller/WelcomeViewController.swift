import UIKit

class WelcomeViewController: UIViewController {
    private lazy var flashChatLabel = UILabel(text: "", font: .systemFont(ofSize: 50, weight: .black), textColor: .brandBlue, numberOfLines: 1)
    private lazy var registerButton: UIButton = {
        let button = UIButton(text: "Register", textColor: .brandBlue, backgroundColor: .brandLightBlue)
        button.addTarget(self, action: #selector(registerButtonPressed(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var logInButton: UIButton = {
        let button = UIButton(text: "Log In", textColor: .white, backgroundColor: .systemTeal)
        button.addTarget(self, action: #selector(logInButtonPressed(_:)), for: .touchUpInside)
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        animationTextFlashChat()
    }
    
    @IBAction private func registerButtonPressed(_ sender: UIButton) {
        let vc = RegisterViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction private func logInButtonPressed(_ sender: UIButton) {
        let vc = LoginViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func animationTextFlashChat() {
        let text = "⚡️Flash Chat"
        var charIndex = 0.0
        for char in text {
            Timer.scheduledTimer(withTimeInterval: 0.1 * charIndex, repeats: false) { [self] _ in
                flashChatLabel.text?.append(char)
            }
            charIndex += 1
        }
    }
    
    private func setupUI() {
        view.addSubviews(flashChatLabel, registerButton, logInButton)
        
        
        NSLayoutConstraint.activate([
            flashChatLabel.heightAnchor.constraint(equalToConstant: 60),
            flashChatLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            flashChatLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            logInButton.heightAnchor.constraint(equalToConstant: 50),
            logInButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            logInButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            logInButton.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            registerButton.heightAnchor.constraint(equalToConstant: 50),
            registerButton.bottomAnchor.constraint(equalTo: logInButton.topAnchor, constant: -10),
            registerButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            registerButton.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
}
