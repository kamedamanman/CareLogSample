import SwiftUI
import SwiftData

struct HealthLogListView: View {
    @Query(sort: \HealthLog.date, order: .reverse) var logs: [HealthLog]

    var body: some View {
        NavigationStack {
            List(logs) { log in
                VStack(alignment: .leading) {
                    Text(log.date.formatted(date: .abbreviated, time: .shortened))
                        .font(.caption)
                        .foregroundColor(.gray)

                    if let temp = log.temperature {
                        Text("体温：\(String(format: "%.1f", temp))℃")
                    }

                    if let mood = log.mood {
                        Text("気分：\(mood)")
                    }
                }
            }
            Button("HealthKitの認証") {
                Task {
                    try? await HealthKitManager.shared.requestAuthorization()
                }
            }
            .navigationTitle("ケアログ")
        }
    }
}
