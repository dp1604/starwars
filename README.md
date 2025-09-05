
Star Wars Planets App

A simple iOS application built with SwiftUI, Swift Concurrency, and SwiftData that displays a list of Star Wars planets using the SWAPI API. The app supports offline caching, search functionality, and includes unit tests.

Features (according to requirements)
- Fetch all planets from SWAPI
- Display planets in a scrollable list (Name + Climate)
- Show planet details (Name, Orbital Period, Gravity)
- Display placeholder images for planets using Picsum Photos
- Search planets by name (debounced)
- Offline support using SwiftData
- Unit tests for API and ViewModel

Tech Stack
- Language: Swift 5.9+
- UI: SwiftUI
- Concurrency: async/await
- Networking: Alamofire (via Swift Package Manager)
- Persistence: SwiftData
- Architecture: MVVM + Repository pattern (CLEAN MVVM)
- Testing: XCTest with mocks

Requirements
- Xcode 15+
- iOS 17+
- Internet connection for initial data fetch
- Setup & Build Instructions

Clone the repository:
git clone https://github.com/dp1604/starwars.git
cd StarWarsPlanets

Open the project in Xcode:
open StarWarsPlanets.xcodeproj

Build and run:
- Select an iOS Simulator (iOS 17+)
- Press ⌘R to run the app

Architecture Overview
The app follows a clean, layered architecture:
SwiftUI Views → ViewModel → Repository → API Service → Network Layer

- Views: SwiftUI screens and reusable components
- ViewModel: Handles UI state, search, and error handling
- Repository: Mediates between API and local cache (SwiftData)
- API Service: Fetches data from SWAPI, handles pagination
- Network Layer: Generic NetworkService protocol with Alamofire implementation

Design Decisions & Trade-offs
- SwiftUI: Chosen for modern declarative UI and simplicity
- Swift Concurrency: async/await for clean asynchronous code
- Alamofire: Simplifies networking and JSON decoding
- SwiftData: Lightweight persistence for offline support
- Repository Pattern: Clear separation of concerns and testability
- Error Handling: Unified via AppError for consistent UI messaging

Known Limitations
- Image caching is in-memory only (no disk cache)

Future Improvements
- Add disk-based image caching (e.g., Nuke or Kingfisher)
- Improve error UI with banners or retry overlays
- Add localization
- Add UI Tests

Testing
- Run all tests:
⌘U in Xcode

Tests include:
- APIServiceTests: Validates API fetch success/failure
- PlanetListViewModelTests: Validates loading, error handling, and search
