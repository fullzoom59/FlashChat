import Firebase

class ChatModel {
    var messages: [MessageModel] = []
    let db = Firestore.firestore()

    public func loadMessagesFromFirestore(completion: @escaping () -> Void) {
        db.collection("messages")
            .order(by: "date")
            .addSnapshotListener { querySnapshot, error in
                if let error = error {
                    print("Error getting documents: \(error)")
                } else {
                    self.messages.removeAll()
                    guard let snapshotDocuments = querySnapshot?.documents else { return }
                    for doc in snapshotDocuments {
                        let data = doc.data()
                        guard let sender = data["sender"] as? String,
                              let message = data["message"] as? String
                        else { return }
                        let newMessage = MessageModel(sender: sender, message: message)
                        self.messages.append(newMessage)
                    }
                    DispatchQueue.main.async {
                        completion()
                    }
                }
            }
    }
    
    public func sendMessage(sender: String, message: String, errorCompletion: @escaping (String) -> Void) {
        db.collection("messages").addDocument(data: [
            "sender": sender,
            "message": message,
            "date": Date().timeIntervalSince1970
        ]) { error in
            if let error = error {
                errorCompletion(error.localizedDescription)
            }
        }
    }
    
    public func logOut() {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            let vc = WelcomeViewController()
        } catch let signOutError as NSError {
            print("Error signing out", signOutError)
        }
    }
}
