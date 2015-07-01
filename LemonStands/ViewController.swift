//
//  ViewController.swift
//  LemonStands
//
//  Created by lapacino on 6/30/15.
//  Copyright (c) 2015 lapacino. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var moneySupply: UILabel!
    @IBOutlet weak var lemonSupply: UILabel!
    @IBOutlet weak var iceCubeSupply: UILabel!
    @IBOutlet weak var lemonPurchase: UILabel!
    @IBOutlet weak var iceCubePurcahse: UILabel!
    @IBOutlet weak var lemonMix: UILabel!
    @IBOutlet weak var iceCubeMix: UILabel!
    
    // Supplies class varibale
    
    var supplies = Supplies(aLemon: 1, aIceCubes: 1, aMoney: 10)
    
    var lemonsToPurchase = 0
    var iceCubesToPurchase = 0
    var lemonsToMix = 0
    var iceCubesToMix = 0
    
    var price = Price()
    
    // weather varible
    
    var weatherArray:[[Int]] = [[-7, -6, -5, -10], [10, 5, 8, 9], [20, 23, 25, 27]]
    var weatherToday:[Int] = [0, 0, 0, 0]
    
    var weatherImageView = UIImageView(frame: CGRectMake(20, 70, 50, 50))
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        self.view.addSubview(weatherImageView)
        updateMainView()
        simulateWeather()


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func purchaseLemonButtonPressed(sender: AnyObject) {
        
        if supplies.money >= price.lemon {
            
            lemonsToPurchase += 1
            supplies.lemons += 1
            supplies.money -= price.lemon
        }
        else{
            showAlertTextView( message: "You don't have enought money")
        }
        
        updateMainView()
        
    }
    @IBAction func purchaseIceCubeButtonPressed(sender: AnyObject) {
        
        if supplies.money >= price.iceCube {
            
            iceCubesToPurchase += 1
            supplies.iceCubes += 1
            supplies.money -= price.iceCube
        }
        else{
            showAlertTextView( message: "You don't have enought money")
        }
        
        updateMainView()
    }
    @IBAction func unPurchaseLemonButtonPressed(sender: AnyObject) {
        if lemonsToPurchase > 0 {
            
            lemonsToPurchase -= 1
            supplies.lemons -= 1
            supplies.money += price.lemon
        }
        else{
            showAlertTextView( message: "You don't have more lemon")
        }
        
        updateMainView()
    }
    @IBAction func unPurchaseIceCubeButtonPressed(sender: AnyObject) {
        
        if iceCubesToPurchase > 0 {
            
            iceCubesToPurchase -= 1
            supplies.iceCubes -= 1
            supplies.money += price.iceCube
        }
        else{
            showAlertTextView( message: "You don't have more iceCubes")
        }
        
        updateMainView()
    }
    @IBAction func mixLemonButtonPressed(sender: AnyObject) {
        
        if supplies.lemons > 0 {
            
            lemonsToMix += 1
            supplies.lemons -= 1
        }
        else{
            showAlertTextView( message: "No more lemon to mix")
        }
        
        updateMainView()
    }
    @IBAction func mixIceCubeButtonPressed(sender: AnyObject) {
       
        if supplies.iceCubes > 0 {
            
            iceCubesToMix += 1
            supplies.iceCubes -= 1
        }
        else{
            showAlertTextView( message: "No more iceCubes to mix")
        }
        
        updateMainView()
    }
    @IBAction func unMixLemonButtonPressed(sender: AnyObject) {
        
        if lemonsToMix > 0 {
            
            lemonsToMix -= 1
            supplies.lemons -= 1
            supplies.money += price.lemon
        }
        else{
            showAlertTextView( message: "No more lemon to unMix")
        }
        
        updateMainView()
    }
    @IBAction func unMixIceCubeButtonPressed(sender: AnyObject) {
        if iceCubesToMix > 0 {
            
            iceCubesToMix -= 1
            supplies.iceCubes -= 1
            supplies.money += price.iceCube
        }
        else{
            showAlertTextView( message: "No more iceCubes to unMix")
        }
        
        updateMainView()
    }
    @IBAction func startDayButtonPressed(sender: AnyObject) {
        
        pplayingGift()
        println(" play times:\(price.playingGift)")
        
        
        let average = findAverage(weatherToday)
        let customer = Int(arc4random_uniform(UInt32(weatherArray.count)))
        println("\(customer)")
        
        let lemonRation:Double = Double(lemonsToMix) / Double(iceCubesToMix)
        let prefrence = Double(Int(arc4random_uniform(UInt32(100)))) / 100
        
        
            if prefrence < 0.4 && lemonRation > 1 {
                
                println("Paid")
                supplies.money += 1
            }
            else if prefrence > 0.7 && lemonRation < 1 {
                println("Paid")
                supplies.money += 1
            }
            else if prefrence < 0.7 && prefrence > 0.4 && lemonRation == 1 {
                
                println("Paid")
                supplies.money += 1
            }
            else{
                println("No match, No pay")
        }
        
         lemonsToPurchase = 0
        iceCubesToPurchase = 0
        lemonsToMix = 0
         iceCubesToMix = 0
        price.playingGift += 1

        simulateWeather()
        updateMainView()
    }
    @IBAction func resetGameButtonPressed(sender: AnyObject) {
       
        
        supplies.lemons += 1
        supplies.iceCubes += 1
         supplies.money += 10
        
        
        lemonsToPurchase = 0
        iceCubesToPurchase = 0
        lemonsToMix = 0
        iceCubesToMix = 0
        
        updateMainView()
    }

    
    func updateMainView() {
        
        moneySupply.text = "\(supplies.money) $"
        lemonSupply.text = "\(supplies.lemons) Lemons"
        iceCubeSupply.text = "\(supplies.iceCubes) IceCubes"
        lemonPurchase.text = "\(lemonsToPurchase)"
        iceCubePurcahse.text = "\(iceCubesToPurchase)"
        lemonMix.text = "\(lemonsToMix)"
        iceCubeMix.text = "\(iceCubesToMix)"
    }
    
    // helper function
    
    func showAlertTextView (header:String = "Warning", message:String ){
        
        var alert = UIAlertController(title: header, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "ok", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func simulateWeather(){
        
        var index = Int(arc4random_uniform(UInt32(weatherArray.count)))
            weatherToday = weatherArray[index]
        
        switch index {
            
        case 0: weatherImageView.image = UIImage(named: "Cold")
        case 1: weatherImageView.image = UIImage (named: "Mild")
        case 2: weatherImageView.image = UIImage(named: "Warm")
        default: weatherImageView.image = UIImage(named: "Warm")
            
        }
    }
    
    func findAverage(data:[Int]) -> Int {
        
        var sum = 0
        for x in data {
            sum += x
        }
        
        let average:Double = Double(sum) / Double(weatherArray.count)
        let rounded:Int = Int(ceil(average))
        
        return rounded
        
    }
    
    func pplayingGift() {
        
        if price.playingGift == 5 {
            supplies.money += 3
            
            price.playingGift = 0

        }
    }


}

























