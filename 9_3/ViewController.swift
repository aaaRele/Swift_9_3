//
//  ViewController.swift
//  9_3
//
//  Created by student on 2018/12/13.
//  Copyright © 2018年 wyf. All rights reserved.
//

import UIKit
class ViewController: UIViewController, UIScrollViewDelegate {
    
    //轮播
    var scroll1: UIScrollView!
    var page: UIPageControl!
    //缩放
    var scroll2: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.view.backgroundColor = UIColor.white
        
        let width = self.view.bounds.width - 20
        let height = width * 0.56
        
        scroll1 = UIScrollView(frame: CGRect(x: 10, y: 100, width: width, height: height))
        //按一页一页的方式滚动
        scroll1.isPagingEnabled = true
        //隐藏水平滚动条
        scroll1.showsHorizontalScrollIndicator = false
        //设置内容大小
        scroll1.contentSize = CGSize(width: width*5, height: height)
        //设置代理
        scroll1.delegate = self
        self.view.addSubview(scroll1)
        
        page = UIPageControl(frame: CGRect(x: 10, y: 100+height, width: width, height: 30))
        //总页数
        page.numberOfPages = 5
        //当前页
        page.currentPage = 0
        //指示器未选中时颜色
        page.pageIndicatorTintColor = UIColor.brown
        //指示器选中时颜色
        page.currentPageIndicatorTintColor = UIColor.red
        //添加事件
        page.addTarget(self, action: #selector(pageChanged(page:)), for: .touchUpInside)
        self.view.addSubview(page)
        
        for i in 1...5 {
            let image = UIImage(named: "\(i)")
            let imageView = UIImageView(frame: CGRect(x: width*CGFloat(i-1), y: 0, width: width, height: height))
            imageView.image = image
            imageView.contentMode = .scaleAspectFill
            scroll1.addSubview(imageView)
        }
        
        scroll2 = UIScrollView(frame: CGRect(x: 10, y: 200+height, width: width, height: height))
        scroll2.backgroundColor = UIColor.yellow
        scroll2.contentSize = CGSize(width: width, height: height)
        //最大缩放比例
        scroll2.maximumZoomScale = 10
        //最小缩放比例
        scroll2.minimumZoomScale = 0.1
        scroll2.delegate = self
        self.view.addSubview(scroll2)
        
        let image = UIImage(named: "6")
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: width, height: height))
        imageView.contentMode = .scaleAspectFill
        imageView.image = image
        scroll2.addSubview(imageView)
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentPage = Int(scrollView.contentOffset.x / (self.view.bounds.width - 20))
        page.currentPage = currentPage
    }
    
    @objc func pageChanged(page: UIPageControl) {
        let rect = CGRect(x: scroll1.bounds.width*CGFloat(page.currentPage), y: 0, width: scroll1.bounds.width, height: scroll1.bounds.height)
        scroll1.scrollRectToVisible(rect, animated: true)
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return scroll2.subviews.first
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


