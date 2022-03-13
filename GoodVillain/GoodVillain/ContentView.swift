
import SwiftUI

let store = CraftableStore.shared
let accumulator = CraftableAccumulator(store: store)

struct CraftableList: View {
    let store: CraftableStore
    @Binding var trigger: Int

    var body: some View {
        List {
            ForEach(Array(store.craftables.keys.sorted()), id: \.self) { key in
                let craftable = store.craftables[key]!
                Button(craftable.name) {
                    accumulator.accumulate(element: key)
                    print(accumulator.seenItems)
                    trigger += 1
                }
            }
        }
    }
}

struct ContentView: View {
    @State var trigger = 0

    var body: some View {
        VStack {
            Text("Good Villain")
            CraftableList(store: store, trigger: $trigger)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
