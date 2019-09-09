import UIKit
import AVKit


class EpisodeController: UIViewController {
    
    var episodeEndpoint: URL? = URL(string: "")
    var episodeData: EpisodeEndpoint? = nil
    var player = AVPlayer()
    var playerViewController = AVPlayerViewController()
    var contentURL: URL? = nil
    
    
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
        self.player = AVPlayer(url: getContentURL())
        self.playerViewController.player = player
        self.playerViewController.player?.play()
        self.playerViewController.showsPlaybackControls = true
        self.present(playerViewController, animated: true)

        
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if let sender = sender as? EpisodeController {
//            let dest = segue.destination as! AVController
//            dest.episodeLink = URL(string: "https://link.theplatform.com/s/1RZrUC/7arMxSHnUkru?version=2")!
//
//        }
//    }
    
    
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
    
    private func getContentURL() -> URL {
        let pid = self.episodeData!.data!.posts[0].meta.amcn_field_release_pid
        let contentURL = "https://link.theplatform.com/s/M_UwQC/" + pid + "?version=2"
        return URL(string: contentURL)!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.episodeData = self.fetchEpisodeEndpoint()
        self.populatePage()
    }

}
