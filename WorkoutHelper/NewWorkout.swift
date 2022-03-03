import SwiftUI

struct NewWorkout: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    let formatter = DateComponentsFormatter()
    
    @State private var exercizeList: [Exercises] = []
    @Binding var workouts: [Workouts]
        
    var body: some View {
        List {
            ForEach(exercizeList) { exercise in
                Button(action: {}) {
                    VStack(alignment: .leading) {
                        Text(exercise.name)
                        Text("Time: \(formatter.string(from: exercise.time)!)")
                        Text("Preparation: \(formatter.string(from: exercise.preparation)!)")
                    }
                }
            }
            NavigationLink(destination: NewExercise(exercises: $exercizeList)) {
                Text("Add exercize")
            }
        }
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height, alignment: .center)
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            Button(action: onTap) {
                Text("Save")
            }
        }
    }
    
    func onTap() {
        workouts.append(Workouts(name: "Workout", exerciseGroup: [ExerciseGroup(name: "Stretches", exercise: exercizeList)]))
        self.presentationMode.wrappedValue.dismiss()
    }
}
