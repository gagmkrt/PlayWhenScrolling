//
//  ViewController.swift
//  NewWork
//
//  Created by Gag Mkrtchyan on 9/3/20.
//  Copyright © 2020 Gag Mkrtchyan. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

class ViewController: UIViewController {
    
  
    
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    

    @IBOutlet weak var tableView: UITableView!
    
    let urlArray = ["https://media.e11evate.co.uk/api/Image/Download/CroppedPostFile/video-637148817616325109_cropped.mp4", "https://media.e11evate.co.uk/api/Image/Download/CroppedPostFile/video-637148817214585222_cropped.mp4", "https://media.e11evate.co.uk/api/Image/Download/CroppedPostFile/video-637148816379670003_cropped.mp4", "https://media.e11evate.co.uk/api/Image/Download/CroppedPostFile/video-637148815250094987_cropped.mp4"]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = view.bounds.height / 2
        
        
    }
    
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return urlArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyTableViewCell", for: indexPath) as! MyTableViewCell
        
        cell.videoUrl = URL(string: urlArray[indexPath.row])
        cell.createPlayer()
        cell.tapingOnScreen()
        
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        CacheManager.shared.getFileWith(stringUrl: self.urlArray[indexPath.row]) { result in
            
            switch result {
            case .success(let url):
                print("load success")
                
            case .failure(let error):
                print(error, " failure in the Cache of video")
                
            }
        }
        
        
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.bounds.height / 2
    }
    
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if let indexPathsForVisibleRows = tableView.indexPathsForVisibleRows, indexPathsForVisibleRows.count > 0 {
            var focusCell: MyTableViewCell?

            for indexPath in indexPathsForVisibleRows {
                if let cell = tableView.cellForRow(at: indexPath) as? MyTableViewCell {
                    if focusCell == nil {
                        let rect = tableView.rectForRow(at: indexPath)
                        if tableView.bounds.contains(rect) {
                            
                            cell.videoLayer.player?.play()
                            cell.playButton.setImage(UIImage(named: "pause"), for: .normal)
                            cell.slider.maximumValue = Float(cell.player.currentItem?.asset.duration.seconds ?? 0)
                            
                            focusCell = cell
                        } else {
                            cell.videoLayer.player?.pause()
                        }
                    } else {
                        cell.videoLayer.player?.pause()
                    }
                }
            }
        }
    }
    
}
