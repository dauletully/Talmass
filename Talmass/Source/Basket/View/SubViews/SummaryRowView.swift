//
//  CheckView.swift
//  Talmass
//
//  Created by Nurlybaqyt Begaly on 10.04.2025.
//
import UIKit
import SnapKit

class SummaryRowView: UIView {
    private let titleLabel = UILabel()
    private let valueLabel = UILabel()

    init(title: String, value: String, valueColor: UIColor = .label, bold: Bool = false) {
        super.init(frame: .zero)

        titleLabel.text = title
        valueLabel.text = value
        valueLabel.textColor = valueColor

        let font = bold ? UIFont.boldSystemFont(ofSize: 17) : UIFont.systemFont(ofSize: 15)
        titleLabel.font = font
        valueLabel.font = font

        let hStack = UIStackView(arrangedSubviews: [titleLabel, valueLabel])
        hStack.axis = .horizontal
        hStack.distribution = .equalSpacing
        addSubview(hStack)

        hStack.snp.makeConstraints { $0.edges.equalToSuperview() }
    }

    required init?(coder: NSCoder) { fatalError() }
    
}
