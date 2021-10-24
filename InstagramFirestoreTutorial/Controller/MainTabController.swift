//
//  MainTabController.swift
//  InstagramFirestoreTutorial
//
//  Created by 안현정 on 2021/10/23.
//

/*
 1. 탭바 컨트롤러 및 뷰컨트롤러를 설정해주는 configureViewController 메소드 생성
     - 각 뷰컨트롤러 인스턴스 저장
 2.viewDidLoad에 호출
 */

import UIKit

class MainTabController: UITabBarController {
    
     //MARK: - Properties
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
    
    }
    
    // MARK: - Actions
    
    // MARK: - Helpers
    
    //탭바 컨트롤러에 대한 모든 설정
    func configureViewController() {
        view.backgroundColor = .white  //배경색 설정
        
        //각 뷰컨트롤러 인스턴스 저장
        let feed = FeedController()
        
        let search = SearchController()
        
        let imageSelector = ImageSelectorController()
        
        let notification = NotificationController()
        
        let profile = ProfileController()
        
        //뷰 컨트롤러 설정 배열
        viewControllers = [feed, search, imageSelector, notification, profile  ]
        
        
    }
    
}
