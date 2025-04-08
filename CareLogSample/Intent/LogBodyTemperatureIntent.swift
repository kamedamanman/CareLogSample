import AppIntents
import SwiftData

struct LogBodyTemperatureIntent: AppIntent, ProvidesDialog, ReturnsValue {
    var value: Never?
    
    static var title: LocalizedStringResource = "体温を記録する"
    
    @Parameter(title: "体温（℃）")
    var temperature: Double
    
    func perform() async throws -> some IntentResult & ReturnsValue<String> & ProvidesDialog {
        // HealthKit に書き込む
        try await HealthKitManager.shared.requestAuthorization()
        try await HealthKitManager.shared.saveTemperature(temperature)
        
        // SwiftData にも記録する
        try await MainActor.run {
            let log = HealthLog(temperature: temperature)
            let container = try ModelContainer(for: HealthLog.self)
            let context = ModelContext(container)
            context.insert(log)
            try context.save()
        }
        
        return .result(
            value: "体温 \(temperature)℃ を記録しました",
            dialog: "体温 \(temperature)℃ を記録しました"
        )
    }
}
