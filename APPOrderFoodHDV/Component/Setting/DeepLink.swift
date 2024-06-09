//
//  DeepLink.swift
//  APPOrderFoodHDV
//
//  Created by Tran Viet Anh on 6/6/24.
//

import Foundation
import SwiftUI


enum DeepLinkOption {
    case email(String), phone(String)
    
    var url: (app: URL?, site: URL?) {
        switch self {
        case .email(let address):
            return (app: URL(string: "mailto:\(address)"),
                    site: nil)
        case .phone(let number):
            return (app: URL(string: "tel://\(number)"),
                    site: nil)
        }
    }
}
final class DeepLinkService {
    func openURL(type: DeepLinkOption, openURLAction: OpenURLAction) {
        guard let appURL = type.url.app else { return }
        openURLAction.callAsFunction(appURL) { accepted in
            if !accepted {
                guard let siteURL = type.url.site else { return }
                openURLAction.callAsFunction(siteURL)
            }
        }
    }
}
