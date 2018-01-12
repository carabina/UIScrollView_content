////
////  ViewController.swift
////  ScrollViewContent
////
////  Created by Seong ho Hong on 2017. 12. 31..
////  Copyright © 2017년 Seong ho Hong. All rights reserved.
////
//
//import UIKit
//
//
//class ViewController: UIViewController {
//    @IBOutlet weak var editorBtn: UIBarButtonItem!
//    @IBOutlet weak var scrollView: UIScrollView!
//    @IBOutlet weak var imageView: UIImageView!
//    @IBOutlet weak var doneButton: UIButton!
//    @IBOutlet weak var backButton: UIButton!
//
//    var isEditor = false
//    var centerPoint = UIView()
//    var markerArray = [MarkerView]()
//
//    @objc func addMarker(_ notification: NSNotification){
//        let marker = MarkerView()
//
//        let x = notification.userInfo?["x"] as! CGFloat
//        let y = notification.userInfo?["y"] as! CGFloat
//
//        let zoom =  notification.userInfo?["zoomScale"] as! CGFloat
//        let isAudioContent = notification.userInfo?["isAudioContent"] as! Bool
//        let isVideoContent = notification.userInfo?["isVideoContent"] as! Bool
//        let isTextContent = notification.userInfo?["isText"] as! Bool
//        let videoURL = notification.userInfo?["videoURL"]
//        let audioURL = notification.userInfo?["audioURL"]
//        let markerTitle = notification.userInfo?["title"]
//        let link = notification.userInfo?["link"]
//        let text = notification.userInfo?["text"]
//
//        let existContent = ["isTitleContent": true, "isAudioContent": isAudioContent,
//                            "isVideoContent": isVideoContent, "isTextContent": isTextContent]
//
//        marker.set(dataSource: markerDataSource, origin: CGPoint(x: x, y: y), zoomScale: zoom, existContent: existContent)
//
//
//        marker.setAudioContent(url: audioURL as! URL)
//        marker.setVideoContent(url: videoURL as! URL)
//        marker.setTitle(title: markerTitle as! String)
//        marker.setText(title: "", link: link as! String, content: text as! String)
//        marker.setMarkerImage(markerImage: #imageLiteral(resourceName: "page"))
//
//        markerArray.append(marker)
//        markerDataSource.framSet(markerView: marker)
//        markerDataSource.reset()
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        NotificationCenter.default.addObserver(self, selector: #selector(addMarker), name: NSNotification.Name(rawValue: "makeMarker"), object: nil)
//        scrollView.contentInsetAdjustmentBehavior = .never
//        imageView.frame.size = (imageView.image?.size)!
//        scrollView.delegate = self
//
//
//        // markerData Source 설정
//        markerDataSource = MarkerViewDataSource(scrollView: scrollView, imageView: imageView, ratioByImage: 300, titleLabelView: titleLabel, audioContentView: audioContentView, videoContentView: videoContentView, textContentView: textContentView)
//
//
//
//        // edit center point 설정
//        centerPoint.frame = CGRect(x: view.frame.width/2, y: view.frame.height/2 + scrollView.frame.origin.y/2, width: CGFloat(10), height: CGFloat(10))
//        centerPoint.backgroundColor = UIColor.red
//        centerPoint.layer.cornerRadius = 5
//
//        self.view.addSubview(centerPoint)
//        centerPoint.isHidden = true
//        doneButton.isHidden = true
//    }
//
//
//    @IBAction func editionButton(_ sender: Any) {
//        if isEditor == false {
//            editorBtn.title = "Done"
//            scrollView.layer.borderWidth = 4
//            scrollView.layer.borderColor = UIColor.red.cgColor
//            centerPoint.isHidden = isEditor
//            isEditor = true
//
//        } else {
//            editorBtn.title = "Editor"
//            scrollView.layer.borderWidth = 0
//            centerPoint.isHidden = isEditor
//            isEditor = false
//
//
//            let editorViewController = EditorContentViewController()
//
//            editorViewController.zoom = Double(scrollView.zoomScale)
//            editorViewController.x = Double(scrollView.contentOffset.x/scrollView.zoomScale + scrollView.bounds.size.width/scrollView.zoomScale/2)
//            editorViewController.y = Double(scrollView.contentOffset.y/scrollView.zoomScale + scrollView.bounds.size.height/scrollView.zoomScale/2)
//
//            self.show(editorViewController, sender: nil)
//        }
//    }
//
//    @IBAction func backButtonAction(_ sender: UIButton) {
//        markerDataSource?.reset()
//    }
//
//}
//
//extension ViewController: UIScrollViewDelegate {
//    public func viewForZooming(in scrollView: UIScrollView) -> UIView? {
//        return imageView
//    }
//
//    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "scollViewAction"), object: nil, userInfo: nil)
//        markerArray.map { marker in
//            markerDataSource?.framSet(markerView: marker)
//        }
//    }
//}
//
