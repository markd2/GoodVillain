
import SwiftUI

let store = CraftableStore.shared
let accumulator = CraftableAccumulator(store: store)

struct CraftableList: View {
    let store: CraftableStore
    @Binding var trigger: Int  // I have no idea what I'm doing to trigger a refresh

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

struct AccumulatorList: View {
    let accumulator: CraftableAccumulator
    @Binding var trigger: Int
    
    var body: some View {
        VStack {
            Text("\(trigger < 0 ? 0 : accumulator.seenItems.count) Items")
            List {
                ForEach(Array(accumulator.seenItems.keys.sorted()), id: \.self) { key in
                    Text("\(key)  \(accumulator.seenItems[key]!)")
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
            AccumulatorList(accumulator: accumulator, trigger: $trigger)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
