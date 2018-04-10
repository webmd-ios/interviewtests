//
//  TableViewController.swift
//  AutomationTestApp
//
//  Created by McHargue, Brandon on 4/6/18.
//  Copyright © 2018 WebMD. All rights reserved.
//

import UIKit

class TableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    public var selectedOption : String?;
    @IBOutlet weak var tableView: UITableView!;
    let tableData = ["Option 1", "Option 2", "Option 3", "Option 4", "Option 5"];
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.delegate = self;
        self.tableView.dataSource = self;
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell");
        cell.textLabel?.text = tableData[indexPath.row];
        return cell;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let value = tableData[indexPath.row];
        self.selectedOption = value;
        self.performSegue(withIdentifier: "unwindToFirstView", sender: self);
    }
    
}
