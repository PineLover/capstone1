//
//  DetailViewController.swift
//  capstone1
//
//  Created by 하승익 on 08/05/2019.
//  Copyright © 2019 하승익. All rights reserved.
//

import UIKit
import SwiftSocket

//show informations of application, each stock's graph,datas
class DetailViewController: UIViewController {

    let host = "127.0.0.1"
    let port = 8080
    var client: TCPClient?
    
    // This variable will hold the data being passed from the First View Controller
    var receivedData = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        client = TCPClient(address: host, port: Int32(port))
        
        title = receivedData
        print(receivedData)        
    }
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var stockTitle: UITextField!
    
    @IBOutlet weak var textView: UITextView!
    @IBAction func sendButtonAction(_ sender: UIButton) {
        print("button cliked")
        
        guard let client = client else { return }

        switch client.connect(timeout: 10) {
        case .success:
            print("success")
            appendToTextField(string: "Connected to host \(client.address)")
            if let response = sendRequest(string: "GET / HTTP/1.0\n\n", using: client) {
                appendToTextField(string: "Response: \(response)")
            }
        case .failure(let error):
            print("fail")
            appendToTextField(string: String(describing: error))
        }
    }
    

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    private func sendRequest(string: String, using client: TCPClient) -> String? {
        appendToTextField(string: "Sending data ... ")
        
        switch client.send(string: string) {
        case .success:
            return readResponse(from: client)
        case .failure(let error):
            appendToTextField(string: String(describing: error))
            return nil
        }
    }
    
    private func readResponse(from client: TCPClient) -> String? {
        guard let response = client.read(1024*10) else { return nil }
        
        return String(bytes: response, encoding: .utf8)
    }
    
    private func appendToTextField(string: String) {
        print(string)
        textView.text = textView.text.appending("\n\(string)")
    }

}
