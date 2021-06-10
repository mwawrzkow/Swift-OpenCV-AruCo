//
//  onLogged.swift
//  postHTTPTest
//
//  Created by Marcin Wawrzków on 19/05/2021.
//

import UIKit
import CocoaAsyncSocket
class onLogged: UIViewController {
    var speed: Int = 0
    var way: Int = 0
    var direction: Bool = true
    var isSpeedSet: Bool = false;
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func onForwardDown(_ sender: Any) {
        self.speed = 50
        self.direction = true
        self.isSpeedSet = true
        TestConnection()
    }
    @IBAction func onForwardUp(_ sender: UIButton) {
        self.speed = 0
        self.isSpeedSet = false
        TestConnection()

    }
    @IBAction func onBackwardDown(_ sender: Any) {
        self.speed = 50
        self.direction = false
        self.isSpeedSet = true
        TestConnection()

    }
    @IBAction func onBackwardUP(_ sender: UIButton) {
        self.speed = 0
        self.direction = true
        self.isSpeedSet  = false
        TestConnection()
    }
    @IBAction func onLeftDown(_ sender: UIButton) {
        if (!isSpeedSet)
        {
            self.way = 0
        }else{
            self.way = 25
        }
        TestConnection()
    }
    @IBAction func onLeftUp(_ sender: UIButton) {
        self.way = 50
        TestConnection()
    }
    @IBAction func onRightDown(_ sender: Any) {
        if (!isSpeedSet) {
            self.way = 75
        } else
        {
            self.way = 100
        }
        TestConnection()
    }
    
    @IBAction func onRightUp(_ sender: Any) {
        self.way = 50
        TestConnection()
    }
    @objc func TestConnection(){
        let jsonParam = ["id":1,"speed":self.speed,"way":self.way,"direction":self.direction] as [String : Any]
        let url = URL(string: "http://192.168.1.102:8080/post")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let session = URLSession.shared
        do{
            request.httpBody = try JSONSerialization.data(withJSONObject: jsonParam, options: .prettyPrinted)
        }catch let error{
            print(error.localizedDescription)
        }
        let task = session.dataTask(with: request as URLRequest)
        task.resume()
        self.way = 50
        self.direction = true
        self.speed = 0 
    }

    @IBAction func onConnectionRequest(_ sender: UIButton) {
        self.TestConnection()
//        self.TestURLNew()
    }

}
