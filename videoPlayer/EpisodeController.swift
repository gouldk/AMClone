//
//  EpisodeController.swift
//  videoPlayer
//
//  Created by Kyle Gould on 9/3/19.
//  Copyright © 2019 Kyle Gould. All rights reserved.
//

import UIKit

class EpisodeController: UIViewController {
    
    var episodeEndpoint: URL? = URL(string: "")
    var episodeData: EpisodeEndpoint? = nil
    
    @IBOutlet weak var episodeImage: UIImageView!
    @IBOutlet weak var episodeName: UILabel!
    @IBOutlet weak var showName: UILabel!
    @IBOutlet weak var episodeDesc: UILabel!
    @IBOutlet weak var airDate: UILabel!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var backButton: UIButton!
    
    @IBAction func goBack(_ sender: Any) {
        dismiss(animated: true, completion:nil)
    }
    
    // Parses JSON data from episode page into an EpisodeEndpoint
    private func fetchEpisodeEndpoint() -> EpisodeEndpoint {
        var json: EpisodeEndpoint? = nil
        let semaphore = DispatchSemaphore(value: 0)
        URLSession.shared.dataTask(with: episodeEndpoint!) { (data, response, error) in
            guard let fetchedJSON = data else { return }
            
            let decodedJSON = try! JSONDecoder.init().decode(EpisodeEndpoint.self, from: fetchedJSON)
            
            json = decodedJSON
            semaphore.signal()
            }.resume()
        _ = semaphore.wait(timeout: DispatchTime.distantFuture)
        return json!
    }
    
    // Setup inital data loaded from endpoint
    private func populatePage() {
        self.episodeName.text = self.episodeData!.data.posts[0].labels.layout_content_details.slot_2
        self.rating.text = self.episodeData!.data.posts[0].labels.layout_content_details.slot_3
        self.airDate.text = self.episodeData!.data.posts[0].labels.layout_content_details.slot_5
        self.showName.text = self.episodeData!.data.posts[0].labels.layout_video.slot_1
        self.episodeDesc.text = self.episodeData!.data.posts[0].labels.layout_content_details.slot_4
        self.episodeDesc.lineBreakMode = NSLineBreakMode.byWordWrapping
        self.episodeDesc.numberOfLines = 0
        self.setEpisodeImage()
    }
    
    // Fetch the image of this episode and set the UIImage
    private func setEpisodeImage() {
        if let url = URL(string: self.episodeData!.data.posts[0].images.wide.one.full) {
            let task = URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in
                if let data = data {
                    DispatchQueue.main.async {
                        self.episodeImage.image = UIImage(data: data)
                    }
                }
            })
            task.resume()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        episodeData = self.fetchEpisodeEndpoint()
        self.populatePage()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
