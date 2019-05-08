//
//  DetailViewController.swift
//  capstone1
//
//  Created by 하승익 on 08/05/2019.
//  Copyright © 2019 하승익. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var stockTitle: UITextField!
    
    // This variable will hold the data being passed from the First View Controller
    var receivedData = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = receivedData
        print(receivedData)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
