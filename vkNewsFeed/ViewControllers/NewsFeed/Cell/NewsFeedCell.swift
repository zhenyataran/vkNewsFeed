//
//  NewsFeedCell.swift
//  vkNewsFeed
//
//  Created by Evgenii Taran on 1/22/20.
//  Copyright © 2020 Evgenii Taran. All rights reserved.
//

import Foundation
import UIKit

protocol FeedCellViewModel {
    var iconUrl: String { get }
    var name: String { get }
    var date: String { get }
    var text: String? { get }
    var likes: String? { get }
    var comments: String? { get }
    var shares: String? { get }
    var views: String? { get }
    var photoAttachement: FeedCellPhotoAttachementViewModel? { get }
}

protocol FeedCellPhotoAttachementViewModel {
    var photoUrl: String? { get }
    var height: Int { get }
    var width: Int { get }
}

struct Constants {
    static let cardInsets = UIEdgeInsets(top: 0, left: 8, bottom: 12, right: 8)
    static let topViewHeight: CGFloat = 36
    static let postLabelInsets = UIEdgeInsets(top: 8 + Constants.topViewHeight + 8, left: 8, bottom: 8, right: 8)
    static let postLabelFont = UIFont.systemFont(ofSize: 15)
    static let bottomViewHeight: CGFloat = 44
}


class NewsFeedCell: UITableViewCell {
    
    static let reuseId = "NewsfeedCell"
    static var totalHeight: CGFloat = 0
    var attachemntRatio: CGFloat = 0

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var postLabel: UILabel!
    
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var commentsLabel: UILabel!
    @IBOutlet weak var shareLabel: UILabel!
    @IBOutlet weak var viewsLabel: UILabel!
    
    @IBOutlet weak var postImageView: UIImageView!
    
    override func prepareForReuse() {
        iconImageView.setImage(from: nil)
        postImageView.setImage(from: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        iconImageView.layer.cornerRadius = iconImageView.frame.height / 2
        iconImageView.clipsToBounds = true
        backgroundColor = .clear
        selectionStyle = .none
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0))
    }
    
    func set(viewModel: FeedCellViewModel) {
        iconImageView.setImage(from: viewModel.iconUrl)
        nameLabel.text = viewModel.name
        dateLabel.text = viewModel.date
        postLabel.text = viewModel.text
        likesLabel.text = viewModel.likes
        commentsLabel.text = viewModel.comments
        shareLabel.text = viewModel.shares
        viewsLabel.text = viewModel.views
        
        
        
        
        if let photoAttachment = viewModel.photoAttachement {
            postImageView.setImage(from: photoAttachment.photoUrl)
            postImageView.isHidden = false
            let photoHeight: Float = Float(photoAttachment.height)
            let photoWidth: Float = Float(photoAttachment.width)
            attachemntRatio = CGFloat(photoHeight / photoWidth)
            
            } else {
                postImageView.isHidden = true
        }
        layOut(postText: postLabel.text)
    }
    
    func layOut(postText: String?) {
        let cardWidth = self.frame.width - 16
        
        postLabel.frame = CGRect(origin: CGPoint(x: Constants.postLabelInsets.left, y: Constants.postLabelInsets.top),
                                    size: CGSize.zero)
        
        if let text = postText, !text.isEmpty {
            let width = cardWidth - Constants.postLabelInsets.left - Constants.postLabelInsets.right
            let height = text.height(width: width, font: Constants.postLabelFont)
            
            postLabel.frame.size = CGSize(width: width, height: height)
        }
        
        let attachmentTop = postLabel.frame.size == CGSize.zero ? Constants.postLabelInsets.top : postLabel.frame.maxY + Constants.postLabelInsets.bottom
        
        postImageView.frame = CGRect(origin: CGPoint(x: 0, y: attachmentTop),
                                     size: CGSize.zero)

        postImageView.frame.size = CGSize(width: cardWidth, height: cardWidth * attachemntRatio)
        
        let bottomViewTop = max(postLabel.frame.maxY, postImageView.frame.maxY)
        let bottomViewFrame = CGRect(origin: CGPoint(x: 0, y: bottomViewTop),
        size: CGSize(width: cardWidth, height: 50))
        NewsFeedCell.totalHeight = bottomViewFrame.maxY + Constants.cardInsets.bottom
    }
}
