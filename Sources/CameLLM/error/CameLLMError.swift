//
//  CameLLMError.swift
//
//
//  Created by Alex Rozanski on 22/04/2023.
//

import Foundation
import CameLLMObjCxx

public struct CameLLMError {
  public typealias Code = _CameLLMErrorCode
  public static let Domain = _CameLLMErrorDomain

  private init() {}
}
