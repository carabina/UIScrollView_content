//
//  MyController.swift
//  ScrollViewContent
//
//  Created by 홍창남 on 2018. 1. 12..
//  Copyright © 2018년 Seong ho Hong. All rights reserved.
//

import UIKit

class MyViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var markerView: MarkerViewCell!

    var dataSource: MarkerViewCellDataSource? = ExampleDataSource()
    var delegate: MarkerViewCellDelegate?

    // MARK: Editor
    var centerPoint = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.contentInsetAdjustmentBehavior = .never
        imageView.frame.size = (imageView.image?.size)!
        scrollView.delegate = self
        
        self.delegate = self

        
        setZoomParametersForSize(scrollView.bounds.size)
        recenterImage()
    }
//
//    func setDataSource() {
//
//        marker.setAudioContent(url: audioURL as! URL)
//        marker.setVideoContent(url: videoURL as! URL)
//        marker.setTitle(title: markerTitle as! String)
//        marker.setText(title: "", link: link as! String, content: text as! String)
//        marker.setMarkerImage(markerImage: #imageLiteral(resourceName: "page"))
//    }

    func editorSet() {

        // edit center point 설정
        centerPoint.frame = CGRect(x: view.frame.width/2, y: view.frame.height/2 + scrollView.frame.origin.y/2, width: CGFloat(10), height: CGFloat(10))
        centerPoint.backgroundColor = UIColor.red
        centerPoint.layer.cornerRadius = 5

        self.view.addSubview(centerPoint)
        centerPoint.isHidden = true
//        doneButton.isHidden = true
    }
}

extension MyViewController: MarkerViewCellDelegate {
    var delegateScrollView: UIScrollView {
        return self.scrollView
    }

    // 해당 위치로 줌
    func zoom(destinationRect: CGRect) {
        UIView.animate(withDuration: 3.0, delay: 0.0, usingSpringWithDamping: 2.0, initialSpringVelocity: 0.66, options: [.allowUserInteraction], animations: {
            self.scrollView.zoom(to: destinationRect, animated: false)
        }, completion: {
            completed in
            if let delegate = self.scrollView.delegate, delegate.responds(to: #selector(UIScrollViewDelegate.scrollViewDidEndZooming(_:with:atScale:))),
                let view = delegate.viewForZooming?(in: self.scrollView) {
                delegate.scrollViewDidEndZooming!(self.scrollView, with: view, atScale: 1.0)
            }
        })
    }

    // 마커 선택하여 내용 보여주기
    func showMarker(at index: Int) {
        guard let dataSource = dataSource else { return }

        self.markerView.configureMarkerViewCell(marker: dataSource.markerView(indexForItemAt: index))
    }

    // 마커 선택 해제 후 zoom out
    func zoomOutToContainer() {
        if let image = imageView.image {
            zoom(destinationRect: CGRect(origin: .zero, size: image.size))
        }
        markerView.hideContent()
    }

    // zoom에 따른 크기, 위치 조정
    func framSet(markerView: MarkerViewCell) {

        guard let dataSource = dataSource else { return }

        let ratioSize: CGSize = imageView.frame.size.divide(double: dataSource.ratioByImage)

        let ratioLength = ratioSize.height < ratioSize.width ? ratioSize.height : ratioSize.width
        let scaleLength = ratioLength/scrollView.zoomScale

        let origin = self.markerView.frame.origin

        if scrollView.zoomScale > 1 {
            markerView.frame = CGRect(x: origin.x * scrollView.zoomScale - scaleLength/2, y: origin.y * scrollView.zoomScale - scaleLength/2,
                                      width: scaleLength, height: scaleLength)
        } else {
            markerView.frame = CGRect(x: origin.x * scrollView.zoomScale - ratioLength/2, y: origin.y * scrollView.zoomScale - ratioLength/2,
                                      width: ratioLength, height: ratioLength)
        }

        if markerView.imageView != nil {
            markerView.imageView?.frame.size = markerView.frame.size
        }
    }

    func markerView(_ markerView: MarkerViewCell, didSelectMarkerAt index: Int) {
        if !markerView.isSelected {
            markerView.isSelected = !markerView.isSelected

            delegate?.zoom(destinationRect: markerView.destinationRect)
            delegate?.showMarker(at: index)
        }
    }
}

// MARK: ScrollView Delegate
extension MyViewController: UIScrollViewDelegate {

    public func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }

    public func scrollViewDidScroll(_ scrollView: UIScrollView) {

        dataSource?.markers.enumerated().forEach { (idx, item) in
            if let dataSource = dataSource {
                delegate?.framSet(markerView: dataSource.markerView(viewForItemAt: idx))
            }
        }
    }
}

// MARK: ViewController Method
extension MyViewController {

    override func viewWillLayoutSubviews() {
        setZoomParametersForSize(scrollView.bounds.size)
        recenterImage()
    }

    func recenterImage() {
        let scrollViewSize = scrollView.bounds.size
        let imageSize = imageView.frame.size

        let horizontalSpace = imageSize.width < scrollViewSize.width ? (scrollViewSize.width - imageSize.width) / 2 : 0
        let verticalSpace = imageSize.height < scrollViewSize.height ? (scrollViewSize.height - imageSize.height) / 2 : 0

        scrollView.contentInset = UIEdgeInsets(top: verticalSpace, left: horizontalSpace, bottom: verticalSpace, right: horizontalSpace)
    }

    func setZoomParametersForSize(_ scrollViewSize: CGSize) {
        let imageSize = imageView.bounds.size
        let widthScale = scrollViewSize.width / imageSize.width
        let heightScale = scrollViewSize.height / imageSize.height
        let minScale = min(widthScale, heightScale)

        scrollView.minimumZoomScale = minScale
        scrollView.maximumZoomScale = 3.0
        scrollView.zoomScale = minScale
    }
}
