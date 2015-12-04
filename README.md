# UA-Eats
We can use this README file to share ideas and collaborate

Here is a nice link relating to what we are dealing with. It show us how to make different tab views.
http://code.tutsplus.com/tutorials/exploring-tab-bar-controller--mobile-14063



//
//  FirstViewController.swift
//  UA Eats
//
//  Created by Cameron Reilly on 11/5/15.
//  Copyright © 2015 Cameron Reilly. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UITableViewDataSource , UITableViewDelegate{

    @IBOutlet weak var swipesTable: UITableView?
    var data: Dictionary<String, Dictionary<String, String>>?
    var count = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        swipesTable?.dataSource = self
        swipesTable?.delegate = self
         data = {
            guard let path = NSBundle.mainBundle().pathForResource("swipes", ofType: "plist") else {
                fatalError("Invalid path for plist")
            }
            return NSDictionary(contentsOfFile: path) as? Dictionary<String, Dictionary <String, String>>
            }()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (data?.count)!
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) ->   UITableViewCell {
        let cell = UITableViewCell()
        let screenSize: CGRect = UIScreen.mainScreen().bounds
        let label = UILabel(frame: CGRect(x:0, y:0, width:screenSize.width, height:50))
        let index = data?.startIndex.advancedBy(count)
        let str = data?[(data?.keys[index!])!]?["name"]

        label.text = str //"Hello Man"
        if count > (data?.count)! - 2{
            count = 0
        }
        else{
            count++
        }
        label.textAlignment = .Center
        //swipesTable?.separatorInset.right = 200
        cell.addSubview(label)
        return cell
    }
    
    
    // UITableViewDelegate Functions
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //CODE TO BE RUN ON CELL TOUCH
        let work = (data?.keys[(data?.startIndex.advancedBy(indexPath.indexAtPosition(1)))!])!
        print(data?[work]?["address"])
        let name = data?[work]?["name"]
        let hours = data?[work]?["hours"]
        let address = data?[work]?["address"]
        let description = data?[work]?["description"]
        
        
        // create the alert
        let alert = UIAlertController(title: "\(name!)", message:
            "Hours:\n\(hours!)\n\nPhone:\n\nAddress:\n\(address!)\n\nDescrpition:\n\(description!)",
            preferredStyle: UIAlertControllerStyle.Alert)
        
        // add the actions (buttons)
        let settingsAction = UIAlertAction(title: "To Website", style: .Default) { (_) -> Void in
            UIApplication.sharedApplication().openURL(NSURL(string: "http://www.google.com")!)
        }
        alert.addAction(settingsAction)
        
        alert.addAction(UIAlertAction(title: "Close", style: UIAlertActionStyle.Cancel, handler: nil))
        
        // show the alert
        self.presentViewController(alert, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

