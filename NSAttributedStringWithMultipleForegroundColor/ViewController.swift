//
//  ViewController.swift
//  UILabelWithMultipleFonts
//
//  Created by shlexingyu on 2019/2/12.
//  Copyright © 2019年 NSFish. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        
        let content = " 自营  回力/WARRIOR 轮胎 215/65R16 98H SR1"
        let lineHeight: CGFloat = 24, numberOfLines: CGFloat = 2
        let label = UILabel()
        label.backgroundColor = UIColor.gray
        label.numberOfLines = Int(numberOfLines)
        view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        label.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        let attributedText = NSMutableAttributedString.init(string: content)
        let font = UIFont.systemFont(ofSize: 16)
        let baselineOffset = (lineHeight - font.lineHeight) / 4
        let attributes: [NSAttributedString.Key : Any] = [NSAttributedString.Key.font: font,
                                                          NSAttributedString.Key.foregroundColor: UIColor.black,
                                                          NSAttributedString.Key.baselineOffset: Int(baselineOffset)]
        // problematic: text looks lower
        var prefixAttributes = attributes
        prefixAttributes[NSAttributedString.Key.foregroundColor] = UIColor.white
        attributedText.setAttributes(prefixAttributes, range: NSRange.init(location: 0, length: 5))
        attributedText.setAttributes(attributes, range: NSRange.init(location: 5, length: content.count - 5))
        // works: text in the center
        // attributedText.setAttributes(attributes, range: NSRange.init(location: 0, length: content.count))
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.maximumLineHeight = lineHeight
        paragraphStyle.minimumLineHeight = lineHeight
        attributedText.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSRange.init(location: 0, length: content.count))
        
        label.attributedText = attributedText
    }
}

