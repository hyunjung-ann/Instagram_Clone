//
//  FeedController.swift
//  InstagramFirestoreTutorial
//
//  Created by 안현정 on 2021/10/23.
//

/*
 1. 컬렉션뷰컨트롤러 상속
     - MainTabController에서 UICollectionViewFlowLayout 객체 생성 -> feed 인스턴스에 UICollectionViewFlowLayout 상속
 2. UICollectionViewDataSource 메서드 구현
     - 재사용된 Cell을 식별하기 위해 reuseIdentifier를 할당할 변수를 만듬
     - 셀을 사용하겠다는 register 꼭 등록해주기
 3. cell 크기 조정하는 UICollectionViewDelegateFlowLayout 상속 후 메서드 생성
 */

import UIKit

//MARK:-  Properties

//UICollectionViewCell에 dentifier를 지정
private let reuseIdentifier = "Cell"



class FeedController: UICollectionViewController{
    

    //MARK:- Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        
    }
    

    // MARK: - Actions
    // MARK: - Helpers
    
    func configureUI() {
        //컬렉션 뷰 배경색 변경
        collectionView.backgroundColor = .white
        collectionView.register(FeedCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }
}

    // MARK: - UICollectionViewDataSource
    
//UICollectionViewController는 UICollectionViewDataSource 프로토콜을 준수하므로 따로 상속해주지 않아도 된다.
extension FeedController {
    
    //지정된 섹션에 표시할 항목의 개수
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    //컬렉션뷰의 지정된 위치에 표시할 셀을 요청하는 메서드.
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //셀 참조 값 가져오기
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! FeedCell
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension FeedController: UICollectionViewDelegateFlowLayout {
    //셀 크기 조정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 200)
    }
}
