//
//  WalkerTests.swift
//  BnCWater
//
//  Created by Christopher Baker on 7/1/16.
//  Copyright © 2016 Christopher Baker. All rights reserved.
//

import Foundation
import XCTest

@testable import BnCWater

class WalkerTests: XCTestCase {

    var matrix: BoundlessMatrix = BoundlessMatrix.factory([
            [1, 5, 4, 3, 2, 1],
            [2, 1, 5, 4, 3, 2],
            [3, 2, 1, 5, 4, 3],
            [4, 3, 2, 1, 5, 4],
            [5, 4, 3, 2, 1, 5]])

    func testStep() {
        let enter = Walker(matrix: matrix)
        enter.step(Cartesian(x: 1, y: 1), cells: [])
        print(enter.bestWalk)
    }

    func testIsWorthyOfContinuing() {
        let walker = Walker(matrix: matrix)
        let strong = Cell(row: 4, column: 5, value: 9)
        let middlin = Cell(row: 4, column: 5, value: 3)
        let weak = Cell(row: 4, column: 4, value: 1)
        walker.addBreadcrumb(strong)

        XCTAssertTrue(walker.hasBreadcrumb(middlin))
        XCTAssertTrue(walker.hasBreadcrumb(middlin.toCartesian()))
        XCTAssertFalse(walker.hasBreadcrumb(weak))
    }
}
