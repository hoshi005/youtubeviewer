//
//  YoutubePlaylistModel.swift
//  YoutubeViewer
//
//  Created by Susumu Hoshikawa on 2016/05/08.
//  Copyright © 2016年 SH Lab, Inc. All rights reserved.
//

import UIKit

struct PlaylistItems {
	var items: [VideoItem]
}

struct VideoItem {
	let contentDetails: ContentDetails
	let snippet: Snippet
}

struct ContentDetails {
	let videoId: String
}

struct Snippet {
	let thumbnails: Thumbnails
}

struct Thumbnails {
	let mediumThumb: Thumbnail
}

struct Thumbnail {
	let url: NSURL
}
