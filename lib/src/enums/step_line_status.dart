/// Enum representing the status of a step in the step indicator.
enum StepLineStatus {
  /// Indicates that the step is currently active.
  active,

  /// Indicates that the step has been completed.
  completed,

  /// Indicates that the step is inactive.
  inactive;

  /// Returns true if the step is active.
  bool get isActive => this == StepLineStatus.active;

  /// Returns true if the step is completed.
  bool get isCompleted => this == StepLineStatus.completed;

  /// Returns true if the step is inactive.
  bool get isInactive => this == StepLineStatus.inactive;

  /// Converts a string to an `ANStepLineStatus` enum value.
  ///
  /// If the string does not match any enum value,
  /// it defaults to `StepLineStatus.inactive`.
  static StepLineStatus fromString(String value) =>
      StepLineStatus.values.firstWhere(
        (status) => value.toLowerCase() == status.name,
        orElse: () => StepLineStatus.inactive,
      );
}
