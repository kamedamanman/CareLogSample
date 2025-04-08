import Foundation
import SwiftData

@Model
class HealthLog {
    var date: Date
    var temperature: Double?
    var mood: String?

    init(date: Date = .now, temperature: Double? = nil, mood: String? = nil) {
        self.date = date
        self.temperature = temperature
        self.mood = mood
    }
}
