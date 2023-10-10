import Firebase
import UIKit

class ChatViewController: UIViewController {
    private var chatModel = ChatModel()
    private lazy var chatTableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.register(ChatTableViewCell.self, forCellReuseIdentifier: ChatTableViewCell.identifier)
        tableView.dataSource = self
        return tableView
    }()

    private lazy var chatView: UIView = {
        let view = UIView()
        view.backgroundColor = .brandPurple
        return view
    }()
    
    private lazy var sendMessageTextField: UITextField = {
        let tf = UITextField()
        tf.backgroundColor = .white
        tf.layer.cornerRadius = 10
        tf.font = .systemFont(ofSize: 14)
        tf.textColor = .brandPurple
        tf.placeholder = "Write a message..."
        return tf
    }()
    
    private lazy var sendButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .white
        button.setImage(UIImage(systemName: "paperplane.fill"), for: .normal)
        button.addTarget(self, action: #selector(sendButtonPressed(_:)), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .brandPurple
        loadMessagesFromFirestore()
        setupUI()
        setupNavigationBar()
    }
    
    private func loadMessagesFromFirestore() {
        chatModel.loadMessagesFromFirestore {
            self.chatTableView.reloadData()
            if !self.chatModel.messages.isEmpty {
                let indexPath = IndexPath(row: self.chatModel.messages.count - 1, section: 0)
                self.chatTableView.scrollToRow(at: indexPath, at: .top, animated: false)
            }
        }
    }

    @IBAction private func sendButtonPressed(_ sender: UIButton) {
        guard let sender = Auth.auth().currentUser?.email,
              let message = sendMessageTextField.text else { return }
        chatModel.sendMessage(sender: sender, message: message) { [weak self] error in
            self?.savingMessageToFirestoreError(title: error)
        }
        sendMessageTextField.text = ""
    }
    
    private func savingMessageToFirestoreError(title: String) {
        let alert = UIAlertController(title: "Error", message: "There was an issue saving data to FireStore: \(title)", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "ОК", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
    private func setupNavigationBar() {
        let customFont = UIFont.systemFont(ofSize: 25, weight: .black)
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.font: customFont
        ]
        navigationItem.title = "⚡️Flash Chat"
        let logOutButton = UIBarButtonItem(title: "Log Out", style: .plain, target: self, action: #selector(logOutButtonPressed(_:)))
        navigationItem.rightBarButtonItem = logOutButton
    }
    
    @IBAction private func logOutButtonPressed(_ sender: UIBarButtonItem) {
        chatModel.logOut()
        let vc = WelcomeViewController()
        navigationController?.setViewControllers([vc], animated: false)
    }
    
    private func setupUI() {
        view.addSubviews(chatView, chatTableView)
        chatView.addSubviews(sendButton, sendMessageTextField)
        
        NSLayoutConstraint.activate([
            chatView.heightAnchor.constraint(equalToConstant: 60),
            chatView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            chatView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            chatView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            sendButton.heightAnchor.constraint(equalToConstant: 40),
            sendButton.widthAnchor.constraint(equalToConstant: 40),
            sendButton.topAnchor.constraint(equalTo: chatView.topAnchor, constant: 20),
            sendButton.trailingAnchor.constraint(equalTo: chatView.trailingAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            sendMessageTextField.heightAnchor.constraint(equalToConstant: 40),
            sendMessageTextField.topAnchor.constraint(equalTo: chatView.topAnchor, constant: 20),
            sendMessageTextField.leadingAnchor.constraint(equalTo: chatView.leadingAnchor, constant: 20),
            sendMessageTextField.trailingAnchor.constraint(equalTo: sendButton.leadingAnchor, constant: -20),
            sendMessageTextField.bottomAnchor.constraint(equalTo: view.keyboardLayoutGuide.topAnchor)
        ])
        
        NSLayoutConstraint.activate([
            chatTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            chatTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            chatTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            chatTableView.bottomAnchor.constraint(equalTo: chatView.topAnchor)
        ])
    }
}

extension ChatViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatModel.messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ChatTableViewCell.identifier, for: indexPath) as? ChatTableViewCell else {
            return UITableViewCell()
        }
        let message = chatModel.messages[indexPath.row]
        cell.configureCell(with: message)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
