//
//  AVController.swift
//  videoPlayer
//
//  Created by Kyle Gould on 9/6/19.
//  Copyright © 2019 Kyle Gould. All rights reserved.
//

import UIKit
import AVKit

class AVController: AVPlayerViewController {

    var episodeLink: URL = URL(string: "https://link.theplatform.com/s/1RZrUC/7arMxSHnUkru?version=2")!
    
    private func startVideo() {
        let vidPlayer = AVPlayer(url: episodeLink)
        self.player = vidPlayer
        vidPlayer.play()
//        player?.play()
        }
    
    
    public func play() {
        player?.play()
    }
    
    public func pause() {
        player?.pause()
    }
    
    override func viewDidLoad() {
        self.startVideo()
    }
    
}
