import UIKit

class ImageLoader {
    static let shared = ImageLoader()
    private var cache = NSCache<NSURL, UIImage>()
    
    init() {}
    
    func loadImage(from urlString: String, completion: @escaping (UIImage?) -> Void) {
        
        guard let url = URL(string: urlString) else {
            print("Ошибка URL")
            completion(nil)
            return
        }
        // Проверяем кэш
        if let cachedImage = cache.object(forKey: url as NSURL) {
            completion(cachedImage)
            return
        }
        
        URLSession.shared.dataTask(with: url) { [weak self](data, _, error) in
            
            if let error = error {
                print("Ошибка сети: \(error.localizedDescription)")
            }
            
            guard let data = data, let image = UIImage(data: data) else {
                print("Ошибка загрузки данных")
                completion(nil)
                return
            }
            
            // Кэшируем изображение
            self?.cache.setObject(image, forKey: url as NSURL)
            
            DispatchQueue.main.async {
                completion(image)
            }
        }.resume()
    }
    
}
