import SwiftUI
import Firebase

struct LoginView: View {
    
    @EnvironmentObject var viewModel: WorkoutViewModel
    
    @State var email: String = ""
    @State var password: String = ""
    
    init() {
        UIScrollView.appearance().bounces = false
    }
    
    var body: some View {
        ScrollView {
            VStack {
                TextField("email", text: $email)
                    .font(.title)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal, 16)
                SecureField("password", text: $password)
                    .font(.title)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal, 16)
                Button(action: onTap) {
                    Text("Enter")
                        .foregroundColor(Color.white)
                        .padding(.vertical, 20)
                        .frame(width: UIScreen.main.bounds.width - 60)
                        .background(Color.green)
                        .cornerRadius(20)
                }
            }.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        }.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
    }
    
    func onTap() {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                print("Error getting documents: \(error)")
            } else {
                viewModel.signIn = true
            }
        }
    }
}
