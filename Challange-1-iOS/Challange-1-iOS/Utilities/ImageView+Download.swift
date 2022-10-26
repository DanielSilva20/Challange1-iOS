import UIKit

extension UIImageView {
    func createDownloadDataTask(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) -> URLSessionTask{
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
                self?.contentMode = mode
            }
        }
        return task
    }

}
