//
//  ViewController.swift
//  capstone1
//
//  Created by 하승익 on 10/04/2019.
//  Copyright © 2019 하승익. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UITableViewDataSource,UITableViewDelegate, UISearchBarDelegate{
    
    let csvObject = CsvController.init(filename: "/Users/gimdonghwan/Downloads/capstone1/capstone1/allstock_info.csv")

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var stockGraphImage: UIButton!
   
    let mainChart : UIImage = UIImage(named: "mainchart")!
  
    
    var data = ["New York, NY", "Los Angeles, CA", "Chicago, IL", "Houston, TX",
                "Philadelphia, PA", "Phoenix, AZ", "San Diego, CA", "San Antonio, TX",
                "Dallas, TX", "Detroit, MI", "San Jose, CA", "Indianapolis, IN",
                "Jacksonville, FL", "San Francisco, CA", "Columbus, OH", "Austin, TX",
                "Memphis, TN", "Baltimore, MD", "Charlotte, ND", "Fort Worth, TX"]
    
    var filteredData: [String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        searchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        
        data = csvObject.data
        filteredData = data
        
        
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       // print("1")
        return filteredData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       // print("2")
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath) as UITableViewCell
        //print("3")
        cell.textLabel?.text = filteredData[indexPath.row]
        
        return cell
    }
    
   func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){

        filteredData = searchText.isEmpty ? data : data.filter { (item: String) -> Bool in
            return item.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
            }
    
        tableView.reloadData()
    }
    
    ///    Detail view
    
    // ...
    
    
    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         let checklist = filteredData[indexPath.row]
        // Segue to the second view controller
        self.performSegue(withIdentifier: "segueToDetailView", sender: checklist)
    }
    
    // This function is called before the segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // get a reference to the second view controller
        let DetailViewController = segue.destination as! DetailViewController
        // set a variable in the second view controller with the data to pass
        DetailViewController.receivedData = sender as! String
    }
    

}

