//
//  ManualPageViewController.swift
//  swf-UIKit-UIPageViewController-demo
//
//  Created by S.Emoto on 2018/08/04.
//  Copyright © 2018年 S.Emoto. All rights reserved.
//

import UIKit

class ManualPageViewController: UIPageViewController {

    // UIPageViewControllerで表示するUIViewControllerのリスト
    private var contentVCList = [ContentViewController]()
    
    // MARK : - Factory
    class func create() -> ManualPageViewController {
        
        if let vc = UIStoryboard(name: "ManualPageViewController", bundle: nil)
            .instantiateViewController(withIdentifier: "ManualPageViewController") as? ManualPageViewController {
            return vc
        }
        fatalError("unwap ManualPageViewController")
    }
    
    // MARK : - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }
}

// MARK: - UIPageViewControllerDataSource
extension ManualPageViewController: UIPageViewControllerDataSource {
    
    // 左スワイプ
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        var index = (viewController as! ContentViewController).screenType!.rawValue
        if index > 0 {
            // ページを１つ前に設定する
            index -= 1
        } else {
            // index <= 0 の場合は最後のページに設定する
            index = contentVCList.count - 1
        }
        
        // 画面を生成する
        let vc = ContentViewController.create()
        vc.screenType = ScreenType(rawValue: index)
        
        return vc
    }
    
    // 右スワイプ
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        var index:Int = (viewController as! ContentViewController).screenType!.rawValue
        if index < contentVCList.count - 1 {
            // ページを１つ後に設定する
            index += 1
        } else {
            // indexがコンテンツ数を超えた場合は最初のページに設定する
            index = 0
        }
        
        // 画面を生成する
        let vc = ContentViewController.create()
        vc.screenType = ScreenType(rawValue: index)
        
        return vc
    }
}

// MARK: - UIPageViewControllerDelegate
extension ManualPageViewController: UIPageViewControllerDelegate {
    // スワイプ完了時
    func pageViewController(_ pageViewController: UIPageViewController,
                            didFinishAnimating finished: Bool,
                            previousViewControllers: [UIViewController],
                            transitionCompleted completed: Bool) {
        
        if let vc = pageViewController.viewControllers?.first as? ContentViewController {
            print(vc.screenType)
        }
    }
}

// MARK: - File Extension
extension ManualPageViewController {
    
    private func setup() {
        self.dataSource = self
        self.delegate = self
        
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
        return contentVCList[0]
    }
}
