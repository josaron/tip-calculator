//
//  TipCalculatorModel.swift
//  TipCalculator
//
//  Created by Joseph Aharon on 3/10/15.
//  Copyright (c) 2015 Joseph Aharon. All rights reserved.
//

import Foundation

class TipCalculatorModel {
    
    var charge: Double
    var taxPct: Double
    var subtotal: Double {
        get {
            return charge / (1 + taxPct)
        }
    }
    
    init(charge: Double, taxPct: Double) {
        self.charge = charge
        self.taxPct = taxPct
    }
    
    func calcTipWithTipPct(tipPct: Double) -> (tipAmt: Double, finalTotal: Double) {
        let tipAmt = subtotal * tipPct
        let finalTotal = tipAmt + subtotal
        return (tipAmt, finalTotal)
    }
    
    func returnPossibleTips() -> [Int: (tipAmt: Double, finalTotal: Double)] {
        let possibleTips = [0.15, 0.18, 0.20]
        var retval = Dictionary<Int, (tipAmt:Double, finalTotal: Double)>()
        for possibleTip in possibleTips {
            var tipPct = Int(100 * possibleTip)
            retval[tipPct] = calcTipWithTipPct(possibleTip)
        }
        return retval
    }
}


import UIKit

class TestDataSource : NSObject, UITableViewDataSource {
    
    let tipCalc = TipCalculatorModel(charge: 33.25, taxPct: 0.06)
    var possibleTips = Dictionary<Int, (tipAmt: Double, finalTotal: Double)>()
    var sortedKeys:[Int] = []
    
    override init() {
        possibleTips = tipCalc.returnPossibleTips()
        sortedKeys = sorted(Array(possibleTips.keys))
        super.init()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sortedKeys.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.Value2, reuseIdentifier: nil)
        let tipPct = sortedKeys[indexPath.row]
        let tipAmt = possibleTips[tipPct]!.tipAmt
        let total = possibleTips[tipPct]!.finalTotal
        cell.textLabel?.text = "\(tipPct)%:"
        cell.detailTextLabel?.text = String(format: "Tip: $%0.2f, Total: $%0.2f", tipAmt, total)
        return cell
    }
}