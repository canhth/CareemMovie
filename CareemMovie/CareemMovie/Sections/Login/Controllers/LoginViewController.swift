//
//  LoginViewController.swift
//  ListingRestaurant
//
//  Created by Canh Tran on 2/27/18.
//  Copyright © 2018 Tran Hoang Canh. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class LoginViewController: UIViewController {

    // MARK: Properties
    let disposeBag = DisposeBag()
    
    /* We will use Material Lib for UITextField error handling
     In this project we don't need to use it yet. Keep it as simple as possible and try to use StackView
     */
    @IBOutlet weak var emailStackView: ValidateTextFieldStackView!
    @IBOutlet weak var passwordStackView: ValidateTextFieldStackView!
    
    @IBOutlet weak var loginButton: UIButton!
    
    private let loginViewModel = LoginViewModel()
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViewModel()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Setups viewcontroller
    private func setupViewModel() {
        
        loginViewModel.setupLoginViewModel(loginButtonTap: loginButton.rx.tap.asObservable())
        
        emailStackView.inputTextField.rx.textInput <-> loginViewModel.emailText
        passwordStackView.inputTextField.rx.textInput <-> loginViewModel.passwordText
        
        loginViewModel.isEnableNextButton
            .subscribe(onNext: { [weak self] valid  in
                self?.loginButton.isEnabled = valid
                self?.loginButton.alpha = valid ? 1.0 : 0.5
            }).disposed(by: disposeBag)
        
        loginViewModel.validatedEmail
            .subscribe(onNext: { [weak self] (result) in
                guard let strongSelf = self else { return }

                switch result {
                case .ok:
                    strongSelf.emailStackView.setupErrorMessageView(isHidden: true, errorMessage: "")
                    break;
                case let .failed(message), let .empty(message):
                    strongSelf.emailStackView.setupErrorMessageView(isHidden: false, errorMessage: message)
                    break
                }
            }).disposed(by: disposeBag)

        loginViewModel.validatedPassword
            .subscribe(onNext: { [weak self] (result) in
                guard let strongSelf = self else { return }

                switch result {
                case .ok:
                    strongSelf.passwordStackView.setupErrorMessageView(isHidden: true, errorMessage: "")
                    break;
                case let .failed(message), let .empty(message):
                    strongSelf.passwordStackView.setupErrorMessageView(isHidden: false, errorMessage: message)
                    break
                }
            }).disposed(by: disposeBag)
        
        loginViewModel.isLoginSuccess
            .subscribe(onNext: { (isLoginSuccess) in
                if isLoginSuccess {
                    
                }
            }).disposed(by: disposeBag)
    }
  
}
