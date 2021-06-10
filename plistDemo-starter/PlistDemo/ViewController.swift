//
//  ViewController.swift
//  PlistDemo
//
//  Created by Adriana González Martínez on 2/25/19.
//  Copyright © 2019 Adriana González Martínez. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var table: UITableView!
    var scores : [[String: Any]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.delegate = self
        table.dataSource = self
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
       
        // Get the list of scores coming from your plist
        let scoresPlist = Plist(name: "Scores")
        
        // Add two entries by code
        // Get the Plist as a mutable dictionary
        let mutableScores = scoresPlist?.getMutablePlistFile()
        
        // Isolate the "Scores" array and add entries to it
        let array = mutableScores?["Scores"] as? NSMutableArray
        array?.add(["Name": "Adriana", "Score": "1000"])
        
        // Put it back in the NSMutable dictionary
        mutableScores?["Scores"] = array
        // Write updated dictionary to the Plist file
        do{
            try scoresPlist?.addValuesToPlistFile(dictionary: mutableScores!)
        } catch {
            fatalError("Give up")
        }
        
        // Fetch new version of Plist and populate Scores table with it
        let newData = scoresPlist?.getValuesInPlistFile() as? Dictionary<String,Any?>
        let newScores = newData?["Scores"]
        scores = (newScores as? [[String:String]])!

    }
    
    
    // MARK: Table setup
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scores.count
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Highest Scores 🚀"
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath as IndexPath)
        //TODO: Make sure to display the score and name
        cell.textLabel?.text = "\(scores[indexPath.row]["Name"]!) \(scores[indexPath.row]["Score"]!)"
        return cell
        
    }
    
    //MARK: Plist handling
    //TODO: Keep your file clean by adding helper methods to handle the plist.
    
    
}
