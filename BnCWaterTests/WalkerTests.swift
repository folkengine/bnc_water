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

    var protagonist: Walker!

    let matrix: BoundlessMatrix = BoundlessMatrix.factory([
            [1, 5, 4, 3, 2, 1],
            [2, 1, 5, 4, 3, 2],
            [3, 2, 1, 5, 4, 3],
            [4, 3, 2, 1, 5, 4],
            [5, 4, 3, 2, 1, 5]])
    let strong = Cell(column: 5, row: 4, value: 9)
    let middlin = Cell(column: 5, row: 4, value: 3)
    let weak = Cell(column: 4, row: 4, value: 1)

    override func setUp() {
        super.setUp()
        protagonist = Walker(matrix: matrix)
    }

    func testStartStepping_shortest() {
        protagonist.startStepping(Cartesian(x: 6, y: 1))
        XCTAssertEqual(protagonist.bestWalk, [Cell(column: 6, row: 1, value: 1)])
    }

    func testStep() {
        protagonist.startStepping(Cartesian(x: 1, y: 1))

        let walk = Walker.calculateWalk(protagonist.bestWalk)
        XCTAssertEqual(walk, [1, 2, 3, 4, 5, 1])
        print(walk)
    }

    func testAddBreadcrumb() {
        protagonist.addBreadcrumb(strong)

        XCTAssertTrue(protagonist.hasBreadcrumb(middlin))
        XCTAssertTrue(protagonist.hasBreadcrumb(middlin.toCartesian()))
        XCTAssertFalse(protagonist.hasBreadcrumb(weak))

        protagonist.addBreadcrumb(weak)
        XCTAssertTrue(protagonist.hasBreadcrumb(weak.toCartesian()))
    }

    func testIsWorthyOfContinuing() {
        let best = Cell(column: 5, row: 4, value: 1)
        protagonist.addBreadcrumb(middlin)
        XCTAssertTrue(protagonist.hasBreadcrumb(middlin))
        XCTAssertFalse(protagonist.isWorthyOfContinuing(strong, trail: [strong]))
        XCTAssertTrue(protagonist.isWorthyOfContinuing(best, trail: [best]))
        XCTAssertEqual(protagonist.breadcrumb[best.toCartesian()]!.value, 1)
    }

    func testCalculateWalk() {
        XCTAssertEqual(
                Walker.calculateWalk([
                        Cell(column: 1, row: 1, value: 1),
                        Cell(column: 2, row: 2, value: 1),
                        Cell(column: 3, row: 3, value: 1)]),
                [1, 2, 3])
    }
}
