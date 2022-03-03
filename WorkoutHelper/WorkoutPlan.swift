import SwiftUI

struct WorkoutPlan: View {
    
    var workout: Workouts
    
    let formatter = DateComponentsFormatter()
    
    @State private var singleSelection : UUID?
    @State var startSession = false
    
    var body: some View {
        ZStack(alignment: .bottom) {
            List(selection: $singleSelection){
                ForEach(workout.exerciseGroup) { exerciseGroup in
                    Section(header: Text(exerciseGroup.name)) {
                        ForEach(exerciseGroup.exercise) { exercise in
                            VStack(alignment: .leading, spacing: 16) {
                                HStack {
                                    Text(exercise.name)
                                    Spacer()
                                    Text("\(formatter.string(from: exercise.time)!)")
                                }
                                Text("Preparation: \(formatter.string(from: exercise.preparation)!)")
                            }.padding(16)
                        }
                    }
                }
            }
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 100, alignment: .top)
            .toolbar {
                Button(action: {}) {
                    Text("Edit")
                }
            }
             HStack {
                 Button(action: {startSession = true}) {
                     Text("Start")
                        .foregroundColor(Color.white)
                        .frame(width: 200, height: 50)
                        .background(Color.green)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                 }
            }
        }.sheet(isPresented: $startSession) {
            WorkoutSession(workout: workout, dismissSheet: $startSession)
        }
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 100)
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
    }
}
