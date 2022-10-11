//
//  NewsTableViewCell.swift
//  Messenger
//
//  Created by Polly on 18.04.2022.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    
    @IBOutlet weak var newsUserFoto: UIImageView!
    
    @IBOutlet weak var newsNameLabel: UILabel!
    
    @IBOutlet weak var newsDateLabel: UILabel!
    
    @IBOutlet weak var newsTextLabel: UILabel!
    
    @IBOutlet weak var newsImage: UIImageView! {
        didSet {
            newsImage.contentMode = .scaleAspectFill
        }
    }

    @IBOutlet weak var likeButton: LikeButton!
    
    @IBOutlet weak var commentButton: CommentButton!
    
    @IBOutlet weak var repostButton: ShareButton!
    
    @IBOutlet weak var viewsButton: LookButton!
    
    private let imageCache = ImageCaching.shared
    let dafaultImage = "https://thumbs.dreamstime.com/b/no-image-available-icon-flat-vector-no-image-available-icon-flat-vector-illustration-132482953.jpg"
    
    
    let dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "dd.MM.YYYY HH:mm:ss"
        df.locale = Locale(identifier: "ru_RU")
        return df
    }()
    
    override func prepareForReuse() {
        newsImage.image = nil
        newsUserFoto.image = nil
    }

    
     func setupViewWith(item: NewsItem, groups: [NewsGroup], profiles: [Profile]) {
        
        
        if item.sourceID > 0 {
                for profile in profiles {
                    if profile.id == item.sourceID {
                        newsNameLabel.text = profile.firstName
                        imageCache.fetchImage(withURL: profile.photo50) { [weak self] (image) in
                            self?.newsUserFoto.image = image
                        }
                    }
                }
            } else {
                for group in groups {
                    if group.id == -item.sourceID {
                        
                        newsNameLabel.text = group.name
                        imageCache.fetchImage(withURL: group.photo50) { [weak self] (image) in
                            self?.newsUserFoto.image = image
                        }
                    }
                }
            }

        newsDateLabel.text = convertDate(date: item.date)

        newsTextLabel.text = item.text
        
        imageCache.fetchImage(withURL: item.attachments?[0].photo?.sizes[3].url ?? dafaultImage) { [weak self] (image) in
            self?.newsImage.image = image
        }
       
        likeButton.likeCount = item.likes?.count ?? 0
        commentButton.commentCount = item.comments?.count ?? 0
        repostButton.shareCount = item.reposts?.count ?? 0
        viewsButton.lookCount = item.views?.count ?? 0
       
    }
 
    private func convertDate(date: Int) -> String {
        let date = Date(timeIntervalSince1970: (Double(date) ))
        return dateFormatter.string(from: date)
    }
    
}
