//
//  StringExtension.swift
//  VIPER
//
//  Created by Manuel Alfonso Terol on 04/11/2020.
//

import Foundation
import LanguageManager_iOS

extension String {
    /// Localizable strings
    ///
    /// - Returns: a string form localizable files
    func localizedString() -> String {
        let bundle = Bundle.main.path(forResource: LanguageManager.shared.currentLanguage.rawValue,
                                      ofType: "lproj") ?? ""
        return NSLocalizedString(self,
                                 tableName: nil,
                                 bundle: Bundle(path: bundle) ?? Bundle.main,
                                 value: "",
                                 comment: "localizable string: \(self)")
    }
}
