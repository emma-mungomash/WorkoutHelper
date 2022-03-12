import SwiftUI
import Firebase
import Combine
import FirebaseFirestore

struct Workout: Identifiable {
    let name: String
    let exercises: [Exercise]
    let id = UUID()
}

struct Exercise: Hashable, Identifiable {
    let name: String
    let key: String
    let time: TimeInterval?
    let preparation: TimeInterval?
    let id = UUID()
}

enum SelectedExercise: String, CaseIterable, Identifiable {
    case FeetTogether, FeetApart, StandardPlank, ExtendedArmPlank, SidePlankLeft, SidePlankRight, ArmSwings, LegSwings, AirPunches, ASkips, BSkips, CSkips, BSkipsPullThrough, ASkipsPullThrough
    var id: Self { self }
}

enum SelectedTime: String, CaseIterable, Identifiable {
    case one, two, three
    var id: Self { self }
}

enum SelectedPreparation: String, CaseIterable, Identifiable {
    case one, two, three
    var id: Self { self }
}

struct User: Identifiable {
    var id = UUID()
    var uid: String
    var email: String
}

class WorkoutViewModel : ObservableObject {
    
    @Published var workouts: [Workout] = []
    @Published var exercises: [Exercise] = []
    @Published var workoutExercises: [Exercise] = []
    @Published var signIn: Bool = false
    @Published var currentUser: User?
    @Published var newExerciseList: [String] = []
    
    let db: Firestore = Firestore.firestore()
    
    init() {
        getExercises()
        let user = Auth.auth().currentUser
        if let user = user {
            currentUser = User(uid: user.uid, email: user.email ?? "")
        } else {
            currentUser = nil
        }
    }
    
    func addExercise(name: String, duration: Int, prepDuration: Int) -> String {
        var ref: DocumentReference? = nil
        ref = db.collection("exercises").addDocument(data: [
            "createdBy": String(currentUser?.uid ?? ""),
            "name": name,
            "duration": duration,
            "prepDuration" : prepDuration,
            "type": "core"
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
            }
        }
        newExerciseList.append(ref!.documentID)
        return ref!.documentID
    }
    
    func addWorkout(name: String) {
        var ref: DocumentReference? = nil
        ref = db.collection("workouts").addDocument(data: [
            "createdBy": String(currentUser?.uid ?? ""),
            "name": name,
            "exercises": newExerciseList
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
            }
        }
    }
    
    func getExercises() {
                
        db.collection("exercises").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for exerciseDocument in querySnapshot!.documents {
                    print(exerciseDocument.documentID)
                    self.exercises.append(Exercise(name: exerciseDocument.data()["name"] as! String, key: exerciseDocument.documentID, time: (exerciseDocument.data()["duration"] as! TimeInterval), preparation: (exerciseDocument.data()["prepDuration"] as! TimeInterval)))
                }
                self.getWorkouts()
            }
        }
    }
    
    func getWorkouts() {
        db.collection("workouts").getDocuments(completion: { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for workoutDocument in querySnapshot!.documents {
                    if String(describing: workoutDocument.data()["createdBy"]!) == "0" || String(describing: workoutDocument.data()["createdBy"]!) == self.currentUser?.uid {
                        self.getWorkoutExercises(workoutDocument.documentID, name: workoutDocument.data()["name"] as! String)
                    }
                }
            }
        })
    }
    
    func getWorkoutExercises(_ workoutId: String, name: String) {
                        
        db.collection("workouts").document(workoutId).getDocument { (document, error) in
            print("workoutID \(workoutId)")
            if let document = document {
                let group_array = document["exercises"] as? Array ?? [""]
                
                for index in 0...group_array.count-1 {
                    self.workoutExercises.append(self.exercises.first { $0.key == group_array[index]}!)
                }
                self.workouts.append(Workout(name: name, exercises: self.workoutExercises))
                print("\(self.workoutExercises)")
                self.workoutExercises = []
            }
        }
    }
}
