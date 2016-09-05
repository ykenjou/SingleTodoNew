//
//  ColorViewController.swift
//  SimpleTodo
//
//  Created by kenjou yutaka on 2016/09/01.
//  Copyright © 2016年 yutaka kenjo. All rights reserved.
//

import UIKit

class ColorViewController: UIViewController {

    @IBOutlet weak var blueButton: UIButton!
    @IBOutlet weak var redButton: UIButton!
    @IBOutlet weak var greenButton: UIButton!
    @IBOutlet weak var orangeButton: UIButton!
    @IBOutlet weak var purpleButton: UIButton!
    @IBOutlet weak var lightgrayButton: UIButton!
    @IBOutlet weak var darkgrayButton: UIButton!
    
    let blueColor:UIColor = UIColor(red: 28 / 255, green: 67 / 255, blue: 155 / 255, alpha: 1.0)
    let redColor:UIColor = UIColor(red: 198 / 255, green: 40 / 255, blue: 40 / 255, alpha: 1.0)
    let greenColor:UIColor = UIColor(red: 24 / 255, green: 118 / 255, blue: 59 / 255, alpha: 1.0)
    let orangeColor:UIColor = UIColor(red: 255 / 255, green: 138 / 255, blue: 51 / 255, alpha: 1.0)
    let purpleColor:UIColor = UIColor(red: 146 / 255, green: 66 / 255, blue: 139 / 255, alpha: 1.0)
    let lightGrayColor:UIColor = UIColor(red: 150 / 255, green: 150 / 255, blue: 150 / 255, alpha: 1.0)
    let darkGrayColor:UIColor = UIColor(red: 37 / 255, green: 37 / 255, blue: 37 / 255, alpha: 1.0)
    
    var colorStoryboard :UIStoryboard? = nil
    var mainViewController :UIViewController? = nil
    
    let userDefaults = NSUserDefaults.standardUserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        colorStoryboard = UIStoryboard(name: "Main", bundle: nil)
        mainViewController = colorStoryboard!.instantiateViewControllerWithIdentifier("MainViewController") as! MainViewController
        
        
        blueButton.backgroundColor = blueColor
        blueButton.layer.cornerRadius = 10
        
        redButton.backgroundColor = redColor
        redButton.layer.cornerRadius = 10
        
        greenButton.backgroundColor = greenColor
        greenButton.layer.cornerRadius = 10
        
        orangeButton.backgroundColor = orangeColor
        orangeButton.layer.cornerRadius = 10
        
        purpleButton.backgroundColor = purpleColor
        purpleButton.layer.cornerRadius = 10
        
        lightgrayButton.backgroundColor = lightGrayColor
        lightgrayButton.layer.cornerRadius = 10
        
        darkgrayButton.backgroundColor = darkGrayColor
        darkgrayButton.layer.cornerRadius = 10
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func pushBlueButton(sender: UIButton) {
        navigationController!.navigationBar.barTintColor = blueColor
        userDefaults.setObject("blue", forKey: "color")
    }
    
    @IBAction func pushRedButton(sender: UIButton) {
        navigationController!.navigationBar.barTintColor = redColor
        userDefaults.setObject("red", forKey: "color")
    }
    
    @IBAction func pushGreenButton(sender: UIButton) {
        navigationController!.navigationBar.barTintColor = greenColor
        userDefaults.setObject("green", forKey: "color")
    }
    
    @IBAction func pushOrangeButton(sender: UIButton) {
        navigationController!.navigationBar.barTintColor = orangeColor
        userDefaults.setObject("orange", forKey: "color")
    }
    
    @IBAction func pushPurpleButton(sender: UIButton) {
        navigationController!.navigationBar.barTintColor = purpleColor
        userDefaults.setObject("purple", forKey: "color")
    }
    
    @IBAction func pushLightgrayButton(sender: UIButton) {
        navigationController!.navigationBar.barTintColor = lightGrayColor
        userDefaults.setObject("lightgray", forKey: "color")
    }
    
    @IBAction func pushDarkgrayButton(sender: UIButton) {
        navigationController!.navigationBar.barTintColor = darkGrayColor
        userDefaults.setObject("darkgray", forKey: "color")
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
