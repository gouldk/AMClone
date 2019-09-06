//
//  EpisodeController.swift
//  videoPlayer
//
//  Created by Kyle Gould on 9/3/19.
//  Copyright © 2019 Kyle Gould. All rights reserved.
//

import UIKit
import AVKit


class EpisodeController: UIViewController {
    
    var episodeEndpoint: URL? = URL(string: "")
    var episodeData: EpisodeEndpoint? = nil
    var playerVC: AVPlayerViewController = AVPlayerViewController()
    
    @IBOutlet weak var episodeImage: UIImageView!
    @IBOutlet weak var episodeName: UILabel!
    @IBOutlet weak var showName: UILabel!
    @IBOutlet weak var episodeDesc: UILabel!
    @IBOutlet weak var airDate: UILabel!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var backButton: UIButton!
    
    // linked to back button
    @IBAction func goBack(_ sender: Any) {
        dismiss(animated: true, completion:nil)
    }
    
    // linked to play button
    @IBAction func pressPlay(_ sender: Any) {
        self.loadVideoStream()
    }
    
    private func loadVideoStream() {

//        self.performSegue(withIdentifier: "playVideo", sender: self)
        
        let player = AVPlayer(url: URL(string: "https://link.theplatform.com/s/1RZrUC/7arMxSHnUkru?version=2")!)
        
        let playerVC = AVPlayerViewController()
        playerVC.player = player
        playerVC.videoGravity = AVLayerVideoGravity.resizeAspectFill
        playerVC.showsPlaybackControls = false
        
        let playerView = playerVC.view
        addChild(playerVC)
        view.addSubview(playerView!)
        playerView!.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        playerView!.frame = view.bounds
        playerVC.didMove(toParent: self)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.handleTap))
        tapGesture.delegate = self
        view.addGestureRecognizer(tapGesture)
        
        
//        controller.player = player
//        self.present(controller, animated: true) {[weak self] in
//            DispatchQueue.main.async {
//                player.play()
//            }
//        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let sender = sender as? EpisodeController {
            let dest = segue.destination as! AVController
            dest.episodeLink = URL(string: "https://link.theplatform.com/s/1RZrUC/7arMxSHnUkru?version=2")!
            
        }
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
        let path = self.episodeData!.data!.posts[0].labels
        
        self.episodeName.text = path.layout_content_details.slot_2
        self.rating.text = path.layout_content_details.slot_3
        self.airDate.text = path.layout_content_details.slot_5
        self.showName.text = path.layout_video.slot_1
        self.episodeDesc.text = path.layout_content_details.slot_4
        self.episodeDesc.lineBreakMode = NSLineBreakMode.byWordWrapping
        self.episodeDesc.numberOfLines = 0
        self.setEpisodeImage()
    }
    
    // Fetch the image of this episode and set the UIImage
    private func setEpisodeImage() {
        if let url = URL(string: self.episodeData!.data!.posts[0].images.wide.one.full) {
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

extension EpisodeController: UIGestureRecognizerDelegate {
    
    @IBAction func handleTap(sender: UIGestureRecognizer) {
        if !playerVC.showsPlaybackControls {
            playerVC.showsPlaybackControls = false
        }
    }
}
