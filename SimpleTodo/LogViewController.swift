//
//  LogViewController.swift
//  SimpleTodo
//
//  Created by kenjou yutaka on 2016/09/13.
//  Copyright © 2016年 yutaka kenjo. All rights reserved.
//

import UIKit
import CoreData

class LogViewController: UIViewController ,UITableViewDataSource , UITableViewDelegate , NSFetchedResultsControllerDelegate{
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var btmToolbar: UIToolbar!
    
    var appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    @IBOutlet weak var headerView: UIView!
    let userDefaults = NSUserDefaults.standardUserDefaults()
    
    lazy var fetchedResultsController: NSFetchedResultsController = {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let fetchRequest = NSFetchRequest(entityName: "Log")
        let sortDescripter = NSSortDescriptor(key: "time", ascending: false)
        fetchRequest.sortDescriptors = [sortDescripter]
        
        let frc = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: appDelegate.managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        frc.delegate = self
        
        return frc
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        tableView.estimatedRowHeight = 44;
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.tableFooterView = UIView()
        
        navigationBar.translucent = false
        btmToolbar.translucent = false
        
        do {
            try fetchedResultsController.performFetch()
        } catch {
            print("An error occurred")
        }

        let maxLogs:NSInteger = 20
        let fetchRequest = NSFetchRequest(entityName: "Log")
        var logCount: NSInteger? = nil
        do {
            logCount = try appDelegate.managedObjectContext.countForFetchRequest(fetchRequest)
        } catch let error as NSError? {
            print(error)
        }
        
        //データが一定数に達したら、上限以上のアイテムを削除
        if logCount > maxLogs {
            let fetchRequestTime = NSFetchRequest(entityName: "Log")
            let sortDescripter = NSSortDescriptor(key: "time", ascending: false)
            fetchRequestTime.sortDescriptors = [sortDescripter]
            
            do {
                let logs = try appDelegate.managedObjectContext.executeFetchRequest(fetchRequestTime) as! [Log]
                for i in maxLogs..<logCount!{
                    appDelegate.managedObjectContext.deleteObject(logs[i])
                }
            } catch let error as NSError {
                print(error)
            }
            appDelegate.saveContext()
        }

        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
        setNaviToolbarColor()
    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController)
    {
        tableView.reloadData()

    }
    
    func setNaviToolbarColor(){
        let color:String = userDefaults.stringForKey("color")!
        let colorViewController = ColorViewController()
        switch color {
        case "blue":
            navigationBar.barTintColor = colorViewController.blueColor
            btmToolbar.barTintColor = colorViewController.blueColor
            headerView.backgroundColor = colorViewController.blueColor
        case "red":
            navigationBar.barTintColor = colorViewController.redColor
            btmToolbar.barTintColor = colorViewController.redColor
            headerView.backgroundColor = colorViewController.redColor
        case "green":
            navigationBar.barTintColor = colorViewController.greenColor
            btmToolbar.barTintColor = colorViewController.greenColor
            headerView.backgroundColor = colorViewController.greenColor
        case "orange":
            navigationBar.barTintColor = colorViewController.orangeColor
            btmToolbar.barTintColor = colorViewController.orangeColor
            headerView.backgroundColor = colorViewController.orangeColor
        case "purple":
            navigationBar.barTintColor = colorViewController.purpleColor
            btmToolbar.barTintColor = colorViewController.purpleColor
            headerView.backgroundColor = colorViewController.purpleColor
        case "lightgray":
            navigationBar.barTintColor = colorViewController.lightGrayColor
            btmToolbar.barTintColor = colorViewController.lightGrayColor
            headerView.backgroundColor = colorViewController.lightGrayColor
        case "darkgray":
            navigationBar.barTintColor = colorViewController.darkGrayColor
            btmToolbar.barTintColor = colorViewController.darkGrayColor
            headerView.backgroundColor = colorViewController.darkGrayColor
        default:
            navigationBar.barTintColor = colorViewController.blueColor
            btmToolbar.barTintColor = colorViewController.blueColor
            headerView.backgroundColor = colorViewController.blueColor
            
        }
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if let sections = fetchedResultsController.sections{
            
            return sections.count
        }
        return 0
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sections = fetchedResultsController.sections {
            let currentSection = sections[section]
            
            return currentSection.numberOfObjects
        }
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
        
        let log = fetchedResultsController.objectAtIndexPath(indexPath) as! Log
        let label : UILabel? = cell.contentView.viewWithTag(1) as? UILabel
        
        label?.text = log.text
        let fontSize :CGFloat = CGFloat(userDefaults.floatForKey("fontSize"))
        label?.font = UIFont.systemFontOfSize(fontSize)
        
        return cell
    }

    @IBAction func pushCloseButton(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func pushSaveButton(sender: UIBarButtonItem) {
        let pathsArray = tableView.indexPathsForSelectedRows

        if pathsArray?.count > 0 {
            let arrayCount = (pathsArray?.count)! as Int
            for i in 0..<arrayCount{
                let cell = tableView.cellForRowAtIndexPath(pathsArray![i])
                let label = cell?.contentView.viewWithTag(1) as? UILabel
                let text = label?.text
                
                //Itemエンティティにデータを追加
                let fetchRequest = NSFetchRequest(entityName: "Item")
                var count: NSInteger? = nil
                do {
                    count = try appDelegate.managedObjectContext.countForFetchRequest(fetchRequest)
                } catch let error as NSError? {
                    print(error)
                }
                
                let item = NSEntityDescription.insertNewObjectForEntityForName("Item", inManagedObjectContext: appDelegate.managedObjectContext) as! Item
                item.text = text
                item.displayOrder = count! + i
                item.checked = 0
                
                //Logエンティティのdateを更新
                let fetchRequestLog = NSFetchRequest(entityName: "Log")
                let precidateLog = NSPredicate(format: "text LIKE %@", text!)
                fetchRequestLog.predicate = precidateLog
                do {
                    let logs = try appDelegate.managedObjectContext.executeFetchRequest(fetchRequestLog) as! [Log]
                    let now = NSDate()
                    logs[0].time = now
                } catch {
                    print("error")
                }
            }
            
            appDelegate.saveContext()
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
