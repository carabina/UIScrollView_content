//
//  MarkerViewDelegate.swift
//  ScrollViewContent
//
//  Created by 홍창남 on 2018. 1. 12..
//  Copyright © 2018년 Seong ho Hong. All rights reserved.
//

import UIKit

protocol MarkerViewCellDelegate: class {
    var delegateScrollView: UIScrollView { get }
    func zoom(destinationRect: CGRect)
    func showMarker(at index: Int)
    func zoomOutToContainer()
    func framSet(markerView: MarkerViewCell)

    func markerView(_ markerView: MarkerViewCell, didSelectMarkerAt index: Int)
}
