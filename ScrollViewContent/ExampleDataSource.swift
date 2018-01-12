//
//  ExampleDataSource.swift
//  ScrollViewContent
//
//  Created by 홍창남 on 2018. 1. 12..
//  Copyright © 2018년 Seong ho Hong. All rights reserved.
//

import UIKit

protocol MarkerViewCellDataSource: class {
    var markers: [MarkerType] { get set }

    var ratioByImage: Double { get set }

    func markerView(indexForItemAt index: Int) -> MarkerType
    func markerView(viewForItemAt index: Int) -> MarkerViewCell
    func markerView(numberOfMarkers: Int) -> Int
}

class ExampleDataSource: MarkerViewCellDataSource {

    var markers: [MarkerType] = []
    var ratioByImage: Double

    init() {
        ratioByImage = 0.0
        setTestMarkers()
    }

    func markerView(indexForItemAt index: Int) -> MarkerType {
        return markers[index]
    }

    func markerView(numberOfMarkers: Int) -> Int {
        return markers.count
    }

    func markerView(viewForItemAt index: Int) -> MarkerViewCell {
        return MarkerViewCell(marker: markers[index])
    }

    func setTestMarkers() {
        markers.append(Marker(title: "Test Titlte1"))
        markers.append(Marker(title: "Test Titlte2"))
        markers.append(Marker(title: "Test Titlte3"))
        markers.append(Marker(title: "Test Titlte4"))
        markers.append(Marker(title: "Test Titlte5"))
    }
}


