import SwiftUI

struct ContentView: View {
    @EnvironmentObject var store: RoundStore
    @State private var showingAdd = false

    var body: some View {
        NavigationView {
            List {
                ForEach(store.rounds) { round in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(round.course).font(.headline)
                            Text(Self.dateFormatter.string(from: round.date))
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        Spacer()
                        VStack(alignment: .trailing) {
                            Text("Holes: \(round.holes)")
                            Text("Score: \(round.score)")
                                .font(.headline)
                        }
                    }
                    .padding(.vertical, 6)
                }
                .onDelete(perform: store.remove)
            }
            .listStyle(PlainListStyle())
            .navigationTitle("Golf Rounds")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { showingAdd = true }) {
                        Image(systemName: "plus")
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
            }
            .sheet(isPresented: $showingAdd) {
                AddRoundView(isPresented: $showingAdd)
                    .environmentObject(store)
            }
        }
    }

    static let dateFormatter: DateFormatter = {
        let f = DateFormatter()
        f.dateStyle = .medium
        f.timeStyle = .none
        return f
    }()
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(RoundStore())
    }
}
