//
//  StringExt.swift
//  Clean-swift-article
//
//  Created by Anton Marunko on 29/05/2018.
//  Copyright © 2018 exyte. All rights reserved.
//

import Foundation

extension String {
    var first: String {
        return String(prefix(1))
    }

    var last: String {
        return String(suffix(1))
    }

    var uppercaseFirst: String {
        return first.uppercased() + String(dropFirst())
    }

    internal func substring(start: Int, offsetBy: Int) -> String? {
        guard let substringStartIndex = self.index(startIndex, offsetBy: start, limitedBy: endIndex) else {
            return .none
        }

        guard let substringEndIndex = self.index(startIndex, offsetBy: start + offsetBy, limitedBy: endIndex) else {
            return .none
        }

        return String(self[substringStartIndex ..< substringEndIndex])
    }

    var numericOnlyValue: String {
        let unsafeChars = CharacterSet.decimalDigits.inverted
        let numericString = self.components(separatedBy: unsafeChars).joined()

        return numericString
    }
}
