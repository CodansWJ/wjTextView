//
//  ViewController.swift
//  wjTextViewDemo
//
//  Created by 汪俊 on 16/8/4.
//  Copyright © 2016年 Codans. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var textView:WJTextView!
    var backAttributeString:NSAttributedString!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        textView = WJTextView(frame: CGRectMake(15, 64, UIScreen.mainScreen().bounds.width - 30, UIScreen.mainScreen().bounds.height - 64))
        textView.addPlaceHold("这是占位符~")
        self.view.addSubview(textView)
    }

    @IBAction func getAttributeString(sender: AnyObject) {
        // 获取内容attributeString对象
        backAttributeString = textView.getAttributeStringFromTextView()
        print(backAttributeString)
        // 获取图片数组
        let pictrueArray = textView.getPicturesArray()
        print(pictrueArray)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

