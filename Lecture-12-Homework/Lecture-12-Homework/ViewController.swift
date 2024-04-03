//
//  ViewController.swift
//  Lecture-12-Homework
//
//  Created by Barbare Tepnadze on 03.04.24.
//
//  📱 გატესტილია iPhone 15 სიმულატორში, გათვლილია iOS 17-ზე

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var switchTask: UISwitch!
    @IBOutlet weak var taskLabel: UILabel!
    @IBOutlet weak var number1: UITextField!
    @IBOutlet weak var number2: UITextField!
    @IBOutlet weak var calculateBtn: UIButton!
    @IBOutlet weak var resultLabel: UILabel!
    
    // თემატური ცვლადები (თავდაპირველი მნიშვნელობების კოდში გაწერა ვამჯობინე)
    let initTaskTitle = "უმცირესი საერთო ჯერადი"
    let initBtnTitle = "იპოვე უსჯ"
    let gcdThemeColor = UIColor.systemIndigo
    let lcmThemeColor = UIColor.systemOrange
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }
    
    // View-ს მეთოდები
    func initView() {
        loadLCMView()
        calculateBtn.sizeToFit()
        switchTask.onTintColor = gcdThemeColor
        switchTask.tintColor = lcmThemeColor
        switchTask.subviews[0].subviews[0].backgroundColor = lcmThemeColor
        number1.placeholder = "შეიყვანე პირველი რიცხვი"
        number2.placeholder = "შეიყვანე მეორე რიცხვი"
    }
    
    func loadGCDView() {
        taskLabel.text = "უდიდესი საერთო გამყოფი"
        calculateBtn.setTitle("იპოვე უსგ", for: .normal)
        calculateBtn.tintColor = gcdThemeColor
    }
    
    func loadLCMView() {
        taskLabel.text = initTaskTitle
        calculateBtn.setTitle(initBtnTitle, for: .normal)
        calculateBtn.tintColor = lcmThemeColor
    }

    // Action მეთოდები
    @IBAction func changeTask(_ sender: UISwitch) {
        if sender.isOn {
            loadGCDView()
        } else {
            loadLCMView()
        }
    }
    
    @IBAction func calculateResult(_ sender: UIButton) {
        guard let num1txt = number1.text,
              let num2txt = number2.text,
        let num1 = Int(num1txt),
        let num2 = Int(num2txt)
        else {
            resultLabel.textColor = .systemRed
            resultLabel.text = "ფორმატი არასწორია"
            return
        }
        
        let result = switchTask.isOn ? findGCD(num1, num2) : findLCM(num1, num2)
        
        resultLabel.text = "პასუხი: \(result)"
        resultLabel.textColor = .systemGreen
    }
    
    func findGCD(_ num1: Int, _ num2: Int) -> Int {
        let r = num1 % num2
        if r != 0 {
            return findGCD(num2, r)
        } else {
            return num2
        }
    }
    
    func findLCM(_ num1: Int, _ num2: Int) -> Int {
        return num1 * num2 / findGCD(num1, num2)
    }
}

