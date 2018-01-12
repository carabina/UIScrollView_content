//
//  Marker.swift
//  ScrollViewContent
//
//  Created by 홍창남 on 2018. 1. 12..
//  Copyright © 2018년 Seong ho Hong. All rights reserved.
//

import Foundation

protocol MarkerType {
    var videoURL: URL? { get set }
    var audioURL: URL? { get set }
    var title: String? { get set }
    var textTitle: String? { get set }
    var textLink: String? { get set }
    var textContent: String? { get set }
    var existContent: [String: Bool]? { get set }
}

struct Marker: MarkerType {

    var videoURL: URL?
    var audioURL: URL?
    var title: String?
    var textTitle: String?
    var textLink: String?
    var textContent: String?

    var existContent: [String: Bool]? = ["isTitleContent": false, "isAudioContent": false,
                                        "isVideoContent": false, "isTextContent": false]

    init(videoURL: URL? = nil, audioURL: URL? = nil, title: String? = nil,
         textTitle: String? = nil, textLink: String? = nil, textContent: String? = nil, existContent: [String: Bool]? = nil) {
        self.videoURL = videoURL
        self.audioURL = audioURL
        self.title = title
        self.textTitle = textTitle
        self.textLink = textLink
        self.textContent = textContent
        self.existContent = existContent
    }

}
