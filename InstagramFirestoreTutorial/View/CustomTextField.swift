//
//  CustomTextField.swift
//  InstagramFirestoreTutorial
//
//  Created by 안현정 on 2021/10/28.
//

import UIKit

class CustomTextField: UITextField {
    
        init(placeholder: String) { //이메일,패스워드 텍스트필드 차이점은 placeholder 이기 때문에 파라미터로 지정
            super.init(frame: .zero) //로그인컨트롤러에서 프레임 직접 생성할 것이기 때문
        
        //UITextField 에서 제공하는 양옆에 뷰를 추가할 수 있는 영역에 empty뷰를 넣어서 여백을 주는 방법
        let spacer = UIView()
            spacer.setDimensions(height: 50, width: 12)
            //leftView란? textField 자체에 왼쪽 뷰가 존재하는데 그 뷰가 기본적으로는 보이지 않는 모드 -> leftView를 항상 나타내서 padding 효과 줌
            leftView = spacer
            leftViewMode = .always
   
        borderStyle = .none //테두리(border)의 모양을 정하는 속성, 기본값이 none
        textColor = .white
        keyboardAppearance = .dark
        keyboardType = .emailAddress
        setHeight(50)
        backgroundColor = UIColor(white: 1, alpha: 0.1) //투명하게 처리(불투명도 색상 개체)
        // NSAttributedString 클래스: text의 여러 속성들을 바꿔 줄 때 사용
        attributedPlaceholder = NSAttributedString(string: placeholder, //원하는 textfield 전달 
                                                      attributes: [.foregroundColor: UIColor(white: 1,
                                                                                             alpha: 0.7)])
        
    
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
