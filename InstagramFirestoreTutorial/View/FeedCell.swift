//
//  FeedCell.swift
//  InstagramFirestoreTutorial
//
//  Created by 안현정 on 2021/10/24.
//

import UIKit

class FeedCell: UICollectionViewCell {
    
    //MARK:-  Properties
    
    //2. 프로필 이미지 표시하기 위한 속성
    private let profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill //비율을 유지하면서 뷰의 사이즈에 맞게 이미지를 꽉 채우는 옵션
        iv.clipsToBounds = true //내 영역(Super View) 이외 영역의 Sub View는 Draw 하지 않는다
        iv.isUserInteractionEnabled = true //이벤트가 정상적으로 view에 전달
        iv.image = #imageLiteral(resourceName: "venom-7")
        return iv
    }()
    
    //3. 버튼 속성
    private lazy var usernameButton: UIButton = {
        let button = UIButton(type: .system) //버튼 initialize 해주기
        button.setTitleColor(.black, for: .normal) // 버튼 텍스트 색깔 설정
        button.setTitle("venum", for: .normal) //버튼 텍스트 설정
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 13) //폰트 사이즈
        button.addTarget(self, action: #selector(didTapUsername), for: .touchUpInside) //버튼이벤트 함수 넣어주기
        return button
    }()
    
    private let postImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill //비율을 유지하면서 뷰의 사이즈에 맞게 이미지를 늘리는 옵션
        iv.clipsToBounds = true //내 영역(Super View) 이외 영역의 Sub View는 Draw 하지 않는다
        iv.isUserInteractionEnabled = true //이벤트가 정상적으로 view에 전달
        iv.image = #imageLiteral(resourceName: "venom-7")
        return iv
    }()
    
    private lazy var likeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "like_unselected"), for: .normal)
        button.tintColor = .black
        return button
    }()
    
    private lazy var commentButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "comment"), for: .normal)
        button.tintColor = .black
        return button
    }()
    
    private lazy var shareButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "send2"), for: .normal)
        button.tintColor = .black
        return button
    }()
    
    
    //label 속성
    private let likesLabel: UILabel = {
       let label = UILabel()
        label.text = "I like"
        label.font = UIFont.boldSystemFont(ofSize: 13)
        return label
    }()
    
    private let captionLabel: UILabel = {
       let label = UILabel()
        label.text = "Some test caption for now"
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()

    private let postTimeLabel: UILabel = {
       let label = UILabel()
        label.text = "2 days ago"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .lightGray
        return label
    }()

    
    // MARK:- Lifecycle
    
    //1. UIView의 생성자 호출
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        
        //2-1.profileImageView를 뷰에 추가 (계층 구조에 추가)
        addSubview(profileImageView)  //addSubview를 통해 뷰를 포함시킬때 subview
        //2-2.제약조건 추가
        profileImageView.anchor(top: topAnchor, left: leftAnchor,
                                paddingTop: 12, paddingLeft: 12)
        profileImageView.setDimensions(height: 40, width: 40) // 높이 설정
        profileImageView.layer.cornerRadius = 40 / 2  // 모서리 둥글게 - 반경 2로 나누면 원형모양
        
        //3-2.usernameButton 뷰에 추가
        addSubview(usernameButton)
        //3-3.usernameButton 사용자 정의 제약조건 추가
        usernameButton.centerY(inView: profileImageView, leftAnchor: profileImageView.rightAnchor,
                               paddingLeft: 8)
        
        addSubview(postImageView)
        postImageView.anchor(top: profileImageView.bottomAnchor, left: leftAnchor,
                             right: rightAnchor, paddingTop: 8)
        postImageView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 1).isActive = true
        //제약을 주고싶은 아이템의 anchor 프로퍼티에 접근 -> heightAnchor
   
        configureActionButton()
        
        addSubview(likesLabel)
        likesLabel.anchor(top: likeButton.bottomAnchor, left: leftAnchor, paddingTop: -4, paddingLeft: 8)
        //leftAnchor는 절대적인 위치
        
        addSubview(captionLabel)
        captionLabel.anchor(top: likesLabel.bottomAnchor, left: leftAnchor, paddingTop: 8,  paddingLeft: 8)
        
        addSubview(postTimeLabel)
        postTimeLabel.anchor(top: captionLabel.bottomAnchor, left: leftAnchor, paddingTop: 8, paddingLeft: 8)
    }
      
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:- Actions
    
    //3-1. 버튼 액션 메소드 생성
    @objc func didTapUsername() {
        print("DEBUG: didTapUsername") //버튼마다 프린트 해주기!
    }
    
    //MARK:- Helpers

    func configureActionButton() {
        //StackView란 Auto Layout을 이용해 열 또는 행에 View들의 묶음을 배치할 수 있는 간소화된 인터페이스
        let stackView = UIStackView(arrangedSubviews: [likeButton,commentButton,shareButton])
        //arrangedSubviews 배열의 순서에 따라 StackView의 축(axis)을 따라 배치
        stackView.axis = .horizontal //가로 방향 축
        stackView.distribution = .fillEqually
        //fillEqually 플래그는 StackView의 Axis(축)에 따라 StackView를 채우기 위해 모든 Arrange Views들의 사이즈를 동일하게 재조정
        
        addSubview(stackView)
        stackView.anchor(top: postImageView.bottomAnchor, width: 120, height: 50) //위치 지정
    }
    
}
