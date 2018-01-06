//
//  ViewController.swift
//  ScrollViewContent
//
//  Created by Seong ho Hong on 2017. 12. 31..
//  Copyright © 2017년 Seong ho Hong. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var editorBtn: UIBarButtonItem!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var minimapView: MinimapView!
    @IBOutlet weak var minimapHeight: NSLayoutConstraint!
    @IBOutlet weak var minimapWidth: NSLayoutConstraint!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var audioContentView: AudioContentView!
    @IBOutlet weak var videoContentView: VideoContentView!
    
    var minimapDataSource: MinimapDataSource!
    var isEditor = false
    var centerPoint = UIView()
    var markerArray = [MarkerView]()
    
    @objc func addMarker(_ notification: NSNotification){
        if let marker = notification.userInfo?["marker"] as? MarkerView {
            markerArray.append(marker)
            print(markerArray.count)
        }
        drawMarkers()
    }
    
    func drawMarkers() {
         let markerDataSoucrce = MarkerViewDataSource(scrollView: scrollView, imageView: imageView, ratioByImage: 400, audioContentView: audioContentView, videoContentView: videoContentView)
        for i in 0..<markerArray.count {
            markerArray[i].draw(dataSource: markerDataSoucrce)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(addMarker), name: NSNotification.Name(rawValue: "makeMarker"), object: nil)
        scrollView.contentInsetAdjustmentBehavior = .never
        imageView.frame.size = (imageView.image?.size)!
        scrollView.delegate = self
        titleLabel.isHidden = true
        
        drawMarkers()
       
        minimapDataSource = MinimapDataSource(scrollView: scrollView, image: imageView.image!, borderWidth: 2, borderColor: UIColor.yellow.cgColor, ratio: 70.0)
        minimapView.set(dataSource: minimapDataSource, height: minimapHeight, width: minimapWidth)
        
        setZoomParametersForSize(scrollView.bounds.size)
        recenterImage()
        
        centerPoint.frame = CGRect(x: scrollView.center.x, y: scrollView.center.y, width: CGFloat(10), height: CGFloat(10))
        centerPoint.backgroundColor = UIColor.red
        centerPoint.layer.cornerRadius = 5
        
        self.view.addSubview(centerPoint)
        centerPoint.isHidden = true
        doneButton.isHidden = true
        
    }
    
    override func viewWillLayoutSubviews() {
        setZoomParametersForSize(scrollView.bounds.size)
        recenterImage()
    }
    
    @IBAction func editionButton(_ sender: Any) {
        if isEditor == false {
            editorBtn.title = "done"
            scrollView.layer.borderWidth = 4
            scrollView.layer.borderColor = UIColor.red.cgColor
            centerPoint.isHidden = isEditor
            //markerView.setOpacity(alpha: 0)
            isEditor = true
            
        } else {
            editorBtn.title = "editor"
            scrollView.layer.borderWidth = 0
            centerPoint.isHidden = isEditor
            //markerView.setOpacity(alpha: 1)
            isEditor = false
            performSegue(withIdentifier: "editor", sender: editorBtn)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "editor") {
            let vc = segue.destination as! EditorViewController
            vc.zoom = Double(scrollView.zoomScale)
            vc.x = Double(scrollView.contentOffset.x + scrollView.contentSize.width/2)
            vc.y = Double(scrollView.contentOffset.y + scrollView.contentSize.height/2)
            print(vc.x)
            print(vc.y)
        }
    }
    
    @IBAction func backButtonAction(_ sender: UIButton) {
        editorBtn.title = "editor"
        titleLabel.isHidden = true
        scrollView.layer.borderWidth = 0
        centerPoint.isHidden = true
        //markerView.setOpacity(alpha: 1)
        isEditor = false
        
        var destinationRect: CGRect = .zero
        destinationRect.size.width = (imageView.image?.size.width)!
        destinationRect.size.height = (imageView.image?.size.height)!
        UIView.animate(withDuration: 2.0, delay: 0.0, usingSpringWithDamping: 3.0, initialSpringVelocity: 0.66, options: [.allowUserInteraction], animations: {
            self.scrollView.zoom(to: destinationRect, animated: false)
        }, completion: {
            completed in
            if let delegate = self.scrollView.delegate, delegate.responds(to: #selector(UIScrollViewDelegate.scrollViewDidEndZooming(_:with:atScale:))), let view = delegate.viewForZooming?(in: self.scrollView) {
                delegate.scrollViewDidEndZooming!(self.scrollView, with: view, atScale: 1.0)
            }
        })
        
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController: UIScrollViewDelegate {
    public func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "scollViewAction"), object: nil, userInfo: nil)
    }
}
