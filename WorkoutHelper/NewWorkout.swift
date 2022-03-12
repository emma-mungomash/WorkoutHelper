import SwiftUI

struct NewWorkout: View {
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var viewModel: WorkoutViewModel
    
    let formatter = DateComponentsFormatter()
    
    @State private var exercizeList: [Exercise] = []
    @Binding var workouts: [Workout]
    @State var workoutName: String = ""
        
    var body: some View {
        VStack {
            TextField("workout name", text: $workoutName)
                .font(.title)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal, 16)
            List {
                ForEach(exercizeList) { exercise in
                    Button(action: {}) {
                        VStack(alignment: .leading) {
                            Text(exercise.name)
                            Text("Time: \(formatter.string(from: exercise.time ?? 0.0)!)")
                            Text("Preparation: \(formatter.string(from: exercise.preparation ?? 0.0)!)")
                        }
                    }
                }
                NavigationLink(destination: NewExercise(exercises: $exercizeList)
                                .environmentObject(viewModel)) {
                    Text("Add exercize")
                }
            }
        }
        .padding(.top, 75)
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
        viewModel.addWorkout(name: workoutName)
        workouts.append(Workout(name: workoutName, exercises: exercizeList))
        self.presentationMode.wrappedValue.dismiss()
    }
}
