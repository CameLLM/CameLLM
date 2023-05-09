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
