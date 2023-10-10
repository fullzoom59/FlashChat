import UIKit
import FirebaseAuth

class RegisterViewController: UIViewController {
    private var registerModel = RegisterModel()
    private lazy var emailTextField = EmailTextField(placeholder: "Email")
    private lazy var passwordTextField = PasswordTextField(placeholder: "Password")
    
    private lazy var registerButton: UIButton = {
        let button = UIButton(text: "Register", textColor: .brandBlue, backgroundColor: .clear)
        button.addTarget(self, action: #selector(registerButtonPressed(_:)), for: .touchUpInside)
        return button
    }()
    
    @IBAction private func registerButtonPressed(_ sender: UIButton) {
        createUser()
    }
    
    private func createUser() {
        guard let email = emailTextField.text,
              let password = passwordTextField.text
        else{
            loginOrPasswordEmptyAlert()
            return
        }
        registerModel.createUser(withEmail: email, password: password) {
            let vc = ChatViewController()
            self.navigationController?.setViewControllers([vc], animated: false)
        } failureCompletion: { [weak self] error in
            self?.authorizationError(title: error)
        }
    }
    
    
    private func loginOrPasswordEmptyAlert() {
        let alert = UIAlertController(title: "Error", message: "The login or password fields are not filled in", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Okay", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
    private func authorizationError(title: String) {
        let alert = UIAlertController(title: "Error", message: title, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Okay", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .brandLightBlue
        setupUI()
    }
    
    
    private func setupUI() {
        navigationController?.navigationBar.tintColor = .white
        view.addSubviews(emailTextField, passwordTextField, registerButton)
        
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
            registerButton.heightAnchor.constraint(equalToConstant: 60),
            registerButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),
            registerButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            registerButton.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}
