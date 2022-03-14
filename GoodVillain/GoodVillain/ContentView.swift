
import SwiftUI

let store = CraftableStore.shared
var accumulator = CraftableAccumulator(store: store)

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
    @Binding var selection: Int

    var keys: [String] {
        switch selection {
        case 0:
            return Array(accumulator.seenItems.keys.sorted())
        case 1:
            return Array(accumulator.filteredItems(by: .basic).keys.sorted())
        case 2:
            return Array(accumulator.filteredItems(by: .food).keys.sorted())
        case 3:
            return Array(accumulator.filteredItems(by: .construction).keys.sorted())
        default:
            return []
        }
    }
    
    var body: some View {
        VStack {
            Text("\(trigger < 0 ? 0 : keys.count) Items")
            List {
                ForEach(keys, id: \.self) { key in
                    Text("\(key)  \(accumulator.seenItems[key]!)")
                }
            }
        }

    }
}

struct AccumulationFilter: View {
    @Binding var selection: Int

    var body: some View {
        Picker("Filter", selection: $selection) {
            Group {
                Text("all").tag(0)
                Text("basic").tag(1)
                Text("food").tag(2)
                Text("construction").tag(3)
            }
        }.pickerStyle(.segmented)
    }
}

struct ContentView: View {
    @State private var trigger = 0
    @State private var selection = 0

    var body: some View {
        VStack {
            Text("Good Villain")
            CraftableList(store: store, trigger: $trigger)
            Button("Reset") {
                accumulator.reset()
                trigger += 1
            }
            AccumulationFilter(selection: $selection)
            AccumulatorList(accumulator: accumulator,
                            trigger: $trigger, selection: $selection)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
