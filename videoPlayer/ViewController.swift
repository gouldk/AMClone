//
//  ViewController.swift
//  videoPlayer
//
//  Created by Kyle Gould on 8/29/19.
//  Copyright © 2019 Kyle Gould. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    // parse out individual episodes into this array from endpoint
    var seasonData: SeasonEndpoint? = nil
    
    private let itemsPerRow: CGFloat = 3
    private let reuseIdentifier = "EpisodeCell"
    private let sectionInsets = UIEdgeInsets(top: 50.0,
                                             left: 20.0,
                                             bottom: 50.0,
                                             right: 20.0)
    
    let seasonEndpoint = URL(string: "https://amc-api-br.svc.ds.amcn.com/v2/public/feed/episodes?show=preacher&season=season-4&device=iOS&restricted=false&publish_state=public")
    let episodeEndpoint = URL(string: "https://amc-api-br.svc.ds.amcn.com/v2/public/feed/video_episodes?show=preacher&season=season-4&episode=episode-01-masada")
    
    
    
    // Grabs JSON data from endpoint & decodes
    private func fetchSeasonEndpoint() -> SeasonEndpoint {
        var json: SeasonEndpoint? = nil
        let semaphore = DispatchSemaphore(value: 0)
        URLSession.shared.dataTask(with: seasonEndpoint!) { (data, response, error) in
            guard let fetchedJSON = data else { return }
            
            let decodedJSON = try! JSONDecoder.init().decode(SeasonEndpoint.self, from: fetchedJSON)
            
            json = decodedJSON
            semaphore.signal()
            }.resume()
        _ = semaphore.wait(timeout: DispatchTime.distantFuture)
//        print(json!.data.posts[0].meta.amcn_field_post_name)
        return json!
    }
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.seasonData = self.fetchSeasonEndpoint()
        // Do any additional setup after loading the view.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return seasonData!.data.response.total
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! EpisodeCell
        
        if let url = URL(string: self.seasonData!.data.posts[indexPath.item].images.square.threeThousand.full) {
            let task = URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in
                if let data = data {
                     DispatchQueue.main.async {
                        cell.episodeImage.image = UIImage(data: data)
                    }
                }
            })
            task.resume()
        }
        
        cell.label.text = seasonData!.data.posts[indexPath.item].labels.layout_content_details.slot_2
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.item)
    }

}

extension ViewController : UICollectionViewDelegateFlowLayout {
    //1
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        //2
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    //3
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    // 4
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
}

