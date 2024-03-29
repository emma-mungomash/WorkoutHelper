import SwiftUI

struct HomeGrid: View {
    
    @EnvironmentObject var viewModel: WorkoutViewModel
    
    var body: some View {
        let columns: [GridItem] =
                 Array(repeating: .init(.flexible()), count: 2)
        ZStack(alignment: .center) {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(viewModel.workouts) { workout in
                         NavigationLink(destination: WorkoutPlan(workout: workout)
                                            .environmentObject(viewModel)) {
                             VStack {
                                 Text(workout.name).font(.system(size: 25, weight: .bold, design: .default))
                             }
                             .padding(16)
                             .foregroundColor(Color.white)
                             .frame(width: UIScreen.main.bounds.width/2 - 32, height: UIScreen.main.bounds.width/2 - 32)
                             .background(Color.gray)
                             .cornerRadius(20)
                         }
                     }
                    NavigationLink(destination: NewWorkout(workouts: $viewModel.workouts)
                                    .environmentObject(viewModel)) {
                         Text("+")
                             .foregroundColor(Color.white)
                             .frame(width: UIScreen.main.bounds.width/2 - 32, height: UIScreen.main.bounds.width/2 - 32)
                                 .background(Color.gray)
                                 .cornerRadius(20)
                     }
                 }.font(.largeTitle)
            }
            .padding(.vertical, 45)
            .padding(.horizontal, 16)
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            .padding(16)
        }
    }
}
