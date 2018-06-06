//
//  PhoneFormatter.swift
//  Clean-swift-article
//
//  Created by Anton Marunko on 31/05/2018.
//  Copyright © 2018 exyte. All rights reserved.
//

import Foundation

final class PhoneFormatter {
    static func format(sourcePhoneNumber: String) -> String? {
        // Remove any character that is not a number
        let numbersOnly = sourcePhoneNumber.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        let length = numbersOnly.count

        // Check for supported phone number length
        guard length == 7 || length == 10 else {
            return .none
        }

        let hasAreaCode = (length >= 10)
        var sourceIndex = 0

        // Area code
        var areaCode = ""
        if hasAreaCode {
            let areaCodeLength = 3
            guard let areaCodeSubstring = numbersOnly.substring(start: sourceIndex, offsetBy: areaCodeLength) else {
                return .none
            }
            areaCode = String(format: "(%@) ", areaCodeSubstring)
            sourceIndex += areaCodeLength
        }

        // Prefix, 3 characters
        let prefixLength = 3
        guard let prefix = numbersOnly.substring(start: sourceIndex, offsetBy: prefixLength) else {
            return .none
        }
        sourceIndex += prefixLength

        // Suffix, 4 characters
        let suffixLength = 4
        guard let suffix = numbersOnly.substring(start: sourceIndex, offsetBy: suffixLength) else {
            return .none
        }

        return areaCode + prefix + "-" + suffix
    }
}
