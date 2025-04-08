import HealthKit

class HealthKitManager {
    static let shared = HealthKitManager()
    private let store = HKHealthStore()

    // 読み書きするデータの種類（今回は体温）
    private let temperatureType = HKQuantityType.quantityType(forIdentifier: .bodyTemperature)!

    // 初回に呼び出して許可をリクエスト
    func requestAuthorization() async throws {
        try await store.requestAuthorization(
            toShare: [temperatureType],
            read: [temperatureType]
        )
    }

    // 体温をHealthKitへ保存
    func saveTemperature(_ temperature: Double, date: Date = .now) async throws {
        let quantity = HKQuantity(unit: HKUnit.degreeCelsius(), doubleValue: temperature)
        let sample = HKQuantitySample(type: temperatureType, quantity: quantity, start: date, end: date)
        try await store.save(sample)
    }

    // 最新の体温データを取得
    func fetchLatestTemperature() async throws -> Double? {
        let sort = NSSortDescriptor(key: HKSampleSortIdentifierEndDate, ascending: false)
        let query = HKSampleQuery(sampleType: temperatureType, predicate: nil, limit: 1, sortDescriptors: [sort]) { _, results, error in
            if let sample = results?.first as? HKQuantitySample {
                print("最新の体温：\(sample.quantity.doubleValue(for: .degreeCelsius()))℃")
            } else {
                print("体温データが見つかりませんでした")
            }
        }
        store.execute(query)
        return nil
    }
}
