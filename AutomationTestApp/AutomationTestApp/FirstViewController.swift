//
//  FirstViewController.swift
//  AutomationTestApp
//
//  Created by McHargue, Brandon on 4/6/18.
//  Copyright © 2018 WebMD. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.label.text = "Initial Load";
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.label.text = "Back Button Pressed"
    }
    
    @IBAction func unwindToFirstViewController(segue: UIStoryboardSegue){
        let sourceTableView = segue.source as? TableViewController;
        let option = sourceTableView?.selectedOption;
        self.label.text = "\(option ?? "No Option") selected";
    }
}

