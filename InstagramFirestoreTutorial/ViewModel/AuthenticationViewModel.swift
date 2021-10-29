//
//  AuthenticationViewModel.swift
//  InstagramFirestoreTutorial
//
//  Created by 안현정 on 2021/10/29.
//

import UIKit

struct LoginViewModel {
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

struct RegistrationViewModel {
    
}
