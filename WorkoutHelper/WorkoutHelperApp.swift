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
                            .onAppear(perform: run)
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
                }
            }
        }
    }
    
    func run() {
        let db: Firestore = Firestore.firestore()
        db.collection("workouts").getDocuments() { (querySnapshot, err) in
            if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        print("\(document.documentID) => \(document.data())")
                    }
                }
        }
    }
}
