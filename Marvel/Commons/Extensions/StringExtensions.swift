//
//  StringExtensions.swift
//  Marvel
//
//  Created by RFG023ES on 23/5/22.
//

import UIKit

extension String {
    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
}
