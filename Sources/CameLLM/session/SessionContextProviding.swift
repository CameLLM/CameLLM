//
//  SessionContextProvider.swift
//  
//
//  Created by Alex Rozanski on 23/04/2023.
//

import Foundation

public typealias SessionContextProviderUpdatedContextHandler = (SessionContext) -> Void

public protocol SessionContextProvider: AnyObject {
  var updatedContextHandler: SessionContextProviderUpdatedContextHandler? { get set }
  
  func currentContext() async throws -> SessionContext?
}

public enum SessionContextProviding {
  case none
  case context(_ provider: SessionContextProvider)

  public var providesContext: Bool {
    switch self {
    case .none: return false
    case .context: return true
    }
  }

  public var provider: SessionContextProvider? {
    switch self {
    case .none: return nil
    case .context(let provider): return provider
    }
  }
}
