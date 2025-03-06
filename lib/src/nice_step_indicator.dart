import 'package:flutter/material.dart';
import 'package:nice_step_indicator/nice_step_indicator.dart';

/// A function that builds a widget for a step indicator item.
///
/// The [StepWidgetBuilder] typedef defines a function signature for building
/// a widget for a step indicator item. It takes the [BuildContext], the index
/// of the item, and the item itself as parameters.
typedef StepWidgetBuilder<T> = Widget Function(
  BuildContext context,
  int index,
  T item,
);

/// A function that determines the status of a step indicator item.
///
/// The [StepStatusBuilder] typedef defines a function signature for determining
/// the status of a step indicator item. It takes the item as a parameter and
/// returns a [StepLineStatus] value.
typedef StepStatusBuilder<T> = StepLineStatus Function(
  T item,
);

/// A widget that displays a series of step indicators.
///
/// The [NiceStepIndicator] widget is used to display
/// a series of step indicators with  customizable active and inactive colors
/// and a builder for the child widgets
class NiceStepIndicator<T> extends StatelessWidget {
  /// Creates a [NiceStepIndicator] widget.
  const NiceStepIndicator({
    required this.builder,
    required this.items,
    super.key,
    this.activeColor = const Color(0xFF3EAE78),
    this.dotOffset = 0,
    this.inactiveColor = const Color(0xFF666666),
    this.offset,
    this.status,
    this.strokeWidth = 3,
  });

  /// step active color
  final Color activeColor;

  ///the child widget builder
  final StepWidgetBuilder<T> builder;

  /// Optional offset for the dot indicator item
  final double dotOffset;

  /// step inactive color
  final Color inactiveColor;

  /// data to render in the steps
  final List<T> items;

  /// Optional offset for the step indicator item, providing
  /// padding around the step.
  final EdgeInsets? offset;

  ///the indicator status builder [StepLineStatus]
  final StepStatusBuilder<T>? status;

  /// width of the stroke
  final double strokeWidth;

  @override
  Widget build(BuildContext context) => NiceStepIndicatorProvider(
        controller: NiceStepIndicatorController<T>(
          steps: items,
          currentStep: items.firstWhere(
            (item) => status?.call(item) == StepLineStatus.active,
            orElse: () => items.first,
          ),
          //coverage:ignore-start
          nextStep: () {
            final controller =
                NiceStepIndicatorProvider.of<T>(context).controller;
            // TODO(Ethiel97): Implement the logic for the next step
          },
          previousStep: () {
            // TODO(Ethiel97): Implement the logic for the previous step
          },
          //coverage:ignore-end
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ...items.mapIndexed(
              (index, step) => NiceStepIndicatorItem(
                dotOffset: dotOffset,
                offset: offset,
                strokeWidth: strokeWidth,
                status: status?.call(items[index]) ?? StepLineStatus.inactive,
                nextStatus: (items.length - 1 == index)
                    ? status?.call(items[index]) ?? StepLineStatus.inactive
                    : status?.call(items[index + 1]) ?? StepLineStatus.inactive,
                activeColor: activeColor,
                inactiveColor: inactiveColor,
                isLast: index == items.length - 1,
                child: builder(
                  context,
                  index,
                  items[index],
                ),
              ),
            ),
          ],
        ),
      );
}
