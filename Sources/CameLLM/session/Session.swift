//
//  Session.swift
//  
//
//  Created by Alex Rozanski on 22/04/2023.
//

import Foundation

public protocol Session<SessionState, PredictionState> {
  associatedtype SessionState
  associatedtype PredictionState

  typealias StateChangeHandler = (SessionState) -> Void
  typealias TokenHandler = (String) -> Void
  typealias PredictionStateChangeHandler = (PredictionState) -> Void

  // MARK: - State

  var state: SessionState { get }
  var stateChangeHandler: StateChangeHandler? { get set }

  // MARK: - Prediction

  // Run prediction to generate tokens.
  func predict(with prompt: String) -> AsyncStream<String>

  // Supports state changes.
  func predict(
    with prompt: String,
    stateChangeHandler: @escaping PredictionStateChangeHandler,
    handlerQueue: DispatchQueue?
  ) -> AsyncStream<String>

  // Supports cancellation of prediction.
  func predict(
    with prompt: String,
    tokenHandler: @escaping TokenHandler,
    stateChangeHandler: @escaping PredictionStateChangeHandler,
    handlerQueue: DispatchQueue?
  ) -> PredictionCancellable

  // MARK: - Session Context

  var sessionContextProviding: SessionContextProviding { get }
}
