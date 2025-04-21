import UIKit
import SnapKit

extension UIViewController {
    func showErrorBanner(message: String) {
        let banner = UIView()
        banner.backgroundColor = UIColor.red.withAlphaComponent(0.95)
        banner.layer.cornerRadius = 12
        banner.clipsToBounds = true

        let label = UILabel()
        label.text = message
        label.textColor = .white
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textAlignment = .center
        label.numberOfLines = 0

        banner.addSubview(label)
        label.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(12)
        }

        self.view.addSubview(banner)
        banner.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(60)
            make.leading.trailing.equalToSuperview()
        }

        banner.alpha = 0
        UIView.animate(withDuration: 0.3, animations: {
            banner.alpha = 1
        }) { _ in
            UIView.animate(withDuration: 0.3, delay: 2.5, options: [], animations: {
                banner.alpha = 0
            }) { _ in
                banner.removeFromSuperview()
            }
        }
    }
}
