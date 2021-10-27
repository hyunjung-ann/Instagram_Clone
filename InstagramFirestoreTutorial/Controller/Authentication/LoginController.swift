//
//  LoginController.swift
//  InstagramFirestoreTutorial
//
//  Created by 안현정 on 2021/10/27.
//

import UIKit

class LoginController: UIViewController {

    //MARK:- Properties
    
    //인스타그램 로고 프로퍼티
    private let iconImage : UIImageView = {
    let iv = UIImageView(image: #imageLiteral(resourceName: "Instagram_logo_white"))
        iv.contentMode = .scaleToFill
    
    return iv
    }()
    
    //email 텍스트필드 프로퍼티
    private let emailTextField: UITextField = {
       let tf = UITextField()
        tf.borderStyle = .none //테두리(border)의 모양을 정하는 속성, 기본값이 none
        tf.textColor = .white
        tf.keyboardAppearance = .dark
        tf.keyboardType = .emailAddress
        tf.backgroundColor = UIColor(white: 1, alpha: 0.1) //투명하게 처리(불투명도 색상 개체)
        // NSAttributedString 클래스: text의 여러 속성들을 바꿔 줄 때 사용
        tf.attributedPlaceholder = NSAttributedString(string: " Email",
                                                      attributes: [.foregroundColor: UIColor(white: 1,
                                                                                             alpha: 0.7)])
        tf.setHeight(50)
       return tf
    }()
    
    //password 텍스트필드 프로퍼티
    private let passwordTextField: UITextField = {
       let tf = UITextField()
        tf.borderStyle = .none //테두리(border)의 모양을 정하는 속성, 기본값이 none
        tf.textColor = .white
        tf.keyboardAppearance = .dark
        tf.keyboardType = .emailAddress
        tf.backgroundColor = UIColor(white: 1, alpha: 0.1) //투명하게 처리(불투명도 색상 개체)
        // NSAttributedString 클래스: text의 여러 속성들을 바꿔 줄 때 사용
        tf.attributedPlaceholder = NSAttributedString(string: " Password",
                                                      attributes: [.foregroundColor: UIColor(white: 1,
                                                                                             alpha: 0.7)])
        tf.isSecureTextEntry = true //텍스트 필드에 입력된 문자가 *로 표시되도록 설정
        tf.setHeight(50)
       return tf
    }()
    
    //로그인 버튼 프로퍼티
    private let loginButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Log In", for: .normal) //버튼 타이틀 설정
        button.setTitleColor(.white, for: .normal) //버튼 타이틀 색깔
        button.backgroundColor = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1) //버튼 배경색 -> ColorLiteral 사용
        button.layer.cornerRadius = 5 //버튼 모서리 설정
        button.setHeight(50) //버튼 높이 설정
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        return button
    }()
    
    //forgotPasswordButton 프로퍼티
    private let forgotPasswordButton: UIButton = {
        let button = UIButton(type: .system)
        let atts: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor(white: 1, alpha: 0.7),
                                                   .font: UIFont.systemFont(ofSize: 16)] //문자열 속성

        let attributedTitle = NSMutableAttributedString(string: "Forgot your password? ", attributes: atts)
        let boldAtts: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor(white: 1, alpha: 0.7),
                                                   .font: UIFont.boldSystemFont(ofSize: 16)] //문자열 속성
        attributedTitle.append(NSAttributedString(string: "Get help signing in.", attributes: boldAtts))

        //3. setAttributedTitle을 이용해 UIButton에 적용
        button.setAttributedTitle(attributedTitle, for: .normal)
        return button
    }()
    
    
    //dontHaveAccountButton 프로퍼티
    private let dontHaveAccountButton: UIButton = {
        let button = UIButton(type: .system)
        //NSAttributedString 문자열 객체는 부분적으로 각기 다른 세부 텍스트 설정 가능
        //1. 한 글자에 여러개의 Attributes가 적용될 수 있기 때문에, [NSAttributedString.Key: Any] 타입의 Dictionary 사용
        let atts: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor(white: 1, alpha: 0.7),
                                                   .font: UIFont.systemFont(ofSize: 16)] //문자열 속성
        //2. title을 NSMutableAttributedString로 바꿔서 attributedTitle에 저장
        //attributedTitle 옵션을 추가하고 수정할 것이기 때문에 변경가능한 NSMutableAttributedString 개체 이용
        let attributedTitle = NSMutableAttributedString(string: "Don't have an account?  ", attributes: atts)
        
        
        let boldAtts: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor(white: 1, alpha: 0.7),
                                                   .font: UIFont.boldSystemFont(ofSize: 16)] //문자열 속성
        attributedTitle.append(NSAttributedString(string: "Sign Up", attributes: boldAtts))
        
        //3. setAttributedTitle을 이용해 UIButton에 적용
        button.setAttributedTitle(attributedTitle, for: .normal)
        
        return button
    }()
    
    
    //MARK:- Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemRed
        
        configureUI()
    }
    
    //MARK:- Helpers
    
    func configureUI() {
        view.backgroundColor = .white
        //네비게이션바 숨기기
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black
        
        //배경 그라데이션 넣어주기
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.systemPurple.cgColor, UIColor.systemBlue.cgColor] //그라데이션 색상
        gradient.locations = [0,1] //두 색의 경계 정해주기(각 gradient이 멈추는 location)
        view.layer.addSublayer(gradient)
        gradient.frame = view.frame
        
        //인스타그램 로고 뷰에 추가
        view.addSubview(iconImage)
        iconImage.centerX(inView: view) //뷰 중앙에 배치
        iconImage.setDimensions(height: 80, width: 130)
        iconImage.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 32 ) //상단고정
        
        //email,password TextField,loginButton,forgotPasswordButton 스택뷰 생성 + 뷰 추가
        let stack = UIStackView(arrangedSubviews: [emailTextField, passwordTextField,
                                                   loginButton, forgotPasswordButton])
        stack.axis = .vertical //세로축
        stack.spacing = 20
        
        view.addSubview(stack)
        stack.anchor(top: iconImage.bottomAnchor, left: view.leftAnchor,
                     right: view.rightAnchor, paddingTop: 32, paddingLeft: 32, paddingRight: 32)
        
        //dontHaveAccountButton 뷰 추가
        view.addSubview(dontHaveAccountButton)
        dontHaveAccountButton.centerX(inView: view)
        dontHaveAccountButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor)
        
    }


}
