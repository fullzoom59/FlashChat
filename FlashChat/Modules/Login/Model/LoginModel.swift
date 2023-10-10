import Firebase

class LoginModel {
    
    func signIn(withEmail: String, password: String, successCompletion: @escaping () -> Void, failureCompletion: @escaping (String) -> Void) {
        Auth.auth().signIn(withEmail: withEmail, password: password) { [weak self] authResult, error in
            if let error = error {
                failureCompletion(error.localizedDescription)
            } else {
                successCompletion()
            }
        }
    }
}
