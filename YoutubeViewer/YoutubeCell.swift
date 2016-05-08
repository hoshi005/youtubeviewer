//
//  YoutubeCell.swift
//  YoutubeViewer
//
//  Created by Susumu Hoshikawa on 2016/05/08.
//  Copyright © 2016年 SH Lab, Inc. All rights reserved.
//

import UIKit
import AlamofireImage

class YoutubeCell: UICollectionViewCell {
	
	static let CellIdentifier = "YoutubeCell"
	static let CellSize = CGSize(width: 320.0, height: 180.0)
	
	@IBOutlet weak var thumbnailImageView: UIImageView!
	
	var videoItem: VideoItem? {
		didSet {
			// URLが存在する場合は、画像を取得して当て込む.
			if let url = self.videoItem?.snippet.thumbnails.mediumThumb.url {
				self.thumbnailImageView.af_setImageWithURL(url, imageTransition: .CrossDissolve(0.5))
			}
		}
	}
	
	
	// MARK: UIView.
	
	override func awakeFromNib() {
		super.awakeFromNib()
		
		// フォーカスが当たった時のアレ.
		self.thumbnailImageView.clipsToBounds = false
		self.thumbnailImageView.adjustsImageWhenAncestorFocused = true
	}
	
	
	// MARK: UICollectionReusableView.
	
	override func prepareForReuse() {
		super.prepareForReuse()
		
		// サムネイル画像を一旦削除.
		self.thumbnailImageView.image = nil
	}
}
