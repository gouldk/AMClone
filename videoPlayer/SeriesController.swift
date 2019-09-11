import UIKit

class SeriesController: UICollectionViewController {
    
    var seriesData: SeriesEndpoint? = nil
    private let reuseIdentifier = "SeriesCell"
    
    let seriesEndpoint: URL = URL(string: "https://amc-api-br.svc.ds.amcn.com/v2/public/feed/shows?size=20")!
    
    private func fetchSeriesEndpoint() -> SeriesEndpoint {
        var json: SeriesEndpoint? = nil
        print("a")
        let semaphore = DispatchSemaphore(value: 0)
        URLSession.shared.dataTask(with: seriesEndpoint) { (data, response, error) in
            guard let fetchedJSON = data else { return }
            
            let decodedJSON = try! JSONDecoder.init().decode(SeriesEndpoint.self, from: fetchedJSON)
            
            json = decodedJSON
            semaphore.signal()
            }.resume()
        _ = semaphore.wait(timeout: DispatchTime.distantFuture)
        return json!
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.seriesData!.data.response.total
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! SeriesCell
        
        if let url = URL(string: self.seriesData!.data.posts[indexPath.item].images.square.one.full) {
            let task = URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in
                if let data = data {
                    DispatchQueue.main.async {
                        cell.seriesImage.image = UIImage(data: data)
                    }
                }
            })
            task.resume()
        }
//        cell.label.text = seriesData!.data.posts[indexPath.item].labels.layout_content_details.slot_2
//        cell.episodeNumber.text = seriesData!.data.posts[indexPath.item].labels.layout_video.slot_2
        
        return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.seriesData = self.fetchSeriesEndpoint()
        
    }
}
