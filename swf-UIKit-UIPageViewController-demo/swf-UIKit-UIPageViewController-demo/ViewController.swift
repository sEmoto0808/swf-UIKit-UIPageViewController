//
//  ViewController.swift
//  swf-UIKit-UIPageViewController-demo
//
//  Created by S.Emoto on 2018/08/04.
//  Copyright © 2018年 S.Emoto. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func didTapManual(_ sender: Any) {
        let manualPageVC = ManualPageViewController.create()
        self.navigationController?.pushViewController(manualPageVC, animated: true)
    }
    
    @IBAction func didTapAuto(_ sender: Any) {
        let autoPageVC = AutoPageViewController.create()
        self.navigationController?.pushViewController(autoPageVC, animated: true)
    }
    
}

