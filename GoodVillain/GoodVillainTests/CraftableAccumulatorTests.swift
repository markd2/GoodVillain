//
//  CraftableAccumulatorTests.swift
//  GoodVillainTests
//
//  Created by markd on 3/13/22.
//

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

    func testRecursiveAccumulation() throws {
    }

    let storeYaml = """
      ---
      version: "1.0"
      craftables:
          wheat:  # 1 wheat
              name: "Wheat"
              price: 1
          spam:   # 1 spam
              name: "Spam"
              price: 2
          greeble:  # 2 wheat, 3 spam
              name: "Greeble"
              recipe:
                  wheat: 2
                  spam: 3
          hoover:  # 5 + 5*2 wheat (15), 2*3 spam (6)
              name: "Hoover"
              recipe:
                  wheat: 5
                  greeble: 2
      """
}
