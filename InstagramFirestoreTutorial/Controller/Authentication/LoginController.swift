//
//  LoginController.swift
//  InstagramFirestoreTutorial
//
//  Created by 안현정 on 2021/10/27.
//

import UIKit

class LoginController: UIViewController {

    //MARK:- Properties
    
    //로그인 모델 인스턴스 생성
    private var viewModel = LoginViewModel()
    
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
        button.backgroundColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1).withAlphaComponent(0.5) //버튼 배경색 -> ColorLiteral 사용 + 불투명도 0.5
        button.layer.cornerRadius = 5 //버튼 모서리 설정
        button.setHeight(50) //버튼 높이 설정
        button.isEnabled = false //false로 비활성화된 컨트롤은 터치 이벤트를 무시
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
        button.addTarget(self, action: #selector(handleShowSignUp), for: .touchUpInside)
        //self는 LoginController 참조
        return button
    }()
    
    
    //MARK:- Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemRed
        
        configureUI()
        configureNotificationObservers() //2. 호출
    }
    
    //MARK:- Actions
    
    //화면전환 액션 메서드
    @objc func handleShowSignUp() {
        //RegistrationController 인스턴스 저장
        let controller = RegistrationController()
        //NavigationController 사용하여 RegistrationController로 화면전환(먼저 Navigation Controller를 embed in)
        navigationController?.pushViewController(controller, animated: true)
        print("DEBUG: Show sign up here")
        
    }
    
    //3. 텍스트 변경 액션 메서드
    @objc func textDidChange(sender: UITextField) { //이메일,패스워드 텍스트필드 구분 -> sender
        if sender == emailTextField { //emailTextField 작성할 경우,
            viewModel.email = sender.text //viewmodel의 email 값은 sender이 작성한 텍스트 값이 된다.
        } else { //패스워드 텍스트필드 작성 중일 경우,
            viewModel.password = sender.text //viewmodel의 password 값은 sender이 작성한 텍스트 값이 된다.
        }
        
        //버튼 활성화 관련 viewmodel 프로토콜 준수한 함수 호출
        updateForm()
    
    }
    
    
    //MARK:- Helpers
    
    func configureUI() {
        //그라데이션 배경 메서드
        configureGradientLayer()
        
        view.backgroundColor = .white
        //네비게이션바 숨기기
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black
        
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
    
    //1. email,password TextField에서 텍스트가 변경될 때 마다 호출되는 메서드
    func configureNotificationObservers() {
        emailTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }


}

// MARK:- FormViewModel

//AuthenticationViewModel -> 프로토콜 'FormViewModel' 준수  (프로토콜 개념 이해하기!)
extension LoginController : FormViewModel {
    func updateForm() {
        
        //viewmodel backgroundColor,setTitleColor
        loginButton.backgroundColor = viewModel.buttonBackgroundColor
        loginButton.setTitleColor(viewModel.buttonTitleColor, for: .normal)
        
        //이메일,패스워드 값을 입력하면(양식이 맞으면) 버튼 활성화
        //이 코드가 없으면, 이메일,패스워드 값 입력해도 버튼 활성화가 되지않는다.
        loginButton.isEnabled = viewModel.formIsValid
        
        print("DEBUG: Form is valid \(viewModel.formIsValid)")
    }
    
    
}
