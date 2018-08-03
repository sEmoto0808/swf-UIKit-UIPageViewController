//
//  AutoPageViewController.swift
//  swf-UIKit-UIPageViewController-demo
//
//  Created by S.Emoto on 2018/08/04.
//  Copyright © 2018年 S.Emoto. All rights reserved.
//

import UIKit

class AutoPageViewController: UIPageViewController {

    // UIPageViewControllerで表示するUIViewControllerのリスト
    private var contentVCList = [ContentViewController]()
    // 表示しているUIViewControllerの番号
    private var currentPageNum:Int = 0
    // 3秒毎に切り替えるタイマー
    private var pagingTimer:Timer!
    
    // MARK : - Factory
    class func create() -> AutoPageViewController {
        
        if let vc = UIStoryboard(name: "AutoPageViewController", bundle: nil)
            .instantiateViewController(withIdentifier: "AutoPageViewController") as? AutoPageViewController {
            return vc
        }
        fatalError("unwap AutoPageViewController")
    }
    
    // MARK : - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        startTimer()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        stopTimer()
    }
}

// MARK: - File Extension
extension AutoPageViewController {
    
    private func setup() {
        
        createContentVCList()
        setViewControllers([getFirst()],
                           direction: .forward,
                           animated: true,
                           completion: nil)
    }
    
    // リストを生成
    private func createContentVCList() {
        for i in 0..<3 {
            let contentVC = ContentViewController.create()
            contentVC.screenType = ScreenType(rawValue: i)
            contentVCList.append(contentVC)
        }
    }
    
    // 一番目のコンテンツVCを取得
    private func getFirst() -> ContentViewController {
        currentPageNum = 0
        return contentVCList[0]
    }
    
    // タイマーStart
    private func startTimer() {
        self.pagingTimer = Timer.scheduledTimer(timeInterval: 3,
                                                target: self,
                                                selector: #selector(forward),
                                                userInfo: nil,
                                                repeats: true)
    }
    
    // タイマーStop
    private func stopTimer() {
        if pagingTimer.isValid {
            pagingTimer.invalidate()
        }
    }
    
    // 次のcontentVCを表示する
    @objc private func forward() {
        if currentPageNum < contentVCList.count - 1 {
            currentPageNum += 1
        } else {
            currentPageNum = 0
        }
        setViewControllers([contentVCList[currentPageNum]],
                           direction: .forward,
                           animated: true,
                           completion: nil)
    }
}

