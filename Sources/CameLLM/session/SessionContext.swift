//
//  SessionContext.swift
//
//
//  Created by Alex Rozanski on 23/04/2023.
//

import Foundation
import CameLLMObjCxx

public class SessionContext {
  public struct Token {
    private let objCxxToken: _SessionContextToken

    public var value: Int32 { return objCxxToken.token }
    public var string: String { return objCxxToken.string }

    internal init(objCxxToken: _SessionContextToken) {
      self.objCxxToken = objCxxToken
    }
  }

  public private(set) lazy var tokens: [Token]? = {
    return objCxxContext.tokens?.map { Token(objCxxToken: $0) }
  }()

  public var contextString: String? {
    return objCxxContext.contextString
  }

  private let objCxxContext: _SessionContext

  public init(objCxxContext: _SessionContext) {
    self.objCxxContext = objCxxContext
  }
}

