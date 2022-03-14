import Foundation

class CraftableAccumulator {
    let store: CraftableStore
    var seenItems: [String: Int] = [:]

    enum Filter {
        case all
        case basic
        case food
        case construction
    }

    init(store: CraftableStore) {
        self.store = store
    }

    func reset() {
        seenItems = [:]
    }

    func accumulate(element: String, count: Int = 1) {
        let elementCount = seenItems[element, default: 0]
        seenItems[element] = elementCount + count

        // then expand the elements.  Cycles not detected and will kill us, so be careful.
        guard let craftable = store.craftables[element] else {
            fatalError("missing craftable: \(element)")
        }
        for _ in 0 ..< count {
            for recipeStep in craftable.recipe ?? [] {
                accumulate(recipeStep: recipeStep)
            }
        }
    }

    func accumulate(recipeStep: RecipeStep, count: Int = 1) {
        accumulate(element: recipeStep.element, count: recipeStep.count * count)
    }

    func filteredItems(by filter: Filter) -> [String: Int] {
        let items = seenItems.filter { key, value in
            guard let item = store.craftables[key] else { return false }

            switch filter {
            case .all:
                return true
            case .basic:
                return item.type == "basic"
            case .food:
                return item.type == "food"
            case .construction:
                return item.type == "construction"
            }
        }

        return items
    }
}
