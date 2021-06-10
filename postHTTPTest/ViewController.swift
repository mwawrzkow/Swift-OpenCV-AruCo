//
//  ViewController.swift
//  postHTTPTest
//
//  Created by Marcin Wawrzków on 08/04/2021.
//

import UIKit
class ViewController: UIViewController {
    @IBAction func onClick(_ sender: UIButton) {
        let story = UIStoryboard(name: "Main",bundle:nil)
        let controller = story.instantiateViewController(identifier: "onlogged") as! onLogged
        let navigation = UINavigationController(rootViewController: controller)
        self.view.addSubview(navigation.view)
        self.addChild(navigation)
        navigation.didMove(toParent: self)
    }
    @IBAction func onClickCamera(_ sender: Any) {
        let story = UIStoryboard(name: "Main",bundle:nil)
        let controller = story.instantiateViewController(identifier: "arucoCamera") as! ArucoCameraDetection
        let navigation = UINavigationController(rootViewController: controller)
        self.view.addSubview(navigation.view)
        self.addChild(navigation)
        navigation.didMove(toParent: self)
    }
}

