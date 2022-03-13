import Foundation
import Yams

class CraftableStore: Codable {
    var version: String = ""
    var craftables: [String: Craftable] = [:]

    static func loadStore() {
        guard let yamlFile = Bundle.main.url(forResource: "craftables", withExtension: "yml") else {
            print("oops, no craftables") 
            fatalError()
        }

        do {
            let data = try Data(contentsOf: yamlFile)
            let decoder = YAMLDecoder()
            let snorgle = try decoder.decode(CraftableStore.self, from: data)
            print("YAY got \(snorgle.craftables.count) items")
        } catch {
            print("BOO \(error)")
        }
    }
}


struct Craftable: Codable {
    let name: String
    let price: Int?
}
