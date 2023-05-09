//
//  ModelCard.swift
//  
//
//  Created by Alex Rozanski on 22/04/2023.
//

import Foundation

open class ModelCard {
  // The number of parameters the model was trained on.
  public let parameters: ParameterSize

  public init(parameters: ParameterSize) {
    self.parameters = parameters
  }
}
