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
    
    var videoLayer = AVPlayerLayer()
    
    @IBOutlet weak var myView: UIView!
    
    var videoUrl : URL?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        
        
    }
    
    func createPlayer() {
        
        let player = AVPlayer(url: videoUrl!)
        videoLayer.player = player
        videoLayer.frame = myView.bounds
        myView.layer.addSublayer(videoLayer)
    }
    
    
    
}






