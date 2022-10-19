//
//  ViewController.swift
//  UnitTest
//
//  Created by 小坂部泰成 on 2022/10/18.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    //文字数制限メソッドを切り出し
    func saveRecord(with text: Int) -> Bool {
        let tweetTextCount = text
        let maxTweetLength = 140
        if tweetTextCount > maxTweetLength {
            return true
        } else {
            return false
        }
        
        
    }
    
}

