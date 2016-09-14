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
    
    var appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
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
        
        do {
            try fetchedResultsController.performFetch()
        } catch {
            print("An error occurred")
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
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
