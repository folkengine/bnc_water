//
//  Walker.swift
//  BnCWater
//
//  Created by Christopher Baker on 7/1/16.
//  Copyright © 2016 Christopher Baker. All rights reserved.
//

import Foundation

/// Modified brute force that includes a breadcrumb to reduce repeating paths.
///
class Walker {
    let matrix: BoundlessMatrix
    
    var stuff:[[Cell]] = [[]]

    var bestWalk: [Cell] = []
    var bestWalkSum: Int = 0
    var breadcrumb: [Cartesian:Cell] = [:]
    
    init(matrix: BoundlessMatrix) {
        self.matrix = matrix
    }

    func submitCandidate(candidate: [Cell]) {
        let candidateSum = Cell.sumOfValues(candidate)

        if ((bestWalkSum == 0) || (candidateSum < bestWalkSum)) {
            NSLog("New best walk: \(candidateSum) \(candidate) ")
            bestWalk = candidate
            bestWalkSum = candidateSum
        }
    }

    func addBreadcrumb(cell: Cell) {
        addBreadcrumb(cell, trail: [cell])
    }

    func addBreadcrumb(cell: Cell, trail: [Cell]) {
        breadcrumb[cell.toCartesian()] = cell.toCartesian().toCell(Cell.sumOfValues(trail)) // 8-)
    }

    func hasBreadcrumb(xy: Cartesian) -> Bool {
        return (breadcrumb[xy] != nil)
    }

    func hasBreadcrumb(cell: Cell) -> Bool {
        return hasBreadcrumb(cell.toCartesian())
    }

    func isWorthyOfContinuing(cell: Cell, trail: [Cell]) -> Bool {
        let xy = cell.toCartesian()
        if (hasBreadcrumb(cell) && (breadcrumb[xy]!.value < cell.value)) {
            return false
        }
        addBreadcrumb(cell)
        return true
    }
    
    func step(xy: Cartesian, cells: [Cell]) {
        var candidate = cells
        let currentCell = matrix.retrieveCell(xy)
        candidate.append(currentCell)
        if (matrix.isFinalColumm(xy)) {
            submitCandidate(candidate)
            return
        }
        step(matrix.leftOfCell(xy).toCartesian(), cells: candidate)
        step(matrix.centerOfCell(xy).toCartesian(), cells: candidate)
        step(matrix.rightOfCell(xy).toCartesian(), cells: candidate)
    }
    
    func pathOfLeastResistance() -> [Int] {
        return []
    }
}