//
//  CodableExtension.swift
//
//
//  Created by Onur Var on 1.02.2023.
//

import Foundation

public extension Encodable {
    func toDictionary() -> [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else {
            return nil
        }
        guard let dictionary = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
            return nil
        }

        return dictionary
    }

    func toQueryParameters() -> [URLQueryItem] {
        guard let dictionary = toDictionary() else {
            return []
        }

        var queryParameters: [URLQueryItem] = []
        for item in dictionary {
            if let value = item.value as? String {
                queryParameters.append(URLQueryItem(name: item.key, value: value))
            } else if let value = item.value as? Int {
                queryParameters.append(URLQueryItem(name: item.key, value: "\(value)"))
            } else if let value = item.value as? Double {
                queryParameters.append(URLQueryItem(name: item.key, value: "\(value)"))
            }
        }

        return queryParameters.sorted { item1, item2 in item1.name < item2.name }
    }

    func toJSONData() -> Data? {
        return try? JSONEncoder().encode(self)
    }

    func toJSONString() -> String? {
        guard let jsonData = toJSONData(), let jsonString = String(data: jsonData, encoding: .utf8) else {
            return nil
        }

        return jsonString
    }
}
