//
//  ModelConversion.swift
//  
//
//  Created by Alex Rozanski on 22/04/2023.
//

import Foundation

public struct ModelConversionFile {
  public let url: URL
  public let found: Bool

  public init(url: URL, found: Bool) {
    self.url = url
    self.found = found
  }
}

public enum ModelConversionStatus<ResultType> {
  case success(result: ResultType)
  case failure(exitCode: Int32)
  case cancelled

  public var result: ResultType? {
    switch self {
    case .success(result: let result):
      return result
    case .failure, .cancelled:
      return nil
    }
  }

  public var isSuccess: Bool {
    switch self {
    case .success:
      return true
    case .failure, .cancelled:
      return false
    }
  }

  public var exitCode: Int32 {
    switch self {
    case .success: return 0
    case .failure(exitCode: let exitCode): return exitCode
    case .cancelled: return 1
    }
  }
}

public protocol ModelConversionData<ValidationError> where ValidationError: Error {
  associatedtype ValidationError
}

public struct ValidatedModelConversionData<DataType> {
  public let validated: DataType

  // TODO: Only allow this to be instantiated inside plugins? Make this a protocol?
  public init(validated: DataType) {
    self.validated = validated
  }
}
