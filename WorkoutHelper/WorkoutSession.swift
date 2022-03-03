import SwiftUI

struct WorkoutSession: View {
        
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    let formatter = DateComponentsFormatter()
    
    var workout: Workouts
    @State var exerciseCount: Int
    @State var time: TimeInterval
    @State var preparation: TimeInterval
    @Binding var dismissSheet: Bool
    
    init(workout: Workouts, dismissSheet: Binding<Bool>) {
        self.workout = workout
        self._exerciseCount = State(initialValue: 0)
        self._dismissSheet = dismissSheet
        self._time = State(initialValue: workout.exerciseGroup[0].exercise[0].time)
        self._preparation = State(initialValue: workout.exerciseGroup[0].exercise[0].preparation)
    }
    
    var body: some View {
        VStack {
            if workout.exerciseGroup[0].exercise.count > exerciseCount {
                Text(workout.exerciseGroup[0].exercise[exerciseCount].name).font(.system(size: 50, weight: .bold, design: .default))
                Text(preparation >= 0 ? "Prepare: \(formatter.string(from: preparation)!)" : "Go: \(formatter.string(from: time)!)").font(.system(size: 50, weight: .bold, design: .default))
                    .foregroundColor(preparation >= 0 ? Color.red : Color.green)
            } else {
                Text("Finished Workout").font(.system(size: 50, weight: .bold, design: .default))
                Button(action: {dismissSheet = false}) {
                    Text("Done")
                       .foregroundColor(Color.white)
                       .frame(width: 200, height: 50)
                       .background(Color.green)
                       .clipShape(RoundedRectangle(cornerRadius: 20))
                }
            }
        }
        .onReceive(timer) { _ in
            if preparation >= 0 {
                preparation -= 1
            } else if time > 0 {
                time -= 1
            } else {
                exerciseCount += 1
            }
        }
        .onChange(of: exerciseCount) { newValue in
            if workout.exerciseGroup[0].exercise.count > exerciseCount {
                time = workout.exerciseGroup[0].exercise[exerciseCount].time
                preparation = workout.exerciseGroup[0].exercise[exerciseCount].preparation
            }
        }
    }
}
