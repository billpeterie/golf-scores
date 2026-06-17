import SwiftUI

struct AddRoundView: View {
    @EnvironmentObject var store: RoundStore
    @Binding var isPresented: Bool

    @State private var date: Date = Date()
    @State private var course: String = ""
    @State private var holes: Int = 18
    @State private var score: Int = 72

    var body: some View {
        NavigationView {
            Form {
                DatePicker("Date", selection: $date, displayedComponents: .date)

                TextField("Course", text: $course)

                Stepper(value: $holes, in: 1...36) {
                    Text("Holes: \(holes)")
                }

                Stepper(value: $score, in: 1...200) {
                    Text("Score: \(score)")
                }
            }
            .navigationTitle("Add Round")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { isPresented = false }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") { save() }
                        .disabled(course.trimmingCharacters(in: .whitespaces).isEmpty)
                }
            }
        }
    }

    private func save() {
        let new = Round(date: date, course: course.trimmingCharacters(in: .whitespaces), holes: holes, score: score)
        store.add(new)
        isPresented = false
    }
}

struct AddRoundView_Previews: PreviewProvider {
    static var previews: some View {
        AddRoundView(isPresented: .constant(true))
            .environmentObject(RoundStore())
    }
}
