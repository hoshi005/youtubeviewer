//
//  YoutubePlaylistModel+Unbox.swift
//  YoutubeViewer
//
//  Created by Susumu Hoshikawa on 2016/05/08.
//  Copyright © 2016年 SH Lab, Inc. All rights reserved.
//

import UIKit
import Unbox

// MARK: - PlaylistItems: Unboxable.

extension PlaylistItems: Unboxable {
	init(unboxer: Unboxer) {
		self.items = unboxer.unbox("items")
	}
}

// MARK: - VideoItem: Unboxable.

extension VideoItem: Unboxable {
	init(unboxer: Unboxer) {
		self.contentDetails = unboxer.unbox("contentDetails")
		self.snippet = unboxer.unbox("snippet")
	}
}

// MARK: - ContentDetails: Unboxable.

extension ContentDetails: Unboxable {
	init(unboxer: Unboxer) {
		self.videoId = unboxer.unbox("videoId")
	}
}

// MARK: - Snippet: Unboxable.

extension Snippet: Unboxable {
	init(unboxer: Unboxer) {
		self.thumbnails = unboxer.unbox("thumbnails")
	}
}

// MARK: - Thumbnails: Unboxable.

extension Thumbnails: Unboxable {
	init(unboxer: Unboxer) {
		self.mediumThumb = unboxer.unbox("medium")
	}
}

// MARK: - Thumbnail: Unboxable.

extension Thumbnail: Unboxable {
	init(unboxer: Unboxer) {
		self.url = unboxer.unbox("url")
	}
}