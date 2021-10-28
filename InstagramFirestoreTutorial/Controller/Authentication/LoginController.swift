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
    private let emailTextField: CustomTextField = {
       let tf = CustomTextField(placeholder: " Email")
        tf.keyboardType = .emailAddress
       return tf
    }()
    
    //password 텍스트필드 프로퍼티
    private let passwordTextField: CustomTextField = {
       let tf = CustomTextField(placeholder: " Password")
        tf.isSecureTextEntry = true //텍스트 필드에 입력된 문자가 *로 표시되도록 설정
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
        button.attributedTitle(firstPart: "Forgot your password?", secondPart: "Get help signing in.")
        return button
    }()
    
    
    //dontHaveAccountButton 프로퍼티
    private let dontHaveAccountButton: UIButton = {
        let button = UIButton(type: .system)
        button.attributedTitle(firstPart: "Don't have an account?", secondPart: "Sign Up")
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
