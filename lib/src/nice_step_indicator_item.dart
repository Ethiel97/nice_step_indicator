import 'package:flutter/material.dart';
import 'package:nice_step_indicator/src/enums/enums.dart';

/// A widget that displays a step indicator with a custom painter.
///
/// The [NiceStepIndicatorItem] widget is used to display a step indicator with
/// customizable active and inactive colors, status, and stroke width.
class NiceStepIndicatorItem extends StatelessWidget {
  /// Creates a [NiceStepIndicatorItem] widget.
  const NiceStepIndicatorItem({
    required this.child,
    super.key,
    this.activeColor = const Color(0xFF3EAE78),
    this.dotOffset = 0,
    this.inactiveColor = const Color(0xFF666666),
    this.isLast = false,
    this.nextStatus = StepLineStatus.inactive,
    this.offset,
    this.status = StepLineStatus.inactive,
    this.strokeWidth = 3,
  });

  ///  active step color
  final Color activeColor;

  /// child widget
  final Widget child;

  /// Optional offset for the dot indicator item
  final double dotOffset;

  ///  inactive step color
  final Color inactiveColor;

  /// Indicates if this is the last item in the steps list.
  final bool isLast;

  ///next step status indicator
  final StepLineStatus nextStatus;

  /// Optional offset for the step indicator item, providing
  /// padding around the step.
  final EdgeInsets? offset;

  ///step status indicator
  final StepLineStatus status;

  ///stroke width
  final double strokeWidth;

  /// Returns the offset for the step indicator item.
  ///
  /// If no offset is provided, it defaults to an `EdgeInsets` value
  /// with left padding of 21 and bottom padding of 13.
  EdgeInsets get getOffset =>
      offset ??
      const EdgeInsets.only(
        left: 21,
        bottom: 13,
      );

  @override
  Widget build(BuildContext context) => CustomPaint(
        foregroundPainter: _ANStepLinePainter(
          offset: dotOffset,
          activeColor: activeColor,
          inactiveColor: inactiveColor,
          isLast: isLast,
          nextStatus: nextStatus,
          status: status,
          strokeWidth: strokeWidth,
        ),
        child: Padding(
          padding: getOffset,
          child: child,
        ),
      );
}

/// A custom painter for drawing step indicators with different statuses.
class _ANStepLinePainter extends CustomPainter {
  _ANStepLinePainter({
    this.activeColor = const Color(0xFF3EAE78),
    this.inactiveColor = const Color(0xFF666666),
    this.isLast = false,
    this.nextStatus = StepLineStatus.inactive,
    this.offset = 0.0,
    this.status = StepLineStatus.inactive,
    this.strokeWidth = 3,
  });

  /// active circle radius
  final double activeCircleRadius = 8;

  /// active step color
  final Color activeColor;

  /// completed circle radius
  final double completedCircleRadius = 8;

  /// inactive circle radius
  final double inactiveCircleRadius = 4;

  ///  inactive step color
  final Color inactiveColor;

  /// Indicates if this is the last item in the steps list.
  final bool isLast;

  ///line width
  final double lineWidth = 2.5;

  /// next step status,
  final StepLineStatus nextStatus;

  final double offset;

  /// step status
  final StepLineStatus status;

  ///stroke width
  final double strokeWidth;

  Color get paintColor => status.isInactive ? inactiveColor : activeColor;

  double get circleRadius => switch (status) {
        StepLineStatus.active => activeCircleRadius,
        StepLineStatus.completed => completedCircleRadius,
        StepLineStatus.inactive => inactiveCircleRadius,
      };

  @override
  void paint(Canvas canvas, Size size) {
    const centerX = 0.0; // Keep circles left-aligned
    final centerY = activeCircleRadius + offset; // Move circles to the top-left

    ///draw line with active color if only the step is completed
    final paintColor = switch (nextStatus) {
      StepLineStatus.active => activeColor,
      StepLineStatus.completed => activeColor,
      StepLineStatus.inactive => inactiveColor,
    };

    final linePaint = Paint()
      ..color = paintColor.withOpacity(status.isInactive ? 0.8 : 1)
      ..strokeWidth = lineWidth
      ..style = PaintingStyle.stroke;

    if (!isLast) {
      canvas.drawLine(
        Offset(centerX, centerY + circleRadius),
        Offset(centerX, size.height + (activeCircleRadius / 2) + offset),
        linePaint,
      );
    }

    // Draw the status circle at top-left
    final center = Offset(centerX, centerY);
    if (status.isCompleted) {
      _drawCompletedStep(canvas, center);
    } else if (status.isActive) {
      _drawActiveStep(canvas, center);
    } else {
      _drawInactiveStep(canvas, center);
    }
  }

  void _drawCompletedStep(Canvas canvas, Offset center) {
    final completedPaint = Paint()..color = paintColor;
    canvas.drawCircle(center, circleRadius, completedPaint);
    _drawCheckmark(canvas, center);
  }

  void _drawActiveStep(Canvas canvas, Offset center) {
    final activePaint = Paint()
      ..color = paintColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth + 1;
    canvas.drawCircle(center, circleRadius - 2, activePaint);
  }

  void _drawInactiveStep(Canvas canvas, Offset center) {
    final inactivePaint = Paint()..color = inactiveColor;
    canvas.drawCircle(center, circleRadius, inactivePaint);
  }

  void _drawCheckmark(Canvas canvas, Offset center) {
    final checkPaint = Paint()
      ..color = Colors.white
      ..strokeWidth = strokeWidth / 2
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final checkSize = circleRadius * 0.6;
    final checkPath = Path()
      ..moveTo(center.dx - checkSize * 0.4, center.dy)
      ..lineTo(
        center.dx - checkSize * 0.1,
        center.dy + checkSize * 0.4,
      )
      ..lineTo(
        center.dx + checkSize * 0.5,
        center.dy - checkSize * 0.3,
      );

    canvas.drawPath(checkPath, checkPaint);
  }

  // coverage:ignore-start
  @override
  bool shouldRepaint(covariant _ANStepLinePainter oldDelegate) =>
      activeColor != oldDelegate.activeColor ||
      inactiveColor != oldDelegate.inactiveColor ||
      isLast != oldDelegate.isLast ||
      status != oldDelegate.status ||
      strokeWidth != oldDelegate.strokeWidth;
// coverage:ignore-end
}
