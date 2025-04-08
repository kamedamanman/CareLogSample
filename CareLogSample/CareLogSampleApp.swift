import SwiftUI
import SwiftData

@main
struct CareLogSampleApp: App {
    var body: some Scene {
        WindowGroup {
            TabView {
                HealthLogListView()
                    .tabItem {
                        Label("記録一覧", systemImage: "heart.text.square")
                    }
            }
        }
        .modelContainer(for: HealthLog.self)
    }
}
