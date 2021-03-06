import Foundation
import Yams

class CraftableStore: Codable {
    static var shared = try! CraftableStore.loadStore()

    var version: String = ""
    var craftables: [String: Craftable] = [:]

    static func loadStore(data: Data) throws -> CraftableStore {
        let decoder = YAMLDecoder()
        let snorgle = try decoder.decode(CraftableStore.self, from: data)
        print("YAY got \(snorgle.craftables.count) items")
        return snorgle
    }

    static func loadStore() throws -> CraftableStore {
        guard let yamlFile = Bundle.main.url(forResource: "craftables", withExtension: "yml") else {
            print("oops, no craftables") 
            fatalError()
        }

        let data = try Data(contentsOf: yamlFile)
        return try loadStore(data: data)
    }
}


struct Craftable: Codable, Identifiable {
    // should be the dictionary key from the yaml, but I'm not smart enough to
    // figure out how to get it down here without duplicating the key.
    let id: String
    let name: String
    let price: Int?
    let recipe: [RecipeStep]?
    let type: String?

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)

        name = try values.decode(String.self, forKey: .name)
        price = try? values.decode(Int.self, forKey: .price)
        type = try? values.decode(String.self, forKey: .type)

        id = name

        var accumulator: [RecipeStep] = []

        if let steps = try? values.decode([String: Int].self, forKey: .recipe) {
            for (key, value) in steps {
                let step = RecipeStep(element: key, count: value)
                accumulator.append(step)
            }
            recipe = accumulator
        } else {
            recipe = nil
        }
    }
}


struct RecipeStep: Codable {
    let element: String
    let count: Int
}
