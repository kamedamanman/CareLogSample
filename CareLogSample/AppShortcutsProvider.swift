import AppIntents

struct CareLogShortcuts: AppShortcutsProvider {
    static var appShortcuts: [AppShortcut] {
        return [
            AppShortcut(
                intent: LogBodyTemperatureIntent(),
                phrases: [
                    AppShortcutPhrase("${applicationName}で体温を記録して"),
                    AppShortcutPhrase("今日の体温は◯度だった（${applicationName}）")
                ],
                shortTitle: "体温を記録",
                systemImageName: "thermometer"
            ),
            AppShortcut(
                intent: LogMoodIntent(),
                phrases: [
                    AppShortcutPhrase("${applicationName}で気分を記録"),
                    AppShortcutPhrase("今日は◯◯な気分だった（${applicationName}）")
                ],
                shortTitle: "気分を記録",
                systemImageName: "face.smiling"
            )
        ]
    }
}
