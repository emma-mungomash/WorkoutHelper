import SwiftUI
import Firebase

@main
struct WorkoutHelperApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    @StateObject var viewModel = WorkoutViewModel()
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                if viewModel.signIn {
                    TabView {
                        HomeGrid()
                            .tabItem {
                                Label("Menu", systemImage: "list.dash")
                            }
                        AllExercises()
                            .tabItem {
                                Label("Edit Exercies", systemImage: "square.and.pencil")
                            }
                    }.environmentObject(viewModel)
                } else {
                    LoginView()
                        .environmentObject(viewModel)
                }
            }
        }
    }
    
    
}
