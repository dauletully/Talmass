//
//  ProgressBarView.swift
//  Talmass
//
//  Created by Nurlybaqyt Begaly on 14.03.2025.
//

import UIKit
import SnapKit

class ProgressBarView: UIView {
    
    private var segments: [UIView] = []
    private var segmentCount: Int = 0
    private let activeColor: UIColor
    private let inActiveColor: UIColor
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        
        return stackView
    }()
    
    init(segmentCount: Int, activeColor: UIColor = .white, inActiveColoe: UIColor = .gray) {
        self.segmentCount = segmentCount
        self.activeColor = activeColor
        self.inActiveColor = inActiveColoe
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(stackView)
        
        for _ in 0..<segmentCount {
            let segment = UIView()
            segment.backgroundColor = inActiveColor
            segment.layer.cornerRadius = 2 // Закругленные края
            segments.append(segment)
            stackView.addArrangedSubview(segment)
        }
    }
    
    private func setupConstraints() {
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(16)
            make.height.equalTo(3)
        }
    }
    
    func updateProgress(to index: Int) {
        for (i, segment) in segments.enumerated() {
            segment.backgroundColor = i <= index ? activeColor : inActiveColor
        }
    }
}
