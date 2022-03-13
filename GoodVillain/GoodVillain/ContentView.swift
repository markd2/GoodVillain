
import SwiftUI

let store = CraftableStore.shared
let accumulator = CraftableAccumulator(store: store)

struct CraftableList: View {
    let store: CraftableStore

    var body: some View {
        List {
            ForEach(Array(store.craftables.keys.sorted()), id: \.self) { key in
                let craftable = store.craftables[key]!
                Button(craftable.name) {
                    accumulator.accumulate(element: key)
                    print(accumulator.seenItems)
                }
            }
        }
    }
}

struct ContentView: View {

    var body: some View {
        VStack {
            Text("Good Villain")
            CraftableList(store: store)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
