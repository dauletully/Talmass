//
//  CourseViewModel.swift
//  Talmass
//
//  Created by Nurlybaqyt Begaly on 19.04.2025.
//
import UIKit

class CourseViewModel {
    
    var courses: Course = [] {
        didSet {
            onCourseUpdated?(courses)
        }
    }
    
    var onCourseUpdated: ((Course) -> Void)?
    func loadImage(for imageURL: String, complation: @escaping(UIImage?) -> Void) {
        let imageUrl = "http://drevmasstestapi.mobydev.kz/" + imageURL
        ImageLoader.shared.loadImage(from: imageUrl, completion: complation)
    }
    
    func fetchCourses() {
        ApiManager.shared.fetchCourse { result in
            DispatchQueue.main.async {
                switch  result {
                    case .success(let courses):
                    self.courses = courses
                    print(courses)
                case .failure(let error):
                    print(" Error: \(error.localizedDescription)")
                }
            }
            
        }
    }

}
