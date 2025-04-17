//
//  ViewController.swift
//  Talmass
//
//  Created by Nurlybaqyt Begaly on 14.03.2025.
//

import UIKit

class OnboardingViewModel {
    
    private var pages: [OnboardingModel] = [
        OnboardingModel(title: "Избавьтесь от боли в спине раз и навсегда!",
                        description: "Здоровье спины – это один из основных показателей комфорта жизни",
                        imageTitle: "onboarding_image"),
        OnboardingModel(title: "Наша цель",
                        description: "Здоровье спины – это один из основных показателей комфорта жизни",
                        imageTitle: "onboarding_image_2"),
        OnboardingModel(title: "Спина требует ежедневного ухода",
                        description: "Здоровье спины – это один из основных показателей комфорта жизни",
                        imageTitle: "onboarding_image_3")
    ]
    
    private var currentIndex = 0
    
    //Call back to update UI
    var onPageChanged: ((Int) -> Void)?
    
    var onFinished: (() -> Void)?
    
    //To get current page
    func getCurrentPage() -> OnboardingModel {
        return pages[currentIndex]
    }
    func getCurrentIndex() -> Int {
        return currentIndex
    }
    //To update current page with slider
    func updatePage(index: Int) {
        guard index >= 0 && index < pages.count else { return }
        currentIndex = index
        onPageChanged?(index)
    }
    //To go next page with slider
    func nextPage() {
        if currentIndex < pages.count - 1 {
            currentIndex += 1
            onPageChanged?(currentIndex)
        } else {
            onFinished?()
        }
    }
}

