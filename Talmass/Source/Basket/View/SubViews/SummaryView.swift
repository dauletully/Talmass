//
//  SummaryView.swift
//  Talmass
//
//  Created by Nurlybaqyt Begaly on 10.04.2025.
//

import UIKit
import SnapKit

final class SummaryView: UIView {

    private let stackView = UIStackView()
    
    private let countRow = SummaryRowView()
    private let bonusRow = SummaryRowView()
    private let totalRow = SummaryRowView()
    
    private let dashedLine = UIView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    func configure(itemCount: Int, bonus: Int, total: Int) {
        countRow.configure(title: "\(itemCount) товаров", value: "\(total + bonus) ₽")
        bonusRow.configure(title: "Оплата бонусами", value: "-\(bonus) ₽", valueColor: .systemRed)
        totalRow.configure(title: "Итого", value: "\(total) ₽", bold: true)
    }

    private func setupUI() {
        backgroundColor = UIColor(white: 0.97, alpha: 1)
        layer.cornerRadius = 20
        
        stackView.axis = .vertical
        stackView.spacing = 12
        stackView.isUserInteractionEnabled = true
        
        addSubview(stackView)
        stackView.addArrangedSubview(countRow)
        stackView.addArrangedSubview(bonusRow)
        stackView.addArrangedSubview(dashedLine)
        stackView.addArrangedSubview(totalRow)
        
        makeDashedLine()
    }

    private func setupConstraints() {
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(16)
        }

        dashedLine.snp.makeConstraints {
            $0.height.equalTo(1)
        }
    }

    private func makeDashedLine() {
        dashedLine.backgroundColor = .clear
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = UIColor.lightGray.cgColor
        shapeLayer.lineDashPattern = [4, 3]
        shapeLayer.lineWidth = 1
        dashedLine.layer.addSublayer(shapeLayer)
        
        DispatchQueue.main.async {
            let path = UIBezierPath()
            path.move(to: .zero)
            path.addLine(to: CGPoint(x: self.dashedLine.bounds.width, y: 0))
            shapeLayer.path = path.cgPath
        }
    }
}
