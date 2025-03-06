import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nice_step_indicator/nice_step_indicator.dart';

enum Status {
  active,
  inactive,
  completed,
}

class ProgressStep {
  const ProgressStep({
    required this.title,
    required this.subtitle,
    this.status = Status.inactive,
  });

  final String title;
  final String subtitle;
  final Status status;
}

void main() {
  const steps = <ProgressStep>[
    ProgressStep(
      subtitle: 'Your checkout is in progress with identify verification.',
      title: 'Identity verification',
    ),
    ProgressStep(
      subtitle: 'Your checkout is in progress with title upload.',
      title: 'Title Upload',
      status: Status.completed,
    ),
    ProgressStep(
      subtitle: 'Your checkout is in progress with title upload.',
      title: 'Title Upload',
      status: Status.active,
    ),
  ];

  group('progress list widget tests', () {
    testWidgets('Renders progress list widget', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: NiceStepIndicator<ProgressStep>(
            items: steps,
            builder: (context, _, item) => Text(item.title),
            status: (item) => StepLineStatus.fromString(item.status.name),
          ),
        ),
      );

      expect(find.byType(NiceStepIndicator<ProgressStep>), findsOneWidget);
    });

    testWidgets('Renders correct NiceStepIndicatorItem number', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: NiceStepIndicator<ProgressStep>(
            items: steps,
            builder: (BuildContext context, int index, ProgressStep item) {
              return Text(item.title);
            },
          ),
        ),
      );

      expect(
        find.byType(NiceStepIndicatorItem),
        findsExactly(
          steps.length,
        ),
      );
    });

    testWidgets('NiceStepIndicatorProvider provides controller to descendants',
        (WidgetTester tester) async {
      final controller = NiceStepIndicatorController<int>(
        steps: [1, 2, 3],
        currentStep: 1,
        nextStep: () {},
        previousStep: () {},
      );

      await tester.pumpWidget(
        NiceStepIndicatorProvider<int>(
          controller: controller,
          child: Builder(
            builder: (BuildContext context) {
              final providedController =
                  NiceStepIndicatorProvider.of<int>(context).controller;
              expect(providedController, equals(controller));
              return Container();
            },
          ),
        ),
      );
    });
  });
}
