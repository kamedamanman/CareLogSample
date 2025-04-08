import AppIntents
import SwiftData

struct LogMoodIntent: AppIntent, ProvidesDialog {
    var value: Never?
    
    static var title: LocalizedStringResource = "気分を記録"

    @Parameter(title: "気分")
    var mood: String

    static var parameterSummary: some ParameterSummary {
        Summary("気分を \(\.$mood) として記録")
    }

    init() {}

    func perform() async throws -> some IntentResult & ProvidesDialog {
        print("[LogMoodIntent] mood: \(mood)")
        try await MainActor.run {
            let log = HealthLog(mood: mood)
            let container = try ModelContainer(for: HealthLog.self)
            let context = ModelContext(container)
            context.insert(log)
            try context.save()
        }

        // ✅ 戻り値は value: を使えば AppShortcuts/Siri に返せる
        return .result(dialog: "気分「\(mood)」を記録しました")
    }
}
