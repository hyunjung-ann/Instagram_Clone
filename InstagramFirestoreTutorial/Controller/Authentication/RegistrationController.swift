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
        //ImagePicker(1). handleProfilePhotoSelect 액션 추가
        button.addTarget(self, action: #selector(handleProfilePhotoSelect), for: .touchUpInside)
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
    
    //ImagePicker(2). picker 를 보여줄 'handleProfilePhotoSelect' 메소드 정의
    @objc func handleProfilePhotoSelect() {
        
        //전역 변수로 imagePicker 생성
        //UIImagePickerController를 사용해 이미지 수정 및 가져오기
        let picker = UIImagePickerController()
        
        //self는 RegistrationController, self를 picker.delegate에 할당하려면 self는 UINavigationControllerDelegate 타입이어야 한다. 그래서 아래 익스텐션으로 상속해줌
        picker.delegate = self
        picker.allowsEditing = true
        
        //간단히 present만으로 imagePickerController를 띄울수 있다.
        present(picker, animated: true, completion: nil)
        
        print("DEBUG: Show Photo library here...")
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

// MARK:- UIImagePickerControllerDelegate

/*UIImagePickerController를 사용하기 위해서는 UIImagePickerControllerDelegate,UINavigationControllerDelegate 상속받아야한다.
- UIImagePickerControllerDelegate = 이미지를 선택하고 카메라를 찍었을 때 다양한 동작을 도와줌
- UINavigationControllerDelegate = 앨범 사진을 선택했을 때, 화면 전환을 네비게이션으로 이동
*/

//카메라나 앨범등 PickerController가 사용되고 이미지 촬영을 했을 때 발동 된다.
extension RegistrationController: UIImagePickerControllerDelegate,  UINavigationControllerDelegate {
    
    //picking을 했을때 이미지 적용 기능 -> 이 메서드가 없으면 사진 선택을 해도 프로필이미지 버튼에 적용이 안됨
    //Dictionary 타입은 info에 정보들이 들어옴
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        //1. 카메라나 앨범에서 사용하기 버튼을 눌렀을 때, info에 설정 때 따라서 image가 selectImage에 저장
        guard let selectImage = info[.editedImage] as? UIImage else { return }
        
        //2.앨범에서 선택한 사진을 적용할 때, 버튼 속성
        plushPhotoButton.layer.cornerRadius = plushPhotoButton.frame.width / 2
        plushPhotoButton.layer.masksToBounds = true // Layer에 경계에 맞추어 내용이 잘림
        plushPhotoButton.layer.borderColor = UIColor.white.cgColor //테두리 색
        plushPhotoButton.layer.borderWidth = 2 //테두리 굵기
        plushPhotoButton.setImage(selectImage.withRenderingMode(.alwaysOriginal), for: .normal)
        //image rendering mode : 원본(Originals)이미지에서 컬러 정보가 모두 보이게함
        
        //3. dismiss해주지 않으면 choose한 후, imagePickerController가 사라지지않고 뷰에 계속 머물러있음
        self.dismiss(animated: true, completion: nil)
    }
}
