//
//  RegistrationController.swift
//  InstagramFirestoreTutorial
//
//  Created by 안현정 on 2021/10/27.
//

import UIKit

class RegistrationController: UIViewController {

    //MARK:- Properties
    
    //model-1. 회원가입 Model
    private var viewModel = RegistrationViewModel()
    
    //사진 추가 버튼 프로퍼티
    private let plushPhotoButton : UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "plus_photo"), for: .normal)
        button.tintColor = .white
        return button
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
    
    //fullname 텍스트필드 프로퍼티
    private let fullnameTextField = CustomTextField(placeholder: " Fullname")
    
    //username 텍스트필드 프로퍼티
    private let usernameTextField = CustomTextField(placeholder: " Username")
    
    //가입 버튼 프로퍼티
    private let signUpButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign Up", for: .normal) //버튼 타이틀 설정
        button.setTitleColor(.white, for: .normal) //버튼 타이틀 색깔
        button.backgroundColor = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1) //버튼 배경색 -> ColorLiteral 사용
        button.layer.cornerRadius = 5 //버튼 모서리 설정
        button.setHeight(50) //버튼 높이 설정
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        return button
    }()
    
    //alreadyHaveAccountButton 프로퍼티
    private let alreadyHaveAccountButton: UIButton = {
        let button = UIButton(type: .system)
        button.attributedTitle(firstPart: "Already have an account?", secondPart: "Sign Up")
        button.addTarget(self, action: #selector(handleShowSignUp), for: .touchUpInside)
        //self는 LoginController 참조
        return button
    }()
    
    
    
    //MARK:- Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureNotificationObservers()

    }
    
    //MARK: - Actions
    @objc func handleShowSignUp() {
        //popViewController를 하게되면 ViewController stack에서 사라지게 됨
        //stack에 쌓여있는 이전 ViewController로 이동
        navigationController?.popViewController(animated: true)
        print("DEBUG: Show login here")
    }
    
    
    //model-3. 텍스트 변경 액션 메서드
    @objc func textDidChange(sender: UITextField) { //이메일,패스워드 텍스트필드 구분 -> sender
        if sender == emailTextField { //emailTextField 작성할 경우,
            viewModel.email = sender.text //viewmodel의 email 값은 sender이 작성한 텍스트 값이 된다.
        } else if sender == passwordTextField { //패스워드 텍스트필드 작성 중일 경우,
            viewModel.password = sender.text //viewmodel의 password 값은 sender이 작성한 텍스트 값이 된다.
        } else if sender == fullnameTextField {
            viewModel.fullname = sender.text
        } else {
            viewModel.username = sender.text
        }
        
        updateForm()
    }
    
    
    //MARK: - Helpers
    
    func configureUI() {
        //그라데이션 배경색 지정
        configureGradientLayer()
        
        view.addSubview(plushPhotoButton)
        plushPhotoButton.centerX(inView: view) //x축 중심
        plushPhotoButton.setDimensions(height: 140, width: 140) //높이,너비 설정
        plushPhotoButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 32)
        
        //email,password,fullname,username TextField,signUpButton 스택뷰 생성 + 뷰 추가
        let stack = UIStackView(arrangedSubviews: [emailTextField, passwordTextField,
                                                   fullnameTextField, usernameTextField, signUpButton ])
        stack.axis = .vertical //세로축
        stack.spacing = 20
        
        view.addSubview(stack)
        stack.anchor(top: plushPhotoButton.bottomAnchor, left: view.leftAnchor,
                     right: view.rightAnchor, paddingTop: 32, paddingLeft: 32, paddingRight: 32)
        
        //alreadyHaveAccountButton 뷰 추가
        view.addSubview(alreadyHaveAccountButton)
        alreadyHaveAccountButton.centerX(inView: view)
        alreadyHaveAccountButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor)
        
    }
    
    //model-2. email,password TextField에서 텍스트가 변경될 때 마다 호출되는 메서드
    func configureNotificationObservers() {
        emailTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        fullnameTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        usernameTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }

}

// MARK:- FormViewModel

extension RegistrationController : FormViewModel {
    func updateForm() {

        signUpButton.backgroundColor = viewModel.buttonBackgroundColor
        signUpButton.setTitleColor(viewModel.buttonTitleColor, for: .normal)
        
        //이메일,패스워드 값을 입력하면(양식이 맞으면) 버튼 활성화
        //이 코드가 없으면, 이메일,패스워드 값 입력해도 버튼 활성화가 되지않는다.
        signUpButton.isEnabled = viewModel.formIsValid
        
        print("DEBUG: Form is valid \(viewModel.formIsValid)")
    }
    
}
