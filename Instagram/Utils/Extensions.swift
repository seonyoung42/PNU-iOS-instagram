//
//  UIApplication.swift
//  Instagram
//
//  Created by Sangkon Han on 2021/10/25.
//

import UIKit

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
