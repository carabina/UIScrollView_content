//
//  MarkerViewCell.swift
//  ScrollViewContent
//
//  Created by 홍창남 on 2018. 1. 12..
//  Copyright © 2018년 Seong ho Hong. All rights reserved.
//

import UIKit

open class MarkerViewCell: UIView {

    open lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()

        titleLabel.center = self.center
        titleLabel.textAlignment = .center
        titleLabel.textColor = UIColor.white
        titleLabel.font.withSize(20)

        return titleLabel
    }()

    open var audioContentView: AudioContentView = {
        return AudioContentView()
    }()

    open var videoContentView: VideoContentView = {
        return VideoContentView()
    }()

    open var textContentView: TextContentView = {
        return TextContentView()
    }()

    var imageView: UIImageView?
    
    var isSelected: Bool = false
    var destinationRect = CGRect()

    weak var delegate: MarkerViewCellDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
        setupGestureRecognizers()
        setupDestinationRect(origin: .zero, zoomScale: 0.0)
    }

    convenience init(marker: MarkerType) {
        self.init(frame: .zero)

        self.configureMarkerViewCell(marker: marker)
    }

//    convenience init(origin: CGPoint, zoomScale: CGFloat) {
//        self.init(frame: frame)
//        setupDestinationRect(origin: origin, zoomScale: zoomScale)
//    }

    open func setupSubviews() {
        self.addSubview(titleLabel)
        self.addSubview(audioContentView)
        self.addSubview(videoContentView)
        self.addSubview(textContentView)
    }

    func setupGestureRecognizers() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didSelectMarker(_:)))
        self.addGestureRecognizer(tapGesture)
    }

    func setupDestinationRect(origin: CGPoint, zoomScale: CGFloat) {

        if let delegate = delegate {
            destinationRect.size.width = delegate.delegateScrollView.frame.width/zoomScale
            destinationRect.size.height = delegate.delegateScrollView.frame.height/zoomScale
        } else {
            destinationRect.size = CGSize.zero
        }

        destinationRect.origin.x = origin.x - destinationRect.size.width/2
        destinationRect.origin.y = origin.y - destinationRect.size.height/2
    }

    func configureMarkerViewCell(marker: MarkerType) {

        guard let contentCheckDict = marker.existContent else { return }

        for (key, value) in contentCheckDict {
            if value {
                switch key {
                case "isTitleContent":
                    self.titleLabel.text = marker.title
                    self.titleLabel.sizeToFit()
                    self.titleLabel.isHidden = false
                    self.titleLabel.center = (self.superview?.center)!
                case "isAudioContent":
                    if let audioURL = marker.audioURL {
                        self.audioContentView.setAudio(url: audioURL)
                        self.audioContentView.isHidden = false
                    }
                case "isVideoContent":
                    if let videoURL = marker.videoURL {
                        self.videoContentView.setVideo(url: videoURL)
                        self.videoContentView.isHidden = false
                    }
                case "isTextContent":
                    self.textContentView.labelSet(title: marker.textTitle, link: marker.textLink, text: marker.textContent)
                    self.textContentView.isHidden = false
                default: break
                }
            }
        }
    }

    func hideContent() {
        self.titleLabel.isHidden = true
        self.audioContentView.isHidden = true
        self.videoContentView.isHidden = true
        self.textContentView.isHidden = true

        videoContentView.pauseVideo()
        audioContentView.stopAudio()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
//        fatalError("init(coder:) has not been implemented")
    }
}

extension MarkerViewCell {
    @objc func didSelectMarker(_ gestureRecognizer: UITapGestureRecognizer) {

    }
}


