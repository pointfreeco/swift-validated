@_exported import NonEmpty

/// A result type that accumulates multiple errors.
public enum Validated<Value, Error> {

  /// Wraps a value that has passed validation.
  case valid(Value)

  /// Collects a non-empty array of errors due to validation failure.
  case invalid(NonEmptyArray<Error>)

  /// Fail with a validation error.
  ///
  /// - Parameter error: A single validation error.
  /// - Returns: The error, wrapped in a validated value.
  public static func error(_ error: Error) -> Validated {
    return .invalid(NonEmptyArray(error))
  }

  /// Returns true for valid values.
  public var isValid: Bool {
    switch self {
    case .valid:
      return true
    case .invalid:
      return false
    }
  }

  /// Returns a valid value (or `nil`, when invalid).
  public var value: Value? {
    switch self {
    case let .valid(value):
      return value
    case .invalid:
      return nil
    }
  }

  /// Returns a non-empty array of errors (or `nil`, when valid).
  public var errors: NonEmptyArray<Error>? {
    switch self {
    case .valid:
      return nil
    case let .invalid(errors):
      return errors
    }
  }

  /// Case analysis to produce the same type. "Folds" a validated value into some other value.
  ///
  /// - Parameters:
  ///   - ifValid: A function that transforms a valid value into some other value.
  ///   - ifInvalid: A function that transforms a non-empty array of errors into some other value.
  /// - Returns: The result of the transformation.
  public func validate<ValueOfResult>(
    ifValid: (Value) -> ValueOfResult,
    ifInvalid: (NonEmptyArray<Error>) -> ValueOfResult
    )
    -> ValueOfResult {
      switch self {
      case let .valid(value):
        return ifValid(value)
      case let .invalid(errors):
        return ifInvalid(errors)
      }
  }

  /// Transforms a valid value into some other valid value.
  ///
  /// - Parameter transform: A transform function for valid values.
  /// - Returns: A new validated value.
  public func map<ValueOfResult>(_ transform: (Value) -> ValueOfResult) -> Validated<ValueOfResult, Error> {
    switch self {
    case let .valid(value):
      return .valid(transform(value))
    case let .invalid(errors):
      return .invalid(errors)
    }
  }
}

extension Validated: Equatable where Value: Equatable, Error: Equatable {
  public static func == (lhs: Validated, rhs: Validated) -> Bool {
    switch (lhs, rhs) {
    case let (.valid(value1), .valid(value2)):
      return value1 == value2
    case let (.invalid(errors1), .invalid(errors2)):
      return errors1 == errors2
    case (.valid, .invalid), (.invalid, .valid):
      return false
    }
  }
}

/// Zips multiple validated values together, accumulating errors if both sides are invalid.
///
/// - Parameters:
///   - validated1: A validated value (or errors).
///   - validated2: A second, validated value (or errors).
/// - Returns: A validated tuple of the first and second value (or the accumulation of any errors).
public func zip<Value1, Value2, Error>(
  _ validated1: Validated<Value1, Error>,
  _ validated2: Validated<Value2, Error>
  )
  -> Validated<(Value1, Value2), Error> {

    switch (validated1, validated2) {
    case let (.valid(value1), .valid(value2)):
      return .valid((value1, value2))
    case let (.valid, .invalid(errors)):
      return .invalid(errors)
    case let (.invalid(errors), .valid):
      return .invalid(errors)
    case let (.invalid(errors1), .invalid(errors2)):
      return .invalid(errors1 + errors2)
    }
}

/// Lifts a function that takes two values and returns a result into a function that takes two validated
/// values and returns a validated result.
///
/// - Parameter transform: A tranform function that takes two values and returns a result.
/// - Returns: A function that takes two validated values and returns a validated result.
public func zip<Value1, Value2, ValueOfResult, Error>(
  with transform: @escaping (Value1, Value2) -> ValueOfResult
  )
  -> (Validated<Value1, Error>, Validated<Value2, Error>)
  -> Validated<ValueOfResult, Error> {

    return { zip($0, $1).map(transform) }
}
