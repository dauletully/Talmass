import UIKit
import SnapKit

final class SummaryRowView: UIView {
    
    private let titleLabel = UILabel()
    private let valueLabel = UILabel()
    private let hStack = UIStackView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(title: String, value: String, valueColor: UIColor = .label, bold: Bool = false) {
        titleLabel.text = title
        valueLabel.text = value
        valueLabel.textColor = valueColor
        
        let font = bold ? UIFont.boldSystemFont(ofSize: 17) : UIFont.systemFont(ofSize: 15)
        titleLabel.font = font
        valueLabel.font = font
    }

    private func setup() {
        hStack.axis = .horizontal
        hStack.distribution = .equalSpacing
        hStack.alignment = .center
        
        titleLabel.isUserInteractionEnabled = true
        valueLabel.isUserInteractionEnabled = true
        hStack.addArrangedSubview(titleLabel)
        hStack.addArrangedSubview(valueLabel)

        addSubview(hStack)

        hStack.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
