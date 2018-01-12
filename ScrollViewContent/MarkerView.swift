//
//  MarkerView.swift
//  ScrollViewMarker
//
//  Created by Seong ho Hong on 2018. 1. 1..
//  Copyright © 2018년 Seong ho Hong. All rights reserved.
//

import UIKit
//
//class MarkerV: UIView {
//    weak var markerViewDataSource: MarkerViewDataSource?
//    weak var markerViewDelegate: MarkerViewDelegate?
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//    }
//
//    convenience init() {
//        self.init(frame: .zero)
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    func numberOfItems() {
//
//    }
//
//    func indexPathForItem() {
//
//    }
//}
//
//public class MarkerView: UIView {
//
//    var origin: CGPoint?
//    var zoomScale = CGFloat()
//    var imageView: UIImageView?
//
//    private var markerTapGestureRecognizer = UITapGestureRecognizer()
//
//    func set(dataSource: MarkerDataSource, origin: CGPoint, zoomScale: CGFloat, existContent: [String: Bool]) {
//        // marker 위치 설정후 scrollview에 추가
//        self.dataSource = dataSource
//        self.origin = origin
//        self.zoomScale = zoomScale
//
//        dataSource.scrollView.addSubview(self)
//
//
//        // zoom 했을떄 위치 설정
//        destinationRect.size.width = dataSource.scrollView.frame.width/zoomScale
//        destinationRect.size.height = dataSource.scrollView.frame.height/zoomScale
//        destinationRect.origin.x = x - destinationRect.size.width/2
//        destinationRect.origin.y = y - destinationRect.size.height/2
//
//        // marker tap 설정
//        markerTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(markerViewTap(_:)))
//        markerTapGestureRecognizer.delegate = self
//        self.addGestureRecognizer(markerTapGestureRecognizer)
//
//
//        // content 존재 여부 설정
//        dataSource.marker?.existContent = existContent
//
//    }
//
//    // marker image 설정
//    func setMarkerImage(markerImage: UIImage) {
//        imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height))
//        imageView?.contentMode =  UIViewContentMode.scaleAspectFill
//        imageView?.image = markerImage
//        self.addSubview(imageView!)
//    }
//
//    // 비디오 url 설정
//    func setVideoContent(url: URL) {
//        videoURL = url
//    }
//
//    // 오디오 url 설정
//    func setAudioContent(url: URL) {
//        audioURL = url
//    }
//
//    // title string 설정
//    func setTitle(title: String) {
//        self.title = title
//    }
//
//    // text string 설정
//    func setText(title: String, link: String, content: String) {
//
//        self.textTitle = title
//        self.textLink = link
//        self.textContent = content
//    }
//
//    // 마커 클릭식, contentView set
//    private func markerContentSet(index: Int) {
//
//        if let contents = dataSource?.markerAt(index: index).existContent {
//            for (key, value) in contents {
//                if value {
//                    if let marker = dataSource?.markerAt(index: index) {
//                        switch key {
//                        case "isTitleContent":
//                            dataSource?.delegate.setContent(marker: marker, type: .title)
//                        case "isAudioContent":
//                            dataSource?.delegate.setContent(marker: marker, type: .audio)
//                        case "isVideoContent":
//                            dataSource?.delegate.setContent(marker: marker, type: .video)
//                        case "isTextContent":
//                            dataSource?.delegate.setContent(marker: marker, type: .text)
//                        default:
//                            dataSource?.delegate.setContent(marker: marker, type: .custom)
//                        }
//                    }
//                }
//            }
//        }
//    }
//}

