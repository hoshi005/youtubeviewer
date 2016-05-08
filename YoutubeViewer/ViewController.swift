//
//  ViewController.swift
//  YoutubeViewer
//
//  Created by Susumu Hoshikawa on 2016/05/08.
//  Copyright © 2016年 SH Lab, Inc. All rights reserved.
//

import UIKit
import Alamofire
import Unbox

class ViewController: UIViewController {
	
	static let SEGUE_PLAY_MOVIE = "PLAY_MOVIE"
	
	@IBOutlet weak var collectionView: UICollectionView!
	
	var playlistItems: PlaylistItems?
	var selectedVideoItem: VideoItem?
	
	
	// MARK: - UIViewController.

	override func viewDidLoad() {
		super.viewDidLoad()
		
		// リクエストを取得する.
		self.requestPlaylist { [weak self] response in
			
			print(response.request)
			
			// レスポンスをパースする.
			if let data = response.data {
				do {
					self?.playlistItems = try Unbox(data) as PlaylistItems
				} catch let error {
					print("error = \(error)")
				}
			}
			
			self?.collectionView.reloadData()
		}
	}
	
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		
		// プレイヤー画面への遷移の場合.
		if segue.identifier == ViewController.SEGUE_PLAY_MOVIE {
			// 次の画面に、選択されたVideoItemを渡す.
			let playerViewController = segue.destinationViewController as! PlayerViewController
			playerViewController.videoItem = self.selectedVideoItem
		}
	}
	
	
	// MARK: - private.
	
	private func requestPlaylist(completeHander: Response<AnyObject, NSError> -> Void) {
		
		// プレイリストを取得するためのURL.
		let url = "https://www.googleapis.com/youtube/v3/playlistItems"
		
		// リクエストに利用するパラメータ.
		var parameters = [String: String]()
		parameters["part"] = "snippet,contentDetails"
		parameters["maxResults"] = "50"
		parameters["playlistId"] = "PLrFwetrdOQ9ixp8Kj0mqBLKQAG9DTViJA"
		parameters["key"] = "自分の API Key を使ってね"
		
		// リクエスト実施.
		Alamofire
			// リクエストについて.
			.request(.GET, url, parameters: parameters)
			// レスポンスについて.
			.responseJSON(completionHandler: completeHander)
	}
}


// MARK: - UICollectionViewDataSource.

extension ViewController: UICollectionViewDataSource {
	
	func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		// アイテム数(なかったら0).
		return self.playlistItems?.items.count ?? 0
	}
	
	func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCellWithReuseIdentifier(YoutubeCell.CellIdentifier, forIndexPath: indexPath) as! YoutubeCell
		cell.videoItem = self.playlistItems?.items[indexPath.item]
		return cell
	}
}


// MARK: - UICollectionViewDelegate.

extension ViewController: UICollectionViewDelegate {
	
	func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
		// 選択されたコンテンツを保持してプレイヤー画面へ.
		if let videoItem = self.playlistItems?.items[indexPath.item] {
			self.selectedVideoItem = videoItem
			self.performSegueWithIdentifier(ViewController.SEGUE_PLAY_MOVIE, sender: indexPath)
		}
	}
}


// MARK: - UICollectionViewDelegateFlowLayout.

extension ViewController: UICollectionViewDelegateFlowLayout {
	
	// セルの大きさ.
	func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
		return YoutubeCell.CellSize
	}
	
	// collectionView全体のInsets.
	func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
		return UIEdgeInsets(top: 60, left: 90, bottom: 60, right: 90)
	}
	
	// セル間のスペースの最小値(Y軸方向).
	func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
		return 60
	}
	
	// セル間のスペースの最小値(X軸方向).
	func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
		return 60
	}
}




