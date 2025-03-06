import 'package:flutter/material.dart';

/// A callback type definition for the Nice Step Indicator.
typedef NiceIndicatorCallback = void Function();

/// A controller class for managing the state
/// and actions of the Nice Step Indicator.
class NiceStepIndicatorController<T> {
  /// Creates a [NiceStepIndicatorController] with the given steps,
  /// current step,
  /// and callbacks for next and previous steps.
  NiceStepIndicatorController({
    required this.steps,
    required this.currentStep,
    required this.nextStep,
    required this.previousStep,
  });

  /// A list of steps of type [T].
  final List<T> steps;

  /// The current step of type [T].
  final T currentStep;

  /// A callback function to move to the next step.
  final NiceIndicatorCallback nextStep;

  /// A callback function to move to the previous step.
  final NiceIndicatorCallback previousStep;
}

/// An inherited widget that provides the [NiceStepIndicatorController]
/// to its descendants.
class NiceStepIndicatorProvider<T> extends InheritedWidget {
  /// Creates a [NiceStepIndicatorProvider] with the given controller
  /// and child widget.
  const NiceStepIndicatorProvider({
    required this.controller,
    required super.child,
    super.key,
  });

  /// The controller for the Nice Step Indicator.
  final NiceStepIndicatorController<T> controller;

  /// Retrieves the nearest [NiceStepIndicatorProvider] up the widget tree.
  static NiceStepIndicatorProvider<T> of<T>(BuildContext context) => context
      .dependOnInheritedWidgetOfExactType<NiceStepIndicatorProvider<T>>()!;

  //coverage:ignore-start
  @override
  bool updateShouldNotify(NiceStepIndicatorProvider<T> oldWidget) {
    return controller != oldWidget.controller;
  }
//coverage:ignore-end
}
