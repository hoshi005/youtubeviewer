//
//  PlayerViewController.swift
//  YoutubeViewer
//
//  Created by Susumu Hoshikawa on 2016/05/08.
//  Copyright © 2016年 SH Lab, Inc. All rights reserved.
//

import UIKit
import AVKit
import HCYoutubeParser

class PlayerViewController: AVPlayerViewController {
	
	var videoItem: VideoItem?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		print(self.player)
		
		// videoIdを取り出す.
		guard let videoId = self.videoItem?.contentDetails.videoId else {
			return
		}
		
		// videoIdを元にコンテンツ情報を取得する.
		guard let dic = HCYoutubeParser.h264videosWithYoutubeID(videoId) else {
			return
		}
		
		// コンテンツのURLを取得して再生開始.
		if let urlString = dic["medium"] as? String, let url = NSURL(string: urlString) {
			self.player = AVPlayer(URL: url)
			self.player?.play()
		}
	}
}
