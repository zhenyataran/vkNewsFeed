//
//  NewsFeedViewController.swift
//  vkNewsFeed
//
//  Created by Evgenii Taran on 1/21/20.
//  Copyright © 2020 Evgenii Taran. All rights reserved.
//

import Foundation
import UIKit
import Mapper
import Moya_ModelMapper
import Moya

class NewsFeedViewController: UIViewController {
    
    var newsFeed: FeedResponse!
    var feedViewModel: FeedViewModel!
    var tableView: UITableView!
    
    let dateFormatter: DateFormatter = {
        let dt = DateFormatter()
        dt.dateFormat = "d MMM 'at' HH:mm"
        return dt
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
       
        let activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()

        tableView = UITableView(frame: .zero)
        self.view.addSubViews(to: tableView, activityIndicator)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.separatorStyle = .none
        tableView.delegate = self
        
        NetworkProvider.request(target: .getNews,
                                success: { (response) in
                                    do {
                                        self.newsFeed = try response.map(to: FeedResponse.self)
                                        var cells = [FeedViewModel.Cell]()
                                        let cell = self.newsFeed.responseFeed.items.forEach( { feedItem in
                                            cells.append(self.cells(from: feedItem, profiles: self.newsFeed.responseFeed.profiles, groups: self.newsFeed.responseFeed.groups))
                                        })
                                        self.feedViewModel = FeedViewModel.init(cells: cells)
                                        self.tableView.dataSource = self
                                        self.tableView.register(UINib(nibName: "NewsFeedCell", bundle: nil), forCellReuseIdentifier: NewsFeedCell.reuseId)
                                        self.tableView.reloadData()
                                        activityIndicator.stopAnimating()
                                        print(response)
                                    } catch let error {
                                        print("ERRR:\(error)")
                                        self.displayAlert(title: "error", with: "cant't parse data")
                                    }
        }, error: { (error) in
            print(error)
        }) { (error) in
            print("MoyaError \(error)")
        }
        tableView.backgroundColor = .clear
        view.backgroundColor = .blue
        
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.tableView.reloadData()
        self.view.setNeedsLayout()
    }
}

extension NewsFeedViewController {
    func cells(from feedItem: FeedItem, profiles: [Profile], groups: [Group]) -> FeedViewModel.Cell {
        let date = Date(timeIntervalSince1970: feedItem.date)
        let dateTitle = dateFormatter.string(from: date)
        
        print("TEEEEEXT\(feedItem.text)")
        let photoAttachment = self.photoAttachment(feedItem: feedItem)
        
        let profile = self.profile(for: feedItem.sourceID, profiles: profiles, groups: groups)
   
        return FeedViewModel.Cell.init(iconUrl: profile.photo,
             name: profile.name,
            date: dateTitle,
            text: feedItem.text,
            likes: String(feedItem.likes?.count ?? 0),
            comments: String(feedItem.comments?.count ?? 0),
            shares: String(feedItem.reposts?.count ?? 0),
            views: String(feedItem.views?.count ?? 0),
            photoAttachement: photoAttachment)
    }
    
    private func profile(for sourseID: Int, profiles: [Profile], groups: [Group]) -> ProfileOrGroup {
        
        let profilesOrGroups: [ProfileOrGroup] = sourseID >= 0 ? profiles : groups
        let source = sourseID >= 0 ? sourseID : -sourseID
        let profile = profilesOrGroups.first { (myProfile) -> Bool in
            myProfile.id == source
        }
        return profile!
    }
    
    private func photoAttachment(feedItem: FeedItem) -> FeedViewModel.FeedCellPhotoAttachment? {
        guard let photos = feedItem.attachments?.compactMap({ (attachment) in
            attachment.photos
        }), let firstPhotos = photos.first else {
            return nil
        }
        let photo = getSizes(photo: firstPhotos)
        return FeedViewModel.FeedCellPhotoAttachment.init(photoUrl: photo.url, height: photo.height, width: photo.width)
    }
    
    func getSizes(photo: Photo) -> PhotoSize {
        if let sizeX = photo.sizes.first(where: {$0.type == "x"}) {
            return sizeX
        } else {
            return PhotoSize()
        }
    }
    
}

extension NewsFeedViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        feedViewModel.cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsFeedCell.reuseId, for: indexPath) as! NewsFeedCell
        guard let viewModel = feedViewModel else { return cell}
        cell.set(viewModel: viewModel.cells[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cell = feedViewModel.cells[indexPath.row]
        return NewsFeedCell.totalHeight
    }
    
}
