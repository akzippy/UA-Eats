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
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "didRotate:", name: UIDeviceOrientationDidChangeNotification, object: nil)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (data?.count)!
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) ->   UITableViewCell {
        let cell = UITableViewCell()
        let screenSize: CGRect = UIScreen.mainScreen().bounds
        let label = UILabel(frame: CGRect(x:0, y:0, width:screenSize.width, height:50))
        let label2 = UILabel(frame: CGRect(x:0, y:20, width:screenSize.width, height:30))
        label2.font = UIFont(name: label.font.fontName, size: 10)
        label2.text = "Test"
        let index = data?.startIndex.advancedBy(indexPath.indexAtPosition(1))
        let str = data?[(data?.keys[index!])!]?["name"]
        
        label.text = str
        label.textAlignment = .Center
        cell.addSubview(label)
        //cell.addSubview(label2)
        if indexPath.indexAtPosition(1) % 2 == 0{
            cell.backgroundColor = UIColor(
                red:1.0,
                green:1.0,
                blue:0.0,
                alpha:1.0)
        }else{
            cell.backgroundColor = UIColor(
                red:1.0,
                green:1.0,
                blue:0.0,
                alpha:0.25)
        }
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
            "\(address!)\n\n\(description!)",
            preferredStyle: UIAlertControllerStyle.ActionSheet)
        
        // add the actions (buttons)
        let openWebpage = UIAlertAction(title: "To Website", style: .Default) { (_) -> Void in
            UIApplication.sharedApplication().openURL(NSURL(string: "http://www.google.com")!)
        }
        let hoursButton = UIAlertAction(title: "Hours", style: .Default, handler: { (action) -> Void in
            let hours = UIAlertController(title: "\(name!) Hours", message:
                "\(hours!)", preferredStyle: UIAlertControllerStyle.ActionSheet)
            //hours.addAction(UIAlertAction(title: "Close", style: UIAlertActionStyle.Cancel, handler: nil))
            let returnButton = UIAlertAction(title: "Return", style: .Default, handler: { (action) -> Void in
                self.presentViewController(alert, animated: true, completion: nil)
            })
            hours.addAction(returnButton)
            self.presentViewController(hours, animated: true, completion: nil)
        })
        alert.addAction(hoursButton)
        alert.addAction(openWebpage)
        
        alert.addAction(UIAlertAction(title: "Close", style: UIAlertActionStyle.Cancel, handler: nil))
        
        // show the alert
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func didRotate(notification: NSNotification)
    {
        swipesTable!.reloadData()
    }
    
    
}