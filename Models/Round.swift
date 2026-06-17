import Foundation

struct Round: Identifiable, Codable, Equatable {
    var id: UUID = UUID()
    var date: Date
    var course: String
    var holes: Int
    var score: Int
}

final class RoundStore: ObservableObject {
    @Published private(set) var rounds: [Round] = [] {
        didSet { save() }
    }

    private let fileURL: URL

    init(filename: String = "rounds.json") {
        let fm = FileManager.default
        let docs = fm.urls(for: .documentDirectory, in: .userDomainMask).first!
        self.fileURL = docs.appendingPathComponent(filename)
        load()
    }

    func add(_ round: Round) {
        rounds.insert(round, at: 0)
    }

    func remove(at offsets: IndexSet) {
        rounds.remove(atOffsets: offsets)
    }

    private func load() {
        do {
            let data = try Data(contentsOf: fileURL)
            let decoded = try JSONDecoder().decode([Round].self, from: data)
            self.rounds = decoded
        } catch {
            self.rounds = []
        }
    }

    private func save() {
        do {
            let data = try JSONEncoder().encode(rounds)
            try data.write(to: fileURL, options: [.atomic])
        } catch {
            print("Failed to save rounds:", error)
        }
    }
}
