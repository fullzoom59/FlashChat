import UIKit
import Firebase

class ChatTableViewCell: UITableViewCell {
    static let identifier = "ChatTableViewCell"
    
    private lazy var chatCellStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [leftImage, messageView, rightImage])
        sv.axis = .horizontal
        sv.spacing = 20
        sv.alignment = .bottom
        sv.distribution = .fill
        return sv
    }()
    
    lazy var messageView: UIView = {
        let view = UIView()
        view.backgroundColor = .brandPurple
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var messageLabel = UILabel(textColor: .white, numberOfLines: 0)
    
    
    lazy var rightImage = SenderImage(image: UIImage(named: "MeAvatar"))
    lazy var leftImage = SenderImage(image: UIImage(named: "YouAvatar"))
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    public func configureCell(with model: MessageModel) {
        messageLabel.text = model.message
        
        if model.sender == Auth.auth().currentUser?.email {
            leftImage.isHidden = true
            rightImage.isHidden = false
            messageView.backgroundColor = .brandLightPurple
            messageLabel.textColor = .brandPurple
        } else {
            rightImage.isHidden = true
            leftImage.isHidden = false
            messageView.backgroundColor = .brandPurple
            messageLabel.textColor = .brandLightPurple
        }
    }

    
    private func setupUI() {
        addSubviews(chatCellStackView)
        messageView.addSubviews(messageLabel)
        NSLayoutConstraint.activate([
            chatCellStackView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            chatCellStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            chatCellStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            chatCellStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
        
        NSLayoutConstraint.activate([
            messageLabel.topAnchor.constraint(equalTo: messageView.topAnchor, constant: 10),
            messageLabel.leadingAnchor.constraint(equalTo: messageView.leadingAnchor, constant: 5),
            messageLabel.trailingAnchor.constraint(equalTo: messageView.trailingAnchor, constant: -5),
            messageLabel.bottomAnchor.constraint(equalTo: messageView.bottomAnchor, constant: -10),
        ])
        
        NSLayoutConstraint.activate([
            leftImage.heightAnchor.constraint(equalToConstant: 40),
            leftImage.widthAnchor.constraint(equalToConstant: 40)
        ])
        
        NSLayoutConstraint.activate([
            rightImage.heightAnchor.constraint(equalToConstant: 40),
            rightImage.widthAnchor.constraint(equalToConstant: 40),
        ])
    }
}
