//
//  ContentViewController.swift
//  swf-UIKit-UIPageViewController-demo
//
//  Created by S.Emoto on 2018/08/04.
//  Copyright © 2018年 S.Emoto. All rights reserved.
//

import UIKit

// MARK : - コンテンツの種類
enum ScreenType:Int {
    case first
    case second
    case third
}

class ContentViewController: UIViewController {

    @IBOutlet weak var screenNameLabel: UILabel!
    
    var screenType:ScreenType!
    var pageIndex:Int = 0
    
    //MARK : - Factorys
    class func create() -> ContentViewController {
        
        if let vc = UIStoryboard(name: "ContentViewController", bundle: nil)
            .instantiateViewController(withIdentifier: "ContentViewController") as? ContentViewController {
            return vc
        }
        fatalError("unwap ContentViewController")
    }
    
    // MARK : - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }
}

extension ContentViewController {
    
    private func setup() {
        switch self.screenType {
        case .first:
            do {
                self.view.backgroundColor = UIColor.red
                screenNameLabel.text = "First ViewController"
            }
            break
        case .second:
            do {
                self.view.backgroundColor = UIColor.blue
                screenNameLabel.text = "Second ViewController"
            }
            break
        case .third:
            do {
                self.view.backgroundColor = UIColor.green
                screenNameLabel.text = "Third ViewController"
            }
            break
        default:
            break
        }
    }
}
