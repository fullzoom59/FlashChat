import Firebase

class RegisterModel {
    
    func createUser(withEmail: String, password: String, successCompletion: @escaping () -> Void, failureCompletion: @escaping (String) -> Void ){
        Auth.auth().createUser(withEmail: withEmail, password: password) { authResult, error in
            if let error = error{
                failureCompletion(error.localizedDescription)
            } else {
                successCompletion()
            }
        }
    }
}
