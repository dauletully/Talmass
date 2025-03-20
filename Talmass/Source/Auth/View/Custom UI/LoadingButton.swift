import UIKit

class LoadingButton: UIButton {
    private let activityIndicator = UIActivityIndicatorView(style: .medium)
    private var originalTitle = String()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    private func setup() {
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = .white
        addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }

    func showLoading(_ show: Bool) {
        if show {
            originalTitle = title(for: .normal)!
            setTitle("", for: .normal)
            isEnabled = false
            activityIndicator.startAnimating()
        } else {
            setTitle(originalTitle, for: .normal)  // Название кнопки
            isEnabled = true
            activityIndicator.stopAnimating()
        }
    }
}
