import Foundation

class CraftableAccumulator {
    let store: CraftableStore
    var seenItems: [String: Int] = [:]

    init(store: CraftableStore) {
        self.store = store
    }

    func accumulate(element: String, count: Int) {
        let elementCount = seenItems[element, default: 0]
        seenItems[element] = elementCount + count

        // then expand the elements.  Cycles not detected and will kill us, so be careful.
        guard let craftable = store.craftables[element] else {
            fatalError("missing craftable: \(element)")
        }
        
        for recipeStep in craftable.recipe ?? [] {
            accumulate(recipeStep: recipeStep)
        }
    }

    func accumulate(recipeStep: RecipeStep) {
        accumulate(element: recipeStep.element, count: recipeStep.count)
    }

}
