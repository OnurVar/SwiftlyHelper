//
//  StringExtension.swift
//
//
//  Created by Onur Var on 1.02.2023.
//

import Foundation

public extension String {
    func toURL() -> URL? {
        return URL(string: self)
    }

    func rangeFromNSRange(nsRange: NSRange) -> Range<String.Index>? {
        return Range(nsRange, in: self)
    }

    func toDate(withFormat format: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.date(from: self)
    }
}
