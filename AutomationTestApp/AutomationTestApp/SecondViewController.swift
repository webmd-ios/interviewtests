//
//  SecondViewController.swift
//  AutomationTestApp
//
//  Created by McHargue, Brandon on 4/6/18.
//  Copyright © 2018 WebMD. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.refreshLabel();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func segmentedControlValueChanged(_ sender: Any) {
        self.refreshLabel();
    }
    
    @IBAction func textFieldChanged(_ sender: Any) {
        self.refreshLabel();
    }
    
    func refreshLabel(){
        let labelText : String;
        if(self.segmentedControl.selectedSegmentIndex == 0){
            labelText = "'\(self.textField.text ?? "")'"
        }else{
            let reversedString = String((self.textField.text ?? "").reversed());
            labelText = "'\(reversedString)'"
        }
        self.label.text = labelText;
    }
}

