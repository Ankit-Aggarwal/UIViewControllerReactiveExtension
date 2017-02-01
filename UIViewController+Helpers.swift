//
//  UIViewController+Helpers.swift
//
//  Created by Ankit Aggarwal on 25/01/17.
//  Copyright © 2017 Ankit Aggarwal. All rights reserved.
//

import Foundation
import UIKit
import ReactiveSwift
import Result

extension UIViewController {
    typealias KeyboardStatusInfo =  (height: CGFloat , duration: TimeInterval  , animationOptions: UIViewAnimationOptions)

    func keyboardUpdatesSignal () -> Signal<KeyboardStatusInfo, NoError> {
        let center = NotificationCenter.default.reactive
        let willShowProducer = center.notifications(forName: .UIKeyboardWillShow).map(parsekeyboardNotification).skipNil()
        let willHideProducer = center.notifications(forName: .UIKeyboardWillHide).map(parsekeyboardNotification).skipNil()
        return Signal.merge([willShowProducer, willHideProducer])
    }

    func parsekeyboardNotification(notification: Notification) -> KeyboardStatusInfo? {
        guard let info = notification.userInfo else {
            return nil
        }
        guard let frame = (info[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return nil
        }

        let height = UIScreen.main.bounds.height - frame.origin.y  // height above screen

        guard let duration = info[UIKeyboardAnimationDurationUserInfoKey] as? TimeInterval else {
            return nil
        }

        guard let curveRaw = info[UIKeyboardAnimationCurveUserInfoKey] as? Int else {
            return nil
        }

        let curve = UIViewAnimationOptions(rawValue: UInt(curveRaw) << 16)

        return (height, duration, curve)
    }
}
