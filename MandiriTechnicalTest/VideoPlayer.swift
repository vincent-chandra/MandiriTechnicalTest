//
//  VideoPlayer.swift
//  MandiriTechnicalTest
//
//  Created by Vincent on 27/02/22.
//

import UIKit
import AVKit

class VideoPlayer: UIView{
    @IBOutlet weak var viewPlayer: UIView!
    var player: AVPlayer?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    fileprivate func commonInit() {
        let viewFromXib = Bundle.main.loadNibNamed("VideoPlayer", owner: self, options: nil)![0] as! UIView
        viewFromXib.frame = self.bounds
        addSubview(viewFromXib)
        addPlayerToView(self.viewPlayer)
    }
    
    fileprivate func addPlayerToView(_ view: UIView) {
        player = AVPlayer()
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = self.bounds
        playerLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(playerLayer)
        NotificationCenter.default.addObserver(self, selector: #selector(playerEndPlay), name: .AVPlayerItemDidPlayToEndTime, object: nil)
    }
    
    func playVideoWithFileName(_ fileName: String, ofType type:String) {
        guard let filePath = Bundle.main.path(forResource: fileName, ofType: type) else { return }
        let videoURL = URL(fileURLWithPath: filePath)
        let playerItem = AVPlayerItem(url: videoURL)
        player?.replaceCurrentItem(with: playerItem)
        player?.play()
    }
    
    @objc func playerEndPlay() {
        print("Player ends playing video")
    }
    
    
}
