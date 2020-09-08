//
//  MyTableViewCell.swift
//  NewWork
//
//  Created by Gag Mkrtchyan on 9/3/20.
//  Copyright © 2020 Gag Mkrtchyan. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

class MyTableViewCell: UITableViewCell {
    
    var player = AVPlayer()
    
    var playerItem: AVPlayerItem?
    
    @IBOutlet weak var playButton: UIButton!
    
    @IBOutlet weak var slider: UISlider!
    
    
    
    var isPlaying = false {
        
        willSet {
            if newValue {
                
                playButton.setImage(UIImage(named: "play"), for: .normal)
                videoLayer.player?.pause()
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    self.playButton.isHidden = true
                    self.slider.isHidden = true
                }
            } else {
                playButton.setImage(UIImage(named: "pause"), for: .normal)
                videoLayer.player?.play()
            }
        }
    }
    
    
    
    
    var videoLayer = AVPlayerLayer()
    
    @IBOutlet weak var myView: UIView!
    
    var videoUrl : URL?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }
    
    @IBAction func playAndPause(_ sender: UIButton) {
        
        isPlaying = !isPlaying
        slider.maximumValue = Float(player.currentItem?.asset.duration.seconds ?? 0)

    }
    
    
    
    func tapingOnScreen() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(taping))
        myView.addGestureRecognizer(tap)
    }
    
    @objc func taping() {
        
        playButton.isHidden = false
        slider.isHidden = false
    }
    
    
    
    
    func createPlayer() {
        
        playerItem = AVPlayerItem(url: videoUrl!)
        player = AVPlayer(playerItem: playerItem)
        videoLayer.player = player
        videoLayer.frame = myView.bounds
        videoLayer.videoGravity = .resizeAspectFill
        myView.layer.addSublayer(videoLayer)
        
        player.addPeriodicTimeObserver(forInterval: CMTime(seconds: 0.5, preferredTimescale: 1000), queue: DispatchQueue.main) { (time) in

            self.slider.value = Float(time.seconds)
        }
        
    }
    
    
    
    
}






