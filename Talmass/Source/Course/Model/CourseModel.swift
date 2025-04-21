//
//  CourseModel.swift
//  Talmass
//
//  Created by Nurlybaqyt Begaly on 19.04.2025.
//

import Foundation

// MARK: - WelcomeElement
struct CourseModel: Codable {
    let id: Int
    let name, description: String
    let duration, lessonCnt: Int
    let imageSrc: String
    let completed, isStarted: Bool
    let bonusInfo: BonusInfo
    let bonusType: String

    enum CodingKeys: String, CodingKey {
        case id, name, description, duration
        case lessonCnt = "lesson_cnt"
        case imageSrc = "image_src"
        case completed
        case isStarted = "is_started"
        case bonusInfo = "bonus_info"
        case bonusType = "bonus_type"
    }
}

// MARK: - BonusInfo
struct BonusInfo: Codable {
    let promoType: String
    let price: Int
    let description, deadline: String

    enum CodingKeys: String, CodingKey {
        case promoType = "promo_type"
        case price, description, deadline
    }
}

typealias Course = [CourseModel]
