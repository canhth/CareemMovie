////
////  Operation+Extension.swift
////  CareemMovie
////
////  Created by Tran Hoang Canh on 28/2/18.
////  Copyright © 2018 Tran Hoang Canh. All rights reserved.
////
//
//import UIKit
//import RxSwift
//import RxCocoa
//
//// Tow way binding operator between control property and variable
//infix operator <-> : DefaultPrecedence
//
//func nonMarkedText(_ textInput: UITextInput) -> String? {
//    let start = textInput.beginningOfDocument
//    let end = textInput.endOfDocument
//
//    guard let rangeAll = textInput.textRange(from: start, to: end),
//        let text = textInput.text(in: rangeAll) else {
//            return nil
//    }
//
//    guard let markedTextRange = textInput.markedTextRange else {
//        return text
//    }
//
//    guard let startRange = textInput.textRange(from: start, to: markedTextRange.start),
//        let endRange = textInput.textRange(from: markedTextRange.end, to: end) else {
//            return text
//    }
//
//    return (textInput.text(in: startRange) ?? "") + (textInput.text(in: endRange) ?? "")
//}
//
//@discardableResult
//func <-> <Base: UITextInput>(textInput: TextInput<Base>, variable: Variable<String>) -> Disposable {
//    let bindToUIDisposable = variable.asObservable()
//        .bind(to: textInput.text)
//    let bindToVariable = textInput.text
//        .subscribe(onNext: { [weak base = textInput.base] n in
//            guard let base = base else {
//                return
//            }
//
//            let nonMarkedTextValue = nonMarkedText(base)
//
//            /**
//             In some cases `textInput.textRangeFromPosition(start, toPosition: end)` will return nil even though the underlying
//             value is not nil. This appears to be an Apple bug. If it's not, and we are doing something wrong, please let us know.
//             The can be reproed easily if replace bottom code with
//
//             if nonMarkedTextValue != variable.value {
//             variable.value = nonMarkedTextValue ?? ""
//             }
//             and you hit "Done" button on keyboard.
//             */
//            if let nonMarkedTextValue = nonMarkedTextValue, nonMarkedTextValue != variable.value {
//                variable.value = nonMarkedTextValue
//            }
//            }, onCompleted:  {
//                bindToUIDisposable.dispose()
//        })
//
//    return Disposables.create(bindToUIDisposable, bindToVariable)
//}
//
//@discardableResult
//func <-> <Base: UITextInput>(textInput: TextInput<Base>, variable: BehaviorSubject<String>) -> Disposable {
//    let bindToUIDisposable = variable.asObservable()
//        .bind(to: textInput.text)
//    let bindToVariable = textInput.text
//        .subscribe(onNext: { [weak base = textInput.base] n in
//            guard let base = base else {
//                return
//            }
//
//            let nonMarkedTextValue = nonMarkedText(base)
//
//            /**
//             In some cases `textInput.textRangeFromPosition(start, toPosition: end)` will return nil even though the underlying
//             value is not nil. This appears to be an Apple bug. If it's not, and we are doing something wrong, please let us know.
//             The can be reproed easily if replace bottom code with
//
//             if nonMarkedTextValue != variable.value {
//             variable.value = nonMarkedTextValue ?? ""
//             }
//             and you hit "Done" button on keyboard.
//             */
//            let variableValue = try! variable.value()
//            if let nonMarkedTextValue = nonMarkedTextValue, nonMarkedTextValue != variableValue {
//                variable.onNext(nonMarkedTextValue)
//            }
//            }, onCompleted:  {
//                bindToUIDisposable.dispose()
//        })
//
//    return Disposables.create(bindToUIDisposable, bindToVariable)
//}
//
//
