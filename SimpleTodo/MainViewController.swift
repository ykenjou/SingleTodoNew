//
//  MainViewController.swift
//  SimpleTodo
//
//  Created by kenjou yutaka on 2016/08/17.
//  Copyright © 2016年 yutaka kenjo. All rights reserved.
//

import UIKit
import CoreData
import AudioToolbox
import GoogleMobileAds
import Accounts

class MainViewController:  UIViewController , UITableViewDataSource , UITableViewDelegate , NSFetchedResultsControllerDelegate , UIGestureRecognizerDelegate ,UINavigationControllerDelegate , GADBannerViewDelegate{
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btmToolBar: UIToolbar!
    @IBOutlet weak var popMessageView: UIView!
    
    var appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    let userDefaults = NSUserDefaults.standardUserDefaults()
    
    let gadController = GadController()
    var bannerView:GADBannerView? = nil
    
    var addActivityView: UIActivityIndicatorView!
    
    @IBOutlet weak var btmToolBarConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var tableBtmConstraint: NSLayoutConstraint!
    
    lazy var fetchedResultsController: NSFetchedResultsController = {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let fetchRequest = NSFetchRequest(entityName: "Item")
        let sortDescripter = NSSortDescriptor(key: "displayOrder", ascending: true)
        fetchRequest.sortDescriptors = [sortDescripter]
        
        let frc = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: appDelegate.managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        frc.delegate = self
        
        return frc
    }()
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        tableView.estimatedRowHeight = 44;
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.tableFooterView = UIView()
        
        let trashButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Trash, target: self, action: #selector(MainViewController.pushTrashButton))
        let spacer = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: self, action: nil)
        //let addButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: #selector(MainViewController.pushAddButton))
        let add2Button = UIBarButtonItem()
        add2Button.image = UIImage(named: "plusRadiusIcon.png")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
        add2Button.style = UIBarButtonItemStyle.Plain
        add2Button.action = #selector(MainViewController.pushAddButton)
        add2Button.target = self
        let editButton = editButtonItem()
        
        btmToolBar.items = [trashButton,spacer,add2Button,spacer,editButton]
        
        // Do any additional setup after loading the view.
        do {
            try fetchedResultsController.performFetch()
        } catch {
            print("An error occurred")
        }
        
        //通知設定
        let settings = UIUserNotificationSettings(forTypes: UIUserNotificationType.Badge, categories: nil)
        UIApplication.sharedApplication().registerUserNotificationSettings(settings)
        
        if userDefaults.boolForKey("badge") {
            UIApplication.sharedApplication().applicationIconBadgeNumber = setBadgeValue()
        } else {
            UIApplication.sharedApplication().applicationIconBadgeNumber = -1
        }
        
        navigationController!.navigationBar.tintColor = UIColor.whiteColor()
        navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        navigationController!.navigationBar.translucent = false
        
        btmToolBar.tintColor = UIColor.whiteColor()
        btmToolBar.translucent = false
        
        //セル長押し設定
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(MainViewController.cellLongPressed(_:)))
        longPressRecognizer.delegate = self
        tableView.addGestureRecognizer(longPressRecognizer)
        
        if userDefaults.boolForKey("firstLaunch") {
            let firstData:String = NSLocalizedString("firstData", comment: "1番目のデータ")
            let secondData:String = NSLocalizedString("secondData", comment: "2番目のデータ")
            let thirdData:String = NSLocalizedString("thirdData", comment: "3番目のデータ")
            let fourthData:String = NSLocalizedString("fourthData", comment: "4番目のデータ")
            setFirstItemData(firstData, checked: 0)
            setFirstItemData(secondData, checked: 1)
            setFirstItemData(thirdData, checked: 0)
            setFirstItemData(fourthData, checked: 0)
            userDefaults.setBool(false, forKey: "firstLaunch")
        }
        
        bannerView = gadController.gadBannerInit(self.view.frame.width, frameHeight: 50, viewController: self)
        
        popMessageView.layer.cornerRadius = 10
        
        
        addActivityView = UIActivityIndicatorView()
        addActivityView.center = CGPointMake(self.view.bounds.size.width / 2, self.view.bounds.size.height / 2)
        addActivityView.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
        addActivityView.startAnimating()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        setNaviToolbarColor()
        tableView.reloadData()
        
        bannerView!.frame.origin = CGPointMake(0, self.view.frame.height - 94)
        
        
        if userDefaults.boolForKey("upgrade") {
            
            bannerView!.removeFromSuperview()
            
            //btmToolBarConstraint.constant = 0
            tableBtmConstraint.constant = 1
            
        } else {
            
            self.view.addSubview(bannerView!)
            
            //btmToolBarConstraint.constant = 50
            tableBtmConstraint.constant = 50
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController)
    {
        //tableView.reloadData()
        
        if userDefaults.boolForKey("badge") {
            UIApplication.sharedApplication().applicationIconBadgeNumber = setBadgeValue()
        } else {
            UIApplication.sharedApplication().applicationIconBadgeNumber = -1
        }
    }
    
    internal func setNaviToolbarColor(){
        let color:String = userDefaults.stringForKey("color")!
        let colorViewController = ColorViewController()
        switch color {
        case "blue":
            navigationController!.navigationBar.barTintColor = colorViewController.blueColor
            btmToolBar.barTintColor = colorViewController.blueColor
        case "deepblue":
            navigationController!.navigationBar.barTintColor = colorViewController.deepBlueColor
            btmToolBar.barTintColor = colorViewController.deepBlueColor
        case "red":
            navigationController!.navigationBar.barTintColor = colorViewController.redColor
            btmToolBar.barTintColor = colorViewController.redColor
        case "green":
            navigationController!.navigationBar.barTintColor = colorViewController.greenColor
            btmToolBar.barTintColor = colorViewController.greenColor
        case "orange":
            navigationController!.navigationBar.barTintColor = colorViewController.orangeColor
            btmToolBar.barTintColor = colorViewController.orangeColor
        case "purple":
            navigationController!.navigationBar.barTintColor = colorViewController.purpleColor
            btmToolBar.barTintColor = colorViewController.purpleColor
        case "lightgray":
            navigationController!.navigationBar.barTintColor = colorViewController.lightGrayColor
            btmToolBar.barTintColor = colorViewController.lightGrayColor
        case "darkgray":
            navigationController!.navigationBar.barTintColor = colorViewController.darkGrayColor
            btmToolBar.barTintColor = colorViewController.darkGrayColor
        default:
            navigationController!.navigationBar.barTintColor = colorViewController.blueColor
            btmToolBar.barTintColor = colorViewController.blueColor
            
        }
    }
    
    internal func setBadgeValue() -> NSInteger{
        let fetchRequest = NSFetchRequest(entityName: "Item")
        let precidate = NSPredicate(format: "checked == %d", 0)
        fetchRequest.predicate = precidate
        
        var items : NSArray?
        
        do {
            items = try appDelegate.managedObjectContext.executeFetchRequest(fetchRequest) as! [Item]
            
        } catch let error as NSError {
            print(error)
        }
        
        return (items?.count)!
    }
    
    @IBAction func settingButton(sender: UIBarButtonItem) {
        
    }
    
    func cellLongPressed(recognizer: UILongPressGestureRecognizer){
        if tableView.editing == false {
            let point = recognizer.locationInView(tableView)
            let indexPath = tableView.indexPathForRowAtPoint(point)
            if recognizer.state == UIGestureRecognizerState.Began{
                let item = self.fetchedResultsController.objectAtIndexPath(indexPath!) as! Item
                self.appDelegate.itemText = item.text
                self.appDelegate.displayOrder = item.displayOrder
                
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let editViewController = storyboard.instantiateViewControllerWithIdentifier("EditViewController") as! EditViewController
                
                self.presentViewController(editViewController as UIViewController, animated: true, completion: nil)
            }
        }
    }
    
    func showPopMessageView(){
        popMessageView.fadeIn(.Normal)
        let delay = 1 * Double(NSEC_PER_SEC)
        let time  = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
        dispatch_after(time, dispatch_get_main_queue(), {
            self.popMessageView.fadeOut(.Normal)
        })
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        if let sections = fetchedResultsController.sections{
            
            return sections.count
        }
        
        return 0;
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let sections = fetchedResultsController.sections {
            let currentSection = sections[section]
            
            return currentSection.numberOfObjects
        }
        
        return 0;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
        
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        
        let item = fetchedResultsController.objectAtIndexPath(indexPath) as! Item
        let label : UILabel? = cell.contentView.viewWithTag(1) as? UILabel
        
        label?.text = item.text
        let fontSize :CGFloat = CGFloat(userDefaults.floatForKey("fontSize"))
        label?.font = UIFont.systemFontOfSize(fontSize)
        
        if item.checked == 1 {
            tableView.selectRowAtIndexPath(indexPath, animated: false, scrollPosition: UITableViewScrollPosition.None)
            let attributeString : NSMutableAttributedString = NSMutableAttributedString(string: (label?.text)!)
            attributeString.addAttribute(NSStrikethroughStyleAttributeName, value: 2, range: NSMakeRange(0, attributeString.length))
            attributeString.addAttribute(NSForegroundColorAttributeName, value: UIColor.grayColor(), range: NSMakeRange(0, attributeString.length))
            label?.attributedText = attributeString
        }
        
        cell.frame = cell.bounds
        cell.contentView.autoresizingMask = [.FlexibleWidth,.FlexibleHeight]
        
        return cell
    }
    
    
    //セル選択
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        
        let label : UILabel? = cell!.contentView.viewWithTag(1) as? UILabel
        
        let attributeString : NSMutableAttributedString = NSMutableAttributedString(string: (label?.text)!)
        attributeString.addAttribute(NSStrikethroughStyleAttributeName, value: 2, range: NSMakeRange(0, attributeString.length))
        attributeString.addAttribute(NSForegroundColorAttributeName, value: UIColor.grayColor(), range: NSMakeRange(0, attributeString.length))
        label?.attributedText = attributeString
        
        self.setCheckedValue(1, indexPath: indexPath)
        
        if userDefaults.boolForKey("sound") {
            AudioServicesPlaySystemSound(1104)
        }
        
    }
    
    //選択解除
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        let label : UILabel? = cell!.contentView.viewWithTag(1) as? UILabel
        
        let attributeString : NSMutableAttributedString = NSMutableAttributedString(string: (label?.text)!)
        attributeString.addAttribute(NSStrikethroughStyleAttributeName, value: 0, range: NSMakeRange(0, attributeString.length))
        attributeString.addAttribute(NSForegroundColorAttributeName, value: UIColor.blackColor(), range: NSMakeRange(0, attributeString.length))
        label?.attributedText = attributeString
        
        setCheckedValue(0, indexPath: indexPath)
        
        if userDefaults.boolForKey("sound") {
            AudioServicesPlaySystemSound(1104)
        }
        
    }
    
    func setCheckedValue(value:NSNumber, indexPath:NSIndexPath){
        //let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        let manageObject: NSManagedObject = fetchedResultsController.objectAtIndexPath(indexPath) as! NSManagedObject
        manageObject.setValue(value, forKey: "checked")
        
        do{
            try appDelegate.managedObjectContext.save()
        } catch {
            print("do not saved")
        }
        
    }
    
    //スワイプアクション
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        let editTitle:String = NSLocalizedString("editTitle", comment: "editタイトル")
        let editAction = UITableViewRowAction(style: .Normal,title: editTitle){(action, indexPath) in
            
            let item = self.fetchedResultsController.objectAtIndexPath(indexPath) as! Item
            self.appDelegate.itemText = item.text
            self.appDelegate.displayOrder = item.displayOrder
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let editViewController = storyboard.instantiateViewControllerWithIdentifier("EditViewController") as! EditViewController
            
            dispatch_async(dispatch_get_main_queue(), {
                self.presentViewController(editViewController as UIViewController, animated: true, completion: nil)
            })
            
        }
        editAction.backgroundColor = UIColor.orangeColor()
        
        let copyTitle:String = NSLocalizedString("copyTitle", comment: "copyタイトル")
        let copyAction = UITableViewRowAction(style: .Normal,title: copyTitle){(action, indexPath) in
            let cell = tableView.cellForRowAtIndexPath(indexPath)
            let label : UILabel? = cell!.contentView.viewWithTag(1) as? UILabel
            
            let board = UIPasteboard.generalPasteboard()
            board.setValue((label?.text)!, forPasteboardType: "public.text")
            
            self.showPopMessageView()
        }
        copyAction.backgroundColor = UIColor.grayColor()
        
        let shareTitle:String = NSLocalizedString("shareTitle", comment: "shareタイトル")
        let shareAction = UITableViewRowAction(style: .Normal,title: shareTitle){(action, indexPath) in
            let cell = tableView.cellForRowAtIndexPath(indexPath)
            let label : UILabel? = cell!.contentView.viewWithTag(1) as? UILabel
            
            let shareText = label?.text as! AnyObject
            let activityItems = [shareText]
            let activityVC = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
            
            self.presentViewController(activityVC, animated: true, completion: nil)
            //for iPad
            activityVC.popoverPresentationController?.sourceRect = CGRectMake(CGRectGetMidX(self.view.bounds), CGRectGetMidY(self.view.bounds),0,0)
            activityVC.popoverPresentationController?.sourceView = self.view
            
        }
        shareAction.backgroundColor = UIColor.orangeColor()
        
        
        return [editAction,copyAction,shareAction]
    }
    
    //追加・削除スタイル制御
    /*
     func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
     return UITableViewCellEditingStyle.None
     }
     */
    
    //並べ替え
    func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
        let sourceIndex: NSInteger = sourceIndexPath.row
        let toIndex: NSInteger = destinationIndexPath.row
        
        
        if sourceIndex == toIndex {
            return
        }
        
        
        let affectedItem = fetchedResultsController.objectAtIndexPath(sourceIndexPath) as! Item
        
        affectedItem.displayOrder = toIndex
        
        let start:NSInteger
        let end:NSInteger
        let delta:NSInteger
        
        if sourceIndex < toIndex {
            delta = -1
            start = sourceIndex + 1
            end = toIndex
        } else {
            delta = 1
            start = toIndex
            end = sourceIndex - 1
        }
        
        for i in start..<end + 1 {
            let fetchIndexPath = NSIndexPath(forRow: i, inSection: 0)
            let item = fetchedResultsController.objectAtIndexPath(fetchIndexPath) as! Item
            item.displayOrder = i + delta
        }
        
        appDelegate.saveContext()
        
        
        
    }
    
    
    //編集ボタン
    /*
     @IBAction func editButton(sender: UIBarButtonItem) {
     if editing {
     super.setEditing(false, animated: true)
     tableView.setEditing(false, animated: true)
     } else {
     super.setEditing(true, animated: true)
     tableView.setEditing(true, animated: true)
     }
     }
     */
    
    func pushTrashButton(){
        let list = tableView.indexPathsForSelectedRows
        
        if list?.count != nil {
            
            
            //let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            let fetchRequest = NSFetchRequest(entityName: "Item")
            let precidate = NSPredicate(format: "checked == %d", 1)
            fetchRequest.predicate = precidate
            
            do {
                let items = try appDelegate.managedObjectContext.executeFetchRequest(fetchRequest) as! [Item]
                for item in items {
                    appDelegate.managedObjectContext.deleteObject(item)
                }
            } catch let error as NSError {
                print(error)
            }
            
            appDelegate.saveContext()
            
            
            //displayOrderの再設定
            let fetchRequestOrder = NSFetchRequest(entityName: "Item")
            let sortDescripter = NSSortDescriptor(key: "displayOrder", ascending: true)
            fetchRequestOrder.sortDescriptors = [sortDescripter]
            
            do {
                let itemsOrder = try appDelegate.managedObjectContext.executeFetchRequest(fetchRequestOrder) as! [Item]
                for i in 0..<itemsOrder.count {
                    itemsOrder[i].displayOrder = i
                }
            } catch let error as NSError {
                print(error)
            }
            
            appDelegate.saveContext()
            tableView.reloadData()
            
        }
        
    }
    
    func pushAddButton(){
        
        if UIDevice.currentDevice().userInterfaceIdiom == .Pad{
            self.view.addSubview(addActivityView)
        }
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let addViewController = storyboard.instantiateViewControllerWithIdentifier("AddViewController") as! AddViewController
        
        
        
        dispatch_async(dispatch_get_main_queue()) {
            self.presentViewController(addViewController as UIViewController, animated: true, completion: self.deleteAddActivityView)
        }
    }
    
    func deleteAddActivityView(){
        if UIDevice.currentDevice().userInterfaceIdiom == .Pad{
            addActivityView.removeFromSuperview()
        }
    }
    
    private func setFirstItemData(text:String,checked:NSNumber){
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let fetchRequest = NSFetchRequest(entityName: "Item")
        //var error: NSError? = nil
        var count: NSInteger? = nil
        do {
            count = try appDelegate.managedObjectContext.countForFetchRequest(fetchRequest)
        } catch let error as NSError? {
            print(error)
        }
        //let count = appDelegate.managedObjectContext.countForFetchRequest(fetchRequest)
        
        let item = NSEntityDescription.insertNewObjectForEntityForName("Item", inManagedObjectContext: appDelegate.managedObjectContext) as! Item
        item.text = text
        item.displayOrder = count
        item.checked = checked
        
        appDelegate.saveContext()
    }
    
    
    override func setEditing(editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        tableView.setEditing(editing, animated: true)
        tableView.editing = editing
    }
    
    @IBAction func pushMemoButton(sender: UIBarButtonItem) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let logViewController = storyboard.instantiateViewControllerWithIdentifier("LogViewController") as! LogViewController
        dispatch_async(dispatch_get_main_queue()) {
            self.presentViewController(logViewController as UIViewController, animated: true, completion: nil)
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

enum FadeType: NSTimeInterval {
    case
    Normal = 0.2,
    Slow = 1.0
}

extension UIView {
    func fadeIn(type: FadeType = .Normal, completed: (() -> ())? = nil) {
        fadeIn(type.rawValue, completed: completed)
    }
    
    /** For typical purpose, use "public func fadeIn(type: FadeType = .Normal, completed: (() -> ())? = nil)" instead of this */
    func fadeIn(duration: NSTimeInterval = FadeType.Slow.rawValue, completed: (() -> ())? = nil) {
        alpha = 0
        hidden = false
        UIView.animateWithDuration(duration,
                                   animations: {
                                    self.alpha = 0.95
        }) { finished in
            completed?()
        }
    }
    func fadeOut(type: FadeType = .Normal, completed: (() -> ())? = nil) {
        fadeOut(type.rawValue, completed: completed)
    }
    /** For typical purpose, use "public func fadeOut(type: FadeType = .Normal, completed: (() -> ())? = nil)" instead of this */
    func fadeOut(duration: NSTimeInterval = FadeType.Slow.rawValue, completed: (() -> ())? = nil) {
        UIView.animateWithDuration(duration
            , animations: {
                self.alpha = 0
        }) { [weak self] finished in
            self?.hidden = true
            self?.alpha = 0.95
            completed?()
        }
    }
}
