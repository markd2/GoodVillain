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

    override func setUpWithError() throws {
        let data = storeYaml.data(using: .utf8)!
        store = try CraftableStore.loadStore(data: data)
        print("yay")
    }

    override func tearDownWithError() throws {
        store = nil
    }

    func testSingleAcumulation() throws {
    }

    func testMultipleAccumulation() throws {
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
