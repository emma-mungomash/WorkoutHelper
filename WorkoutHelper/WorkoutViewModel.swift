import SwiftUI

struct Workouts: Identifiable {
    let name: String
    let exerciseGroup: [ExerciseGroup]
    let id = UUID()
}

struct Exercises: Hashable, Identifiable {
    let name: String
    let time: TimeInterval
    let preparation: TimeInterval
    let id = UUID()
}

struct ExerciseGroup: Identifiable {
    let name: String
    let exercise: [Exercises]
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

class WorkoutViewModel : ObservableObject {
    
    @Published var workouts: [Workouts] = []
    @Published var exercises: [Exercises] = []
    @Published var signIn: Bool = false
    
    init() {
        createDefaultWorkouts()
        createDefaultExercises()
    }
    
    func createDefaultWorkouts() {
        workouts = [
            Workouts(name: "First", exerciseGroup: [ExerciseGroup(name: "Stretches", exercise: [
                Exercises(name: "Feet Together", time: 4.0, preparation: 4.0),
                Exercises(name: "Feet Apart", time: 4.0, preparation: 4.0)])]),
            Workouts(name: "Second", exerciseGroup: [ExerciseGroup(name: "Core", exercise: [
                Exercises(name: "Standard Plank", time: 4.0, preparation: 4.0),
                Exercises(name: "Extended Arm Plank", time: 4.0, preparation: 4.0),
                Exercises(name: "Side Plank (Left)", time: 4.0, preparation: 4.0),
                Exercises(name: "Side Plank (Right)", time: 4.0, preparation: 4.0)])]),
            Workouts(name: "Third", exerciseGroup: [ExerciseGroup(name: "Body Weight Lifting", exercise: [
                Exercises(name: "Arm Swings", time: 4.0, preparation: 4.0),
                Exercises(name: "Leg Swings", time: 4.0, preparation: 4.0),
                Exercises(name: "Air Punches", time: 4.0, preparation: 4.0)])]),
            Workouts(name: "Forth", exerciseGroup: [ExerciseGroup(name: "Form Drills", exercise: [
                Exercises(name: "A Skips", time: 4.0, preparation: 4.0),
                Exercises(name: "B Skips", time: 4.0, preparation: 4.0),
                Exercises(name: "C Skips", time: 4.0, preparation: 4.0),
                Exercises(name: "B Skips with a pull through", time: 4.0, preparation: 4.0),
                Exercises(name: "A Skips with a pull through", time: 4.0, preparation: 4.0)])])
        ]
    }
    
    func createDefaultExercises() {
        exercises = [
            Exercises(name: "Feet Together", time: 4.0, preparation: 4.0),
            Exercises(name: "Feet Apart", time: 4.0, preparation: 4.0),
            Exercises(name: "Standard Plank", time: 4.0, preparation: 4.0),
            Exercises(name: "Extended Arm Plank", time: 4.0, preparation: 4.0),
            Exercises(name: "Side Plank (Left)", time: 4.0, preparation: 4.0),
            Exercises(name: "Side Plank (Right)", time: 4.0, preparation: 4.0),
            Exercises(name: "Arm Swings", time: 4.0, preparation: 4.0),
            Exercises(name: "Leg Swings", time: 4.0, preparation: 4.0),
            Exercises(name: "Air Punches", time: 4.0, preparation: 4.0),
            Exercises(name: "A Skips", time: 4.0, preparation: 4.0),
            Exercises(name: "B Skips", time: 4.0, preparation: 4.0),
            Exercises(name: "C Skips", time: 4.0, preparation: 4.0),
            Exercises(name: "B Skips with a pull through", time: 4.0, preparation: 4.0),
            Exercises(name: "A Skips with a pull through", time: 4.0, preparation: 4.0),
        ]
    }
}
