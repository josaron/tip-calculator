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
    
    func calcTipWithTipPct(tipPct: Double) -> Double {
        return tipPct * subtotal
    }
    
    func returnPossibleTips() -> [Int: Double] {
        let possibleTips = [0.15, 0.18, 0.20]
        var retval = [Int: Double]()
        for possibleTip in possibleTips {
            var tipPct = Int(100 * possibleTip)
            retval[tipPct] = calcTipWithTipPct(possibleTip)
        }
        return retval
    }
}