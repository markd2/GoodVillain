import XCTest
@testable import GoodVillain

class CraftableAccumulatorTests: XCTestCase {
    
    private var store: CraftableStore!
    private var accumulator: CraftableAccumulator!

    override func setUpWithError() throws {
        let data = storeYaml.data(using: .utf8)!
        store = try CraftableStore.loadStore(data: data)
        accumulator = CraftableAccumulator(store: store)
        print("yay")
    }

    override func tearDownWithError() throws {
        store = nil
        accumulator = nil
    }

    func testSingleAccumulateStep() throws {
        let step = RecipeStep(element: "wheat", count: 12)
        accumulator.accumulate(recipeStep: step)

        XCTAssertEqual(accumulator.seenItems.count, 1)
        XCTAssertEqual(accumulator.seenItems["wheat"], 12)
    }

    func testSingleAccumulation() throws {
        accumulator.accumulate(element: "spam", count: 23)

        XCTAssertEqual(accumulator.seenItems.count, 1)
        XCTAssertEqual(accumulator.seenItems["spam"], 23)
    }

    func testMultipleAccumulation() throws {
        accumulator.accumulate(element: "wheat", count: 10)
        accumulator.accumulate(element: "spam", count: 15)
        accumulator.accumulate(element: "wheat", count: 37)

        XCTAssertEqual(accumulator.seenItems.count, 2)
        XCTAssertEqual(accumulator.seenItems["wheat"], 47)
        XCTAssertEqual(accumulator.seenItems["spam"], 15)
    }

    func testSimpleRecursiveAccumulation() throws {
        accumulator.accumulate(element: "greeble", count: 1)
        XCTAssertEqual(accumulator.seenItems.count, 3)

        XCTAssertEqual(accumulator.seenItems["greeble"], 1)
        XCTAssertEqual(accumulator.seenItems["wheat"], 2)
        XCTAssertEqual(accumulator.seenItems["spam"], 3)
    }

    func testMultipleRecursiveAccumulation() throws {
        accumulator.accumulate(element: "greeble", count: 2)
        XCTAssertEqual(accumulator.seenItems.count, 3)

        XCTAssertEqual(accumulator.seenItems["greeble"], 2)
        XCTAssertEqual(accumulator.seenItems["wheat"], 4)
        XCTAssertEqual(accumulator.seenItems["spam"], 6)
    }

    func testSimpleDeeperRecursiveAccumulation() throws {
        accumulator.accumulate(element: "hoover", count: 1)
        XCTAssertEqual(accumulator.seenItems.count, 4)

        XCTAssertEqual(accumulator.seenItems["hoover"], 1)
        XCTAssertEqual(accumulator.seenItems["greeble"], 2)
        XCTAssertEqual(accumulator.seenItems["wheat"], 9)
        XCTAssertEqual(accumulator.seenItems["spam"], 6)
    }

    func testMultipleDeeperRecursiveAccumulation() throws {
        accumulator.accumulate(element: "hoover", count: 3)
        accumulator.accumulate(element: "greeble", count: 5)
        XCTAssertEqual(accumulator.seenItems.count, 4)

        XCTAssertEqual(accumulator.seenItems["hoover"], 3)
        XCTAssertEqual(accumulator.seenItems["greeble"], 3*2 + 5)
        XCTAssertEqual(accumulator.seenItems["wheat"], 3*5 + 6*2 + 5*2)
        XCTAssertEqual(accumulator.seenItems["spam"], 3*2*3 + 5*3)
    }

    let storeYaml = """
      ---
      version: "1.0"
      craftables:
          wheat:  # 1 wheat
              name: "Wheat"
              price: 1
              type: basic
          spam:   # 1 spam
              name: "Spam"
              price: 2
              type: basic
          greeble:  # 2 wheat, 3 spam
              name: "Greeble"
              type: food
              recipe:
                  wheat: 2
                  spam: 3
          hoover:  # 5 + 2*2 wheat (9), 2*3 spam (6)
              name: "Hoover"
              type: construction
              recipe:
                  wheat: 5
                  greeble: 2
      """
}
