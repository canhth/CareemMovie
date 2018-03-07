//
//  LoginViewModel.swift
//  ListingRestaurant
//
//  Created by Tran Hoang Canh on 28/2/18.
//  Copyright © 2018 Tran Hoang Canh. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import CT_RESTAPI

class LoginViewModel {
    
    // MARK: Properties
    let disposeBag = DisposeBag()
    private let validationService = DefaultValidationService.sharedValidationService
    
    fileprivate(set) var emailText          = Variable<String>("")
    fileprivate(set) var passwordText       = Variable<String>("")
    fileprivate(set) var isEnableNextButton: Observable<Bool>!
    fileprivate(set) var validatedEmail     = BehaviorSubject<ValidationResult>(value: .ok)
    fileprivate(set) var validatedPassword  = BehaviorSubject<ValidationResult>(value: .ok)
    fileprivate(set) var isLoginSuccess     = BehaviorSubject<Bool>(value: false)
    private var loginButtonTapped           = false
    
    // MARK: Functions
    
    func setupLoginViewModel(loginButtonTap: Observable<Void>) {
        let dataFlatmap = Observable.combineLatest(emailText.asObservable(), passwordText.asObservable()) { ($0, $1) }
        
        // To disable/enable login button
        isEnableNextButton = dataFlatmap.flatMapLatest { [weak self] (email, password) -> Observable<Bool> in
            guard let strongSelf = self else { return Observable.just(false) }
            
            let enable = !email.isEmpty && !password.isEmpty
            
            if strongSelf.loginButtonTapped {
                // Validate here and only after login button tapped in the first time
                strongSelf.validatedEmail.onNext(strongSelf.validationService.validateEmail(email))
                strongSelf.validatedPassword.onNext(strongSelf.validationService.validatePassword(password))
            }
            
            return Observable.just(enable)
        }
        
        // Login button tap action
        loginButtonTap.withLatestFrom(dataFlatmap).flatMapLatest { [weak self] (email, password) -> Observable<Bool> in
            guard let strongSelf = self else { return Observable.just(false) }
            strongSelf.loginButtonTapped = true
            
            // Validate email & password again
            let validationEmail = strongSelf.validationService.validateEmail(email)
            let validationPassword = strongSelf.validationService.validatePassword(password)
            
            let isPassedValidation = (validationEmail.isValid && validationPassword.isValid)
            if isPassedValidation {
                // Call API login here, but now force to loginSuccess
                strongSelf.isLoginSuccess.onNext(true)
                strongSelf.requestLoginAPI()
            } else {
                // Throw errors here
                strongSelf.validatedEmail.onNext(validationEmail)
                strongSelf.validatedPassword.onNext(validationPassword)
            }
            return Observable.just(isPassedValidation)
            }.subscribe(onNext: { (isValidated) in
                print("Login is validated \(isValidated)")
            }).disposed(by: disposeBag)
    }
    
    /* This is an example how to use my CT_RESTAPI
     */
    fileprivate func requestLoginAPI() {
        
        let apiManager = RESTApiClient(subPath: "login", functionName: "", method: .POST, endcoding: .URL)
        apiManager.setQueryParam(LoginParam(email: "takehome@2359media.com", password: "1Faraday@").dictionary)
        let obserable: Observable<User?> = apiManager.requestObject()
        obserable.subscribe(onNext: { (item) in
            print("Success")
        }, onError: { (error) in
            print("Error \(error)")
        }).disposed(by: disposeBag)
        
        // Save fake token of user after login success
        Helper.saveFakeToken(tokenString: "takehome@2359media.com-1Faraday@")
    }
    
}


class LoginParam: Codable {
    
    @objc var email: String = "hoangcanhsek6@gmail.com"
    @objc var password: String = "hoangcanh1"
    
    init(email: String, password: String) {
        self.email = email
        self.password = password
    }
}









