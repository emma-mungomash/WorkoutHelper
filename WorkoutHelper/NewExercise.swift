import SwiftUI

struct NewExercise: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @EnvironmentObject var viewModel: WorkoutViewModel
    
    let formatter = DateComponentsFormatter()
    
    @Binding var exercises: [Exercise]
    @State var time: Int = 4
    @State var preparation: Int = 4
    @State var pickName = false
    @State var pickTime = false
    @State var pickPreparation = false
    @State private var selectedExercise: SelectedExercise = .FeetTogether
    @State private var selectedTime: SelectedTime = .one
    @State private var selectedPreparation: SelectedPreparation = .one

    var body: some View {
        List {
            exercisePicker
            HStack(spacing: 0) {
                Text("Time:")
                Spacer()
                Picker("Time:", selection: $selectedTime) {
                    ForEach(0...59, id: \.self) {
                        Text("\(formatter.string(from: Double($0))!) m").tag($0)
                    }
                }
                .pickerStyle(.wheel)
                .frame(width: UIScreen.main.bounds.width/5, height: 100)
                .clipped()
                Text(":")
                Picker("Time:", selection: $selectedTime) {
                    ForEach(0...59, id: \.self) {
                        Text("\(formatter.string(from: Double($0))!) s").tag($0)
                    }
                }
                .pickerStyle(.wheel)
                .frame(width: UIScreen.main.bounds.width/5, height: 100)
                .clipped()
            }
            
            HStack(spacing: 0) {
                Text("Preparation:")
                Spacer()
                Picker("", selection: $selectedPreparation) {
                    ForEach(0...59, id: \.self) {
                        Text("\(formatter.string(from: Double($0))!) m").tag($0)
                    }
                }
                .pickerStyle(.wheel)
                .frame(width: UIScreen.main.bounds.width/5, height: 100)
                .clipped()
                Text(":")
                Picker("", selection: $selectedPreparation) {
                    ForEach(0...59, id: \.self) {
                        Text("\(formatter.string(from: Double($0))!) s").tag($0)
                    }
                }
                .pickerStyle(.wheel)
                .frame(width: UIScreen.main.bounds.width/5, height: 100)
                .clipped()
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
    
    var exercisePicker: some View {
        Picker("Exercise:" , selection: $selectedExercise) {
            Group {
                Text("Feet Together").tag(SelectedExercise.FeetTogether)
                Text("Feet Apart").tag(SelectedExercise.FeetApart)
            }
            Group {
                Text("Standard Plank").tag(SelectedExercise.StandardPlank)
                Text("Extended Arm Plank").tag(SelectedExercise.ExtendedArmPlank)
                Text("Side Plank (Left)").tag(SelectedExercise.SidePlankLeft)
                Text("Side Plank (Right)").tag(SelectedExercise.SidePlankRight)
            }
            Group {
                Text("Arm Swings").tag(SelectedExercise.ArmSwings)
                Text("Leg Swings").tag(SelectedExercise.LegSwings)
                Text("Air Punches").tag(SelectedExercise.AirPunches)
            }
            Group {
                Text("A Skips").tag(SelectedExercise.ASkips)
                Text("B Skips").tag(SelectedExercise.BSkips)
                Text("C Skips").tag(SelectedExercise.CSkips)
                Text("B Skips With A Pull Through").tag(SelectedExercise.BSkipsPullThrough)
                Text("A Skips With A Pull Through").tag(SelectedExercise.ASkipsPullThrough)
            }
        }
    }
    
    func onTap() {
        let key = viewModel.addExercise(name: name, duration: time*1000, prepDuration: preparation*1000)
        exercises.append(Exercise(name: name, key: key, time: TimeInterval(time), preparation: TimeInterval(preparation)))
        self.presentationMode.wrappedValue.dismiss()
    }
    
    var name: String {
        switch selectedExercise {
        case .FeetTogether:
            return "Feet Together"
        case .FeetApart:
            return "Feet Apart"
        case .StandardPlank:
            return "Standard Plank"
        case .ExtendedArmPlank:
            return "Extended Arm Plank"
        case .SidePlankLeft:
            return "Side Plank (Left)"
        case .SidePlankRight:
            return "Side Plank (Right)"
        case .ArmSwings:
            return "Arm Swings"
        case .LegSwings:
            return "Leg Swings"
        case .AirPunches:
            return "Air Punches"
        case .ASkips:
            return "A Skips"
        case .BSkips:
            return "B Skips"
        case .CSkips:
            return "C Skips"
        case .BSkipsPullThrough:
            return "B Skips With A Pull Through"
        case .ASkipsPullThrough:
            return "A Skips With A Pull Through"
        }
    }
}

extension View {
    func hideKeyboard() {
        let resign = #selector(UIResponder.resignFirstResponder)
        UIApplication.shared.sendAction(resign, to: nil, from: nil, for: nil)
    }
}
