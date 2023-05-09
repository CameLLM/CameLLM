//
//  ParameterSize.swift
//  
//
//  Created by Alex Rozanski on 09/05/2023.
//

import Foundation

public enum ParameterSize: Codable, Equatable {
  case millions(Decimal)
  case billions(Decimal)
}

public extension ParameterSize {
  static func from(string: String) -> ParameterSize? {
    let scanner = Scanner(string: string.trimmingCharacters(in: .whitespacesAndNewlines))
    guard let decimal = scanner.scanDecimal() else {
      return nil
    }

    if scanner.scanString("B") != nil {
      return .billions(decimal)
    } else if scanner.scanString("M") != nil {
      return .millions(decimal)
    }

    return nil
  }
}
