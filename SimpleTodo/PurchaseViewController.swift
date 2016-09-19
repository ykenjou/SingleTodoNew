//
//  PurchaseViewController.swift
//  SimpleTodo
//
//  Created by kenjou yutaka on 2016/08/28.
//  Copyright © 2016年 yutaka kenjo. All rights reserved.
//

import UIKit
import StoreKit

class PurchaseViewController: UIViewController ,XXXPurchaseManagerDelegate {
    
    @IBOutlet weak var purchaseButton: UIButton!
    
    @IBOutlet weak var restoreButton: UIButton!
    
    @IBOutlet weak var statusLabel: UILabel!
    
    var buttonActivityView: UIActivityIndicatorView!
    
    var purchaseActivityView: UIActivityIndicatorView!
    
    let userDefaults = NSUserDefaults.standardUserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        purchaseButton.layer.borderWidth = 1
        purchaseButton.layer.borderColor = UIColor.redColor().CGColor
        purchaseButton.layer.cornerRadius = 10
        purchaseButton.setTitleColor(UIColor.redColor(), forState: .Normal)
        purchaseButton.setTitleColor(UIColor.redColor(), forState: .Highlighted)
        
        buttonActivityView = UIActivityIndicatorView()
        //buttonActivityView.center = CGPointMake(purchaseButton.bounds.size.width / 2, purchaseButton.bounds.size.height / 2)
        buttonActivityView.center = CGPointMake(60, 22)
        buttonActivityView.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
        purchaseButton.addSubview(buttonActivityView)
        buttonActivityView.startAnimating()
        
        purchaseActivityView = UIActivityIndicatorView()
        purchaseActivityView.center = CGPointMake(self.view.bounds.size.width / 2, self.view.bounds.size.height / 2)
        purchaseActivityView.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
        purchaseActivityView.startAnimating()
        
        //プロダクトID達
        let productIdentifiers = ["com.kdevelop.SingleTodoList.upgrade"]
        
        //プロダクト情報取得
        XXXProductManager.productsWithProductIdentifiers(productIdentifiers, completion: { (products : [SKProduct]!, error : NSError?) -> Void in
                for product in products {
                    //価格を抽出
                    let priceString = XXXProductManager.priceStringFromProduct(product)
                    /*価格情報を使って表示を更新したり。*/
                    self.buttonActivityView.stopAnimating()
                    self.buttonActivityView.removeFromSuperview()
                    self.purchaseButton.setTitle(priceString, forState: .Normal)
                    
                }
        })
        
        buttonStatusChange()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func buttonStatusChange(){
        if userDefaults.boolForKey("upgrade") {
            let purchasedStatus:String = NSLocalizedString("purchasedStatus", comment: "購入済みです")
            statusLabel.text = purchasedStatus
            purchaseButton.enabled = false
            purchaseButton.alpha = 0.3
            restoreButton.enabled = false
            restoreButton.alpha = 0.8
        } else {
            statusLabel.text = ""
            purchaseButton.enabled = true
            purchaseButton.alpha = 1.0
            restoreButton.enabled = true
            restoreButton.alpha = 1.0
        }
    }
    
    @IBAction func pushPurchaseButton(sender: UIButton) {
        self.startPurchase("com.kdevelop.SingleTodoList.upgrade")
        self.view.addSubview(purchaseActivityView)
        purchaseButton.enabled = false
        purchaseButton.alpha = 0.3
    }

    @IBAction func pushRestoreButton(sender: UIButton) {
        self.startRestore()
        self.view.addSubview(purchaseActivityView)
        restoreButton.enabled = false
        restoreButton.alpha = 0.8
    }
    
    func startPurchase(productIdentifier : String) {
        //デリゲード設定
        XXXPurchaseManager.sharedManager().delegate = self
        
        //プロダクト情報を取得
        XXXProductManager.productsWithProductIdentifiers([productIdentifier], completion: { (products, error) -> Void in
            if products.count > 0 {
                
                //課金処理開始
                XXXPurchaseManager.sharedManager().startWithProduct(products[0])
                
            }
        })
    }
    
    /// リストア開始
    func startRestore() {
        //デリゲード設定
        XXXPurchaseManager.sharedManager().delegate = self
        
        //リストア開始
        XXXPurchaseManager.sharedManager().startRestore()
    }
    
    
    // MARK: - XXXPurchaseManager Delegate
    func purchaseManager(purchaseManager: XXXPurchaseManager!, didFinishPurchaseWithTransaction transaction: SKPaymentTransaction!, decisionHandler: ((complete: Bool) -> Void)!) {
        //課金終了時に呼び出される
        /*

         コンテンツ解放処理

         */
        userDefaults.setBool(true, forKey: "upgrade")
        
        let purchaseFinish:String = NSLocalizedString("purchaseFinish", comment: "購入完了")
        let okText:String = NSLocalizedString("ok", comment: "ok")
        
        let ac = UIAlertController(title: purchaseFinish, message: nil, preferredStyle: .Alert)
        ac.addAction(UIAlertAction(title: okText, style: .Default, handler: nil))
        self.presentViewController(ac, animated: true, completion: nil)
        
        buttonStatusChange()
        purchaseActivityView.removeFromSuperview()
        
        //コンテンツ解放が終了したら、この処理を実行(true: 課金処理全部完了, false 課金処理中断)
        decisionHandler(complete: true)
    }
    
    func purchaseManager(purchaseManager: XXXPurchaseManager!, didFinishUntreatedPurchaseWithTransaction transaction: SKPaymentTransaction!, decisionHandler: ((complete: Bool) -> Void)!) {
        //課金終了時に呼び出される(startPurchaseで指定したプロダクトID以外のものが課金された時。)
        /*

         コンテンツ解放処理

         */
        userDefaults.setBool(true, forKey: "upgrade")
        
        let purchaseFinish:String = NSLocalizedString("purchaseFinish", comment: "購入完了")
        let okText:String = NSLocalizedString("ok", comment: "ok")
        
        let ac = UIAlertController(title: purchaseFinish, message: nil, preferredStyle: .Alert)
        ac.addAction(UIAlertAction(title: okText, style: .Default, handler: nil))
        self.presentViewController(ac, animated: true, completion: nil)
        
        buttonStatusChange()
        purchaseActivityView.removeFromSuperview()
        
        //コンテンツ解放が終了したら、この処理を実行(true: 課金処理全部完了, false 課金処理中断)
        decisionHandler(complete: true)
    }
    
    func purchaseManager(purchaseManager: XXXPurchaseManager!, didFailWithError error: NSError!) {
        //課金失敗時に呼び出される
        /*

         errorを使ってアラート表示

         */
        purchaseActivityView.removeFromSuperview()
        buttonStatusChange()
        
        let purchaseFail:String = NSLocalizedString("purchaseFail", comment: "購入失敗")
        let okText:String = NSLocalizedString("ok", comment: "ok")
        
        let ac = UIAlertController(title: purchaseFail, message: error.localizedDescription, preferredStyle: .Alert)
        ac.addAction(UIAlertAction(title: okText, style: .Default, handler: nil))
        self.presentViewController(ac, animated: true, completion: nil)
    }
    
    func purchaseManagerDidFinishRestore(purchaseManager: XXXPurchaseManager!) {
        //リストア終了時に呼び出される(個々のトランザクションは”課金終了”で処理)
        /*

         インジケータなどを表示していたら非表示に

         */
        
        purchaseActivityView.removeFromSuperview()
        buttonStatusChange()
        
        /*
        let ac = UIAlertController(title: "restore finish!", message: nil, preferredStyle: .Alert)
        ac.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
        self.presentViewController(ac, animated: true, completion: nil)
        */
    }
    
    func purchaseManagerDidDeferred(purchaseManager: XXXPurchaseManager!) {
        //承認待ち状態時に呼び出される(ファミリー共有)
        /* 

         インジケータなどを表示していたら非表示に

         */
        purchaseActivityView.removeFromSuperview()
        buttonStatusChange()
        
        let purcaseDefferd:String = NSLocalizedString("purcaseDefferd", comment: "購入待機")
        let okText:String = NSLocalizedString("ok", comment: "ok")
        
        
        let ac = UIAlertController(title: purcaseDefferd, message: nil, preferredStyle: .Alert)
        ac.addAction(UIAlertAction(title: okText, style: .Default, handler: nil))
        self.presentViewController(ac, animated: true, completion: nil)
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
