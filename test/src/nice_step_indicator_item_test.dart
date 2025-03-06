import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nice_step_indicator/nice_step_indicator.dart';

void main() {
  group('Progress step line painter tests', () {
    group('ProgressStepLineStatus test', () {
      test('Defaults to inactive if incorrect String value is given', () {
        final status = StepLineStatus.fromString('pending');

        expect(status.isInactive, isTrue);
      });
    });

    testWidgets('ANStepIndicatorItem test', (tester) async {
      await tester.pumpWidget(
        NiceStepIndicatorItem(child: Container()),
      );

      expect(find.byType(NiceStepIndicatorItem), findsOneWidget);
    });
  });
}
