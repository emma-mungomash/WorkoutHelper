import SwiftUI

struct LoginView: View {
    
    @State var username: String = ""
    @State var password: String = ""
    
    init() {
        UIScrollView.appearance().bounces = false
    }
    
    var body: some View {
        ScrollView {
            VStack {
                TextField("username", text: $username)
                    .padding(20)
                    .disableAutocorrection(true)
                    .border(.black)
                SecureField("password", text: $password)
                    .padding(20)
                    .disableAutocorrection(true)
                    .border(.black)
                Button(action: {}) {
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
}
