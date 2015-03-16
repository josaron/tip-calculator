//
//  ViewController.swift
//  TipCalculator
//
//  Created by Joseph Aharon on 3/10/15.
//  Copyright (c) 2015 Joseph Aharon. All rights reserved.
//

import UIKit

class UIViewController {
}

class ViewController: UIKit.UIViewController, UITableViewDataSource {
    
    @IBOutlet var chargeTextField : UITextField!
    @IBOutlet var taxPctSlider : UISlider!
    @IBOutlet var taxPctLabel : UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    let tipCalc = TipCalculatorModel(charge: 33.25, taxPct: 0.06)
    var possibleTips = Dictionary<Int, (tipAmt: Double, finalTotal: Double)>()
    var sortedKeys:[Int] = []
    
    
    func refreshUI() {
        chargeTextField.text = String(format: "%0.2f", tipCalc.charge)
        taxPctSlider.value = Float(tipCalc.taxPct) * 100.0
        taxPctLabel.text = "Tax Percentage (\(Int(taxPctSlider.value))%)"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        refreshUI()
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func calculateTapped(sender: AnyObject) {
        tipCalc.charge = Double((chargeTextField.text as NSString).doubleValue)
        possibleTips = tipCalc.returnPossibleTips()
        sortedKeys = sorted(Array(possibleTips.keys))
        tableView.reloadData()
    }
    @IBAction func taxPercentageChanged(sender : AnyObject) {
        tipCalc.taxPct = Double(taxPctSlider.value) / 100.0
        refreshUI()
    }
    @IBAction func viewTapped(sender : AnyObject) {
        chargeTextField.resignFirstResponder()
    }

}

