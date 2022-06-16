//
//  LoopingPlayerUIView.swift
//  VideoPlayer
//
//  Created by Catalin Patrascu on 11.03.2022.
//
//  Distributed under the MIT License

import UIKit
import AVFoundation

class LoopingPlayerUIView: UIView {
    private let playerLayer = AVPlayerLayer()
    private var player: AVPlayer?
    private var videos:VideosMetaGrabber?
    private var tv:UILabel!
    private var nv:UILabel!
   
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Depending on your video you can select a proper `videoGravity` property to fit better
    init(
         player: AVQueuePlayer,
         videoGravity: AVLayerVideoGravity = .resizeAspect) {
             self.player = player
        super.init(frame: .zero)
       

        self.backgroundColor = .black
       // player.isMuted = true // just in case
        playerLayer.player = player
        playerLayer.videoGravity = videoGravity
        layer.addSublayer(playerLayer)
        player.actionAtItemEnd = .none
       // player.replaceCurrentItem(with: item)
         
        videos = VideosMetaGrabber()
       
        
             tv = UILabel(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: bounds.size))
             tv.font = UIFont(name: "HelveticaNeue-Bold" , size: 100)
             self.addSubview(tv)
             tv.text = "title"
             tv.textColor = .white
             nv = UILabel(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: bounds.size))
             nv.font = UIFont(name: "Helvetica-Light" , size: 80)
             self.addSubview(nv)
             nv.text = "name"
             nv.textColor = .white
        
       loadVideo()
            
    }
    
    private func loadVideo(){
       
       
       
       
        
        
       
        playerLayer.isHidden = true
 
        
        let v = videos?.playNext()
       
        
       
        tv.alpha = 0
        tv.text = v!.title
        nv.alpha = 0
        nv.text = v!.name
        UIView.animate(withDuration: 1, delay: 1,
            animations: {
            self.tv.alpha = 1
            self.nv.alpha = 1
                
        }, completion: { _ in
            UIView.animate(withDuration: 1, delay:5, animations: {
                self.tv.alpha = 0
                self.nv.alpha = 0
                
            }, completion:{ _ in
                self.player?.replaceCurrentItem(with: v!.item )
                self.player?.currentItem?.seek(to: CMTime.zero, completionHandler: {_ in
                    NotificationCenter.default.addObserver(self,
                                                           selector: #selector(self.playerItemDidReachEnd(notification:)),
                                                                   name: .AVPlayerItemDidPlayToEndTime,
                                                           object: self.player?.currentItem)
                    self.player?.play()
                    self.playerLayer.isHidden = false
                })
               
               
          
            })
        })
        
                           
    }
    
    
    
    @objc func playerItemDidReachEnd(notification: Notification) {
        NotificationCenter.default.removeObserver(self)
        loadVideo()
       
        
       }

    
    override func layoutSubviews() {
        print("from layout")
        super.layoutSubviews()
        playerLayer.frame = bounds
        
        tv.font = UIFont(name: "HelveticaNeue-Bold" , size: bounds.height * 0.05)
        tv.frame = CGRect(origin: CGPoint(x: bounds.width * 0.09, y: bounds.height - (bounds.height * 0.45)), size: CGSize(width: bounds.width, height: bounds.height * 0.06))
        nv.font = UIFont(name: "HelveticaNeue-Light" , size: bounds.height * 0.04)
        nv.frame = CGRect(origin: CGPoint(x: bounds.width * 0.09, y: bounds.height - (bounds.height * 0.38)), size: CGSize(width: bounds.width, height: bounds.height * 0.05))
        NSCursor.hide()
       // print(bounds)
    }
    
    
}
