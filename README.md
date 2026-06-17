# GolfScores (SwiftUI starter)

This repository contains a small SwiftUI app scaffold that tracks golf rounds (date, course, # holes, score).

Files added:
- `GolfScoresApp.swift` — app entry
- `Models/Round.swift` — `Round` model and `RoundStore` for JSON persistence
- `Views/ContentView.swift` — main list UI
- `Views/AddRoundView.swift` — form to add a round

How to use
1. Open Xcode and create a new **iOS App** project (Interface: SwiftUI, Language: Swift).
2. Replace the generated `App` and `ContentView` files with the files in this folder (or add these Swift files to your project).
3. Build and run on a simulator or device.

Persistence
Rounds are saved as `rounds.json` in the app's Documents directory using `JSONEncoder`/`JSONDecoder`.

Next steps I can do for you:
- Create a full Xcode project file here.
- Add editing of existing rounds.
- Add sorting, filtering, and export/import features.
