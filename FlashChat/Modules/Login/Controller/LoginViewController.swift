import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    private var loginModel = LoginModel()
    private lazy var emailTextField = EmailTextField(placeholder: "Email")
    private lazy var passwordTextField = PasswordTextField(placeholder: "Passoword")
    
    private lazy var logInButton: UIButton = {
        let button = UIButton(text: "Log In", textColor: .white)
        button.addTarget(self, action: #selector(logInButtonPressed(_:)), for: .touchUpInside)
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightBlue
        setupUI()
    }
    
    
    @IBAction private func logInButtonPressed(_ sender: UIButton) {
        signIn()
    }
    
    private func signIn() {
        guard let email = emailTextField.text,
              let password = passwordTextField.text else {
            return
        }
        loginModel.signIn(withEmail: email, password: password) {
            let vc = ChatViewController()
            self.navigationController?.setViewControllers([vc], animated: false)
        } failureCompletion: { [weak self] error in
            self?.signInError(title: error)
        }
        
    }
    
    private func signInError(title: String) {
        let alert = UIAlertController(title: "Error", message: title, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Okay", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
    
    private func setupUI() {
        navigationController?.navigationBar.tintColor = .white
        view.addSubviews(emailTextField, passwordTextField, logInButton)
        
        NSLayoutConstraint.activate([
            emailTextField.heightAnchor.constraint(equalToConstant: 50),
            emailTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50)
        ])
        
        NSLayoutConstraint.activate([
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50)
        ])
        
        NSLayoutConstraint.activate([
            logInButton.heightAnchor.constraint(equalToConstant: 50),
            logInButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),
            logInButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            logInButton.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}
