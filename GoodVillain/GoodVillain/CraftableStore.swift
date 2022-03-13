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
    let recipe: [RecipeStep]?

    enum AdditionalInfoKeys: String, CodingKey {
        case recipe
    }


    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)

        name = try values.decode(String.self, forKey: .name)
        price = try? values.decode(Int.self, forKey: .price)

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
