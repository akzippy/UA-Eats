//
//  DataViewController.swift
//  CleanUp
//
//  Created by Cameron Reilly on 11/4/15.
//  Copyright © 2015 Cameron Reilly. All rights reserved.
//

import UIKit

class DataViewController: UIViewController {

    @IBOutlet weak var dataLabel: UILabel?
    var dataObject: String = ""

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.dataLabel?.text = dataObject
    }


}

