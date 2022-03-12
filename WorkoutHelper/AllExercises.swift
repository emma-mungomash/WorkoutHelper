import SwiftUI

struct AllExercises: View {
    
    @EnvironmentObject var viewModel: WorkoutViewModel
    
    let formatter = DateComponentsFormatter()
    
    var body: some View {
        List() {
            ForEach(viewModel.exercises) { exercise in
                VStack(alignment: .leading, spacing: 16) {
                    HStack {
                        Text(exercise.name)
                        Spacer()
                        Text("\(formatter.string(from: exercise.time ?? 0.0)!)")
                    }
                    Text("Preparation: \(formatter.string(from: exercise.preparation ?? 0.0)!)")
                }.padding(16)
            }.onDelete(perform: delete)
        }
    }
    
    func delete(at offsets: IndexSet) {
        viewModel.exercises.remove(atOffsets: offsets)
    }
}
