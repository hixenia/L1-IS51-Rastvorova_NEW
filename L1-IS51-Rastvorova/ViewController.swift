//
//  ViewController.swift
//  L1-IS51-Rastvorova
//
//  Created by Kseniia Rastvorova on 4/10/18.
//  Copyright © 2018 Kseniia Rastvorova. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    // MARK: IBOutlets
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var openListButton: UIButton!
    @IBOutlet weak var popupView: UIView!
    @IBOutlet weak var popupViewHeight: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var okButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    // MARK: Variable
    var listString = [String]()
    var activeCell = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Filling an array of display values
        
        for value in 1..<101 {
            if value == 1 {
                listString.append("\(value) year")
            } else {
                listString.append("\(value) years")
            }
        }

        // Adjusting UI
        popupView.alpha = 0.0
        popupView.layer.borderColor = UIColor(red: 103.0/255.0, green: 154.0/255.0, blue: 177.0/255.0, alpha: 1.0).cgColor
        popupView.layer.borderWidth = 1.0
        popupView.layer.cornerRadius = 22.0
        popupView.clipsToBounds = true
        
        openListButton.layer.cornerRadius = 22.0
        okButton.layer.cornerRadius = 22.0
        cancelButton.layer.cornerRadius = 22.0
        popupViewHeight.constant = 60.0 + 44.0 * 4.0
    }
    
    func closeList() {
        openListButton.setTitle("Open list", for: .normal)
        popupView.alpha = 0.0
        openListButton.alpha = 1.0
    }
    
    func showList() {
        openListButton.setTitle("Close list", for: .normal)
        popupView.alpha = 1.0
        openListButton.alpha = 0.0
    }

    // MARK: IBActions
    
    @IBAction func openListButtonPressed(_ sender: Any) {
        if popupView.alpha == 0.0 {
            showList()
        } else {
            closeList()
        }
    }
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        closeList()
    }
    
    @IBAction func okButtonPressed(_ sender: Any) {
        if activeCell != -1, activeCell < listString.count {
            valueLabel.text = "I am \(listString[activeCell]) old!"
        }
        
        closeList()
    }
    
    // MARK: UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listString.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") {
            cell.textLabel?.text = listString[indexPath.row]
            cell.accessoryType = .none
            
            if activeCell == indexPath.row {
                cell.accessoryType = .checkmark
            }
            
            return cell
        }
        
        return UITableViewCell()
    }
    
    // MARK: UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        activeCell = indexPath.row
        tableView.deselectRow(at: indexPath, animated: true)
        tableView.reloadData()
    }
}

