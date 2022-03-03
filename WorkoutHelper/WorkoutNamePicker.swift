import SwiftUI

struct WorkoutNamePicker: View {
    var body: some View {
        VStack {
            Button(action: {}) {
                Text("Stretches")
            }
            Button(action: {}) {
                Text("Core")
            }
            Button(action: {}) {
                Text("Body Weight Lifting")
            }
            Button(action: {}) {
                Text("Form Drills")
            }
        }
        .transition(.move(edge: .top))
        .frame(width: 100, height: 100)
    }
}

struct WorkoutNamePicker_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutNamePicker()
    }
}
