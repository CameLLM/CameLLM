//
//  ChainedConversionStep.swift
//
//
//  Created by Alex Rozanski on 09/04/2023.
//

import Foundation

public protocol ChainedConversionStep<StepType, InputType, OutputType> {
  associatedtype StepType
  associatedtype InputType
  associatedtype OutputType

  var steps: [AnyConversionStep<StepType>] { get }

  func execute(with input: InputType) async throws -> Result<ModelConversionStatus<OutputType>, Error>
  func cancel()
  func skip()

  func cleanUp() async throws
}

public func chainFront<StepType, NewInputType, InputType, OutputType>(
  _ front: ModelConversionStep<StepType, NewInputType, InputType>,
  _ step: any ChainedConversionStep<StepType, InputType, OutputType>
) -> any ChainedConversionStep<StepType, NewInputType, OutputType> {
  return ConnectedConversionStep<StepType, NewInputType, InputType, OutputType>(input: front, output: step)
}

public class UnconnectedConversionStep<StepType, InputType, OutputType>: ChainedConversionStep {
  private let step: ModelConversionStep<StepType, InputType, OutputType>

  public init(step: ModelConversionStep<StepType, InputType, OutputType>) {
    self.step = step
  }

  public var steps: [AnyConversionStep<StepType>] {
    return [AnyConversionStep(wrapped: step)]
  }

  public func execute(with input: InputType) async throws -> Result<ModelConversionStatus<OutputType>, Error> {
    return try await step.execute(with: input)
  }

  public func cancel() {
    step.cancel()
  }

  public func skip() {
    step.skip()
  }

  public func cleanUp() async throws {
    return try await step.cleanUp()
  }
}

public class ConnectedConversionStep<StepType, InputType, IO, OutputType>: ChainedConversionStep {
  private let input: ModelConversionStep<StepType, InputType, IO>
  private let output: any ChainedConversionStep<StepType, IO, OutputType>

  public var steps: [AnyConversionStep<StepType>] {
    return [AnyConversionStep(wrapped: input)] + output.steps
  }

  public init(input: ModelConversionStep<StepType, InputType, IO>, output: any ChainedConversionStep<StepType, IO, OutputType>) {
    self.input = input
    self.output = output
  }

  public func execute(with input: InputType) async throws -> Result<ModelConversionStatus<OutputType>, Error> {
    let status = try await self.input.execute(with: input)
    if self.input.state.isCancelled {
      output.skip()
      return .success(.failure(exitCode: 1))
    }

    switch status {
    case .success(let status):
      switch status {
      case .success(result: let result):
        return try await output.execute(with: result)
      case .failure(exitCode: let exitCode):
        output.skip()
        return .success(.failure(exitCode: exitCode))
      case .cancelled:
        return .success(.cancelled)
      }
    case .failure(let error):
      return .failure(error)
    }
  }

  public func cancel() {
    input.cancel()
    output.cancel()
  }

  public func skip() {
    input.skip()
    output.skip()
  }

  public func cleanUp() async throws {
    // wrap these in do {} blocks otherwise one failing to clean up will prevent the rest of the
    // chain from cleaning up.
    do {
      try await input.cleanUp()
    } catch {
      print("WARNING: failed to clean up conversion step", input.type)
    }

    do {
      try await output.cleanUp()
    } catch {
      print("WARNING: failed to clean up conversion step", input.type)
    }
  }
}
