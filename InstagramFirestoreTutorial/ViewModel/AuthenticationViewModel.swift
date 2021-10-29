//
//  AuthenticationViewModel.swift
//  InstagramFirestoreTutorial
//
//  Created by 안현정 on 2021/10/29.
//

import UIKit

protocol FormViewModel {
    func updateForm()
}

//로그인,회원가입에서 쓰이는 공통 속성을 프로토콜로 만들기
//어떤 구조체든 이 프로토콜 내 3가지 속성을 준수해야함
protocol AuthenticationViewModel {
    var formIsValid: Bool { get }
    var buttonBackgroundColor: UIColor { get }
    var buttonTitleColor: UIColor { get }
}

struct LoginViewModel: AuthenticationViewModel {
    var email: String?
    var password: String?
    
    //formIsValid -> 버튼 비활성화 / isEmpty -> 값이 비었는지 안비었는지
    //email,password 중 하나라도 값이 없다면 false처리
    var formIsValid: Bool {
        return email?.isEmpty == false && password?.isEmpty == false
    }
    
    //버튼 색깔 활성화
    var buttonBackgroundColor: UIColor {
        return formIsValid ? #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1) : #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1).withAlphaComponent(0.5)
        //formIsValid가 true면 진한 purple, flase면 연한 purple (if문보다 더 간결한 삼항연산자)
    }
    
    //버튼 타이틀색깔 활성화
    var buttonTitleColor: UIColor {
        return formIsValid ? .white : UIColor(white: 1, alpha: 0.67)
    }
}

struct RegistrationViewModel: AuthenticationViewModel {
    var email: String?
    var password: String?
    var fullname: String?
    var username: String?
    
    var formIsValid: Bool {
        return email?.isEmpty == false && password?.isEmpty == false
            && fullname?.isEmpty == false && username?.isEmpty == false
    }
    
    var buttonBackgroundColor: UIColor {
        return formIsValid ? #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1) : #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1).withAlphaComponent(0.5)

    }
    
    var buttonTitleColor: UIColor {
        return formIsValid ? .white : UIColor(white: 1, alpha: 0.67)

    }
}
