//
//  MainTabController.swift
//  InstagramFirestoreTutorial
//
//  Created by 안현정 on 2021/10/23.
//

/*
 1. 탭바 컨트롤러 및 뷰컨트롤러를 설정해주는 configureViewController 메소드 생성
     - 각 뷰컨트롤러 인스턴스 저장
     - viewDidLoad에 호출
 2. 커스텀 탭바 템플릿 메소드 생성
    - 뷰 컨트롤러 인스턴스마다 templateNavigationController 호출하여 이미지 변경
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
        
        //UICollectionViewFlowLayout 객체 생성
        let layout = UICollectionViewFlowLayout()
        
        //각 뷰컨트롤러 인스턴스 저장
        let feed = templateNavigationController(unselectedImage: #imageLiteral(resourceName: "home_unselected"), selectedImage: #imageLiteral(resourceName: "home_selected"),
                                                rootViewController: FeedController(collectionViewLayout: layout))

        let search = templateNavigationController(unselectedImage: #imageLiteral(resourceName: "search_unselected"), selectedImage: #imageLiteral(resourceName: "search_selected"), rootViewController: SearchController())
        
        let imageSelector = templateNavigationController(unselectedImage: #imageLiteral(resourceName: "plus_unselected"), selectedImage: #imageLiteral(resourceName: "plus_unselected"), rootViewController: SearchController())
        
        let notification = templateNavigationController(unselectedImage: #imageLiteral(resourceName: "like_unselected"), selectedImage: #imageLiteral(resourceName: "like_selected"), rootViewController: NotificationController())
        
        let profile = templateNavigationController(unselectedImage: #imageLiteral(resourceName: "profile_unselected"), selectedImage: #imageLiteral(resourceName: "profile_selected"), rootViewController: ProfileController())
        
        //뷰 컨트롤러 설정 배열 (navigation stack은 view controller들을 배열 형태로 가지고있음 ->  push, pop 형태로 관리 )
        //배열의 순서 = 연관된 tab bar item 순서
        viewControllers = [feed, search, imageSelector, notification, profile  ]
        
        //탭바 아이템 선택했을 때, 색 지정
        tabBar.tintColor = .black

    }

    
    //커스텀 탭바 템플릿 메소드
    func templateNavigationController(unselectedImage: UIImage, selectedImage: UIImage,
                                      rootViewController: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: rootViewController)
        nav.tabBarItem.image = unselectedImage
        nav.tabBarItem.selectedImage = selectedImage
        nav.navigationBar.tintColor = .black
        
        return nav
    }
    
}


