//
//  ASSnapScaleView.swift
//  YYProject
//
//  Created by 章凯华 on 2018/11/7.
//  Copyright © 2018 章凯华. All rights reserved.
//

import UIKit

class ASZoomImageView: UIScrollView, UIScrollViewDelegate {
    private let imageView = UIImageView()
    
    var image:UIImage? {
        set {
            self.imageView.image = newValue
            if newValue != nil {
                self.setupView()
            }
        }
        
        get {
            return self.imageView.image
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        if #available(iOS 11.0, *) {
            contentInsetAdjustmentBehavior = .never
        }
        showsVerticalScrollIndicator = false
        showsHorizontalScrollIndicator = false
        alwaysBounceVertical = true
        alwaysBounceHorizontal = true
        
        self.delegate = self
        self.addSubview(imageView)
        
        let doubleTap = UITapGestureRecognizer.init(target: self, action: #selector(resetZoomingView))
        doubleTap.numberOfTapsRequired = 2
        self.addGestureRecognizer(doubleTap)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// 调整当前 View 到初始状态
    func setupView() {
        imageView.frame.size = self.resetImageViewSize()
        contentSize = imageView.frame.size
        self.setupContentInset()
    }
    
    func setupContentInset() {
        let imageViewSize = imageView.frame.size
        let scrollViewSize = self.bounds.size
        let verticalInset = imageViewSize.height < scrollViewSize.height ? (scrollViewSize.height - imageViewSize.height) / 2 : 0
        let horizontalInset = imageViewSize.width < scrollViewSize.width ? (scrollViewSize.width - imageViewSize.width) / 2 : 0
        self.contentInset = UIEdgeInsets(top: verticalInset, left: horizontalInset, bottom: verticalInset, right: horizontalInset)
    }
    
    /// 计算默认的图片尺寸
    ///
    /// - Returns: 默认的出图片尺寸，盛满整个屏幕
    func resetImageViewSize() -> CGSize {
        guard let currentImage:UIImage = imageView.image else {
            return CGSize.zero
        }
        
        let widthScale = frame.size.width / currentImage.size.width
        let heightScale = frame.size.height / currentImage.size.height
        let minScale = min(widthScale, heightScale)
        let targetSize = CGSize(width: minScale * currentImage.size.width,
                                height: minScale * currentImage.size.height)
        minimumZoomScale = minScale
        zoomScale = minScale
        return targetSize

    }
    
    public func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        self.setupContentInset()
    }
}


extension ASZoomImageView {
    @objc
    func resetZoomingView() {
        UIView.animate(withDuration: 0.3) {
            self.setupView()
        }
    }
}
