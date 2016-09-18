//
//  AddViewController.swift
//  SimpleTodo
//
//  Created by kenjou yutaka on 2016/08/17.
//  Copyright © 2016年 yutaka kenjo. All rights reserved.
//

import UIKit
import CoreData

class AddViewController: UIViewController ,UITextViewDelegate{
    
    @IBOutlet weak var textView: UITextView!
    
    @IBOutlet weak var returnSwitch: UISwitch!
    @IBOutlet weak var textCountLabel: UILabel!
    
    var swtichBool :Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let kbToolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 44))
        kbToolBar.barStyle = UIBarStyle.Default
        //kbToolBar.sizeToFit()
        
        let cancelButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Stop, target: self, action: #selector(AddViewController.pushCancelButton))
        let spacer = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: self, action: nil)
        let saveButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Save, target: self, action: #selector(AddViewController.pushSaveButton))
        
        kbToolBar.items = [cancelButton,spacer,saveButton]
        
        textView.inputAccessoryView = kbToolBar
        
        textView.layer.borderWidth = 0.5
        textView.layer.cornerRadius = 3
        textView.layer.borderColor = UIColor.lightGrayColor().CGColor
        
        textView.becomeFirstResponder()
        textView.delegate = self
        
        textCountLabel.text = "0"
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textViewDidChange(textView: UITextView) {
        textCountLabel.text = String(textView.text.characters.count)
    }
    
    func textViewDidEndEditing(textView: UITextView) {
        textCountLabel.text = String(textView.text.characters.count)
    }
    
    private func setItemData(text:String){
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let fetchRequest = NSFetchRequest(entityName: "Item")
        var count: NSInteger? = nil
        do {
            count = try appDelegate.managedObjectContext.countForFetchRequest(fetchRequest)
        } catch let error as NSError? {
            print(error)
        }
        
        if text.containsString("\n") && swtichBool == true {
            let textArray = text.componentsSeparatedByString("\n")
            
            for i in 0..<textArray.count {
                let item = NSEntityDescription.insertNewObjectForEntityForName("Item", inManagedObjectContext: appDelegate.managedObjectContext) as! Item
                item.text = textArray[i]
                item.displayOrder = count! + i
                item.checked = 0
                
                
                let fetchRequestLog = NSFetchRequest(entityName: "Log")
                let precidateLog = NSPredicate(format: "text LIKE %@", textArray[i])
                fetchRequestLog.predicate = precidateLog
                var logCount: NSInteger? = nil
                do {
                    logCount = try appDelegate.managedObjectContext.countForFetchRequest(fetchRequestLog)
                } catch let error as NSError? {
                    print(error)
                }
                
                //カウントが0ならLogに現在日時と共に追加する
                if logCount == 0 {
                    let log = NSEntityDescription.insertNewObjectForEntityForName("Log", inManagedObjectContext: appDelegate.managedObjectContext) as! Log
                    log.text = textArray[i]
                    let now = NSDate()
                    log.time = now
                } else {
                    //既に存在している場合は日時だけ更新
                    do {
                        let logs = try appDelegate.managedObjectContext.executeFetchRequest(fetchRequestLog) as! [Log]
                        let now = NSDate()
                        logs[0].time = now
                    } catch {
                        print("error")
                    }
                }
            }
        } else {
            let item = NSEntityDescription.insertNewObjectForEntityForName("Item", inManagedObjectContext: appDelegate.managedObjectContext) as! Item
            item.text = text
            item.displayOrder = count
            item.checked = 0
            
            //log check
            let fetchRequestLog = NSFetchRequest(entityName: "Log")
            let precidateLog = NSPredicate(format: "text LIKE %@", text)
            fetchRequestLog.predicate = precidateLog
            var logCount: NSInteger? = nil
            do {
                logCount = try appDelegate.managedObjectContext.countForFetchRequest(fetchRequestLog)
            } catch let error as NSError? {
                print(error)
            }
            
            
            //カウントが0ならLogに現在日時と共に追加する
            
            if logCount == 0 {
                let log = NSEntityDescription.insertNewObjectForEntityForName("Log", inManagedObjectContext: appDelegate.managedObjectContext) as! Log
                log.text = text
                let now = NSDate()
                log.time = now
            } else {
                //既に存在している場合は日時だけ更新
                do {
                    let logs = try appDelegate.managedObjectContext.executeFetchRequest(fetchRequestLog) as! [Log]
                    let now = NSDate()
                    logs[0].time = now
                } catch {
                    print("error")
                }
            }
            
        }
        
        appDelegate.saveContext()
    }

    @IBAction func switchChange(sender: UISwitch) {
        if sender.on {
            swtichBool = true
        } else {
            swtichBool = false
        }
    }
    
    func pushCancelButton(){
        if textView.text != "" {
            let textDestruction:String = NSLocalizedString("textDestruction", comment: "テキスト破棄")
            let textDestConfirm:String = NSLocalizedString("textDestConfirm", comment: "テキスト破棄確認テキスト")
            let allowtextDestruction:String = NSLocalizedString("allowtextDestruction", comment: "破棄する")
            let notDestruction:String = NSLocalizedString("notDestruction", comment: "破棄しない")
            
            
            let actionSheet : UIAlertController = UIAlertController(title: textDestruction, message: textDestConfirm, preferredStyle: UIAlertControllerStyle.ActionSheet)
            
            let okAction : UIAlertAction = UIAlertAction(title: allowtextDestruction, style: UIAlertActionStyle.Default, handler:{
                (action: UIAlertAction!) -> Void in
                self.textView.resignFirstResponder()
                self.dismissViewControllerAnimated(true, completion: nil)
                }
            )
            
            let cancelAction : UIAlertAction = UIAlertAction(title: notDestruction, style: UIAlertActionStyle.Cancel, handler:{
                (action: UIAlertAction!) -> Void in
                
                }
            )
            
            actionSheet.addAction(okAction)
            actionSheet.addAction(cancelAction)
            
            presentViewController(actionSheet, animated: true, completion: nil)
        } else {
            self.textView.resignFirstResponder()
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        
    }
    
    func pushSaveButton(){
        let textViewString = textView.text.stringByTrimmingCharactersInSet(NSCharacterSet.newlineCharacterSet())
        if textViewString != "" {
            setItemData(textViewString)
            textView.resignFirstResponder()
            self.dismissViewControllerAnimated(true, completion: nil)
        }
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
