import SwiftUI

@main
struct GolfScoresApp: App {
    @StateObject private var store = RoundStore()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(store)
        }
    }
}
