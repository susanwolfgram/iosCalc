//
//  ViewController.swift
//  iosCalculator
//
//  Created by Susan Wolfgram on 10/20/15.
//  Copyright © 2015 Susan Wolfgram. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var numStack = [Double]()
    var op = ""
    var result = 0.0
    var lastPressed = true
    var numString = ""
    
    @IBOutlet weak var display: UITextField!

    func basicOperation() {
        let num2 = numStack.removeLast()
        let num1 = numStack.removeLast()
        
        switch op {
            case "+":
                result = num1 + num2
            case "-":
                result = num1 - num2
            case "*":
                result = num1 * num2
            case "/":
                result = num1 / num2
            case "%":
                result = num1 % num2
            default :
                result = 0.0
        }
    }
    
    func multi() {
        let count = Double(numStack.count)
        var sum = 0.0
        for num in numStack {
            sum += num
        }
        if op == "Count" {
            result = count
        } else {
            result = sum / count
        }
    }
    
    func factorial() {
        var num = numStack.removeLast()
        var total = 1.0
        while num > 1 {
            num--
            total += total * num
            
        }
        result = total
    }
    
    func convert(incoming:String) -> Double {
        return NSNumberFormatter().numberFromString(incoming)!.doubleValue
    }
    
    @IBAction func buttonPressed(sender: UIButton) {
        NSLog(sender.titleLabel!.text!)
        if lastPressed {
            display.text = numString + sender.titleLabel!.text!
                //display.text! + sender.titleLabel!.text!
            //numStack.append(convert(display.text! + sender.titleLabel!.text!))
        } else {
            display.text = sender.titleLabel!.text!
            //numStack.append(convert(sender.titleLabel!.text!))
        }
        numString = numString + sender.titleLabel!.text!
        lastPressed = true
    }
    
    @IBAction func equals(sender: UIButton) {
        if lastPressed {
            numStack.append(convert(numString))
            numString = ""
        }
        switch op {
            case "+", "-", "*", "/", "%":
                basicOperation()
            case "Count", "Avg":
                multi()
            default:
                factorial()
        }
        display.text = "\(result)"
    }
    
    
    @IBAction func oper(sender: UIButton) {
        numStack.append(convert(numString))
        numString = ""
        op = sender.titleLabel!.text!
        lastPressed = false
        display.text = op
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

