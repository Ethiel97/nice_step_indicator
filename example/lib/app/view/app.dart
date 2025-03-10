import 'package:example/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:nice_step_indicator/nice_step_indicator.dart';

class ProgressStep {
  const ProgressStep({
    required this.title,
    required this.subtitle,
    this.status = StepLineStatus.inactive,
  });

  final String title;
  final String subtitle;
  final StepLineStatus status;
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final steps = List.generate(
      5,
      (index) => ProgressStep(
        subtitle: 'Step ${index + 1} subtitle',
        title: 'Step ${index + 1}',
      ),
    );
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        useMaterial3: true,
      ),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Center(
        child: NiceStepIndicator<ProgressStep>(
          items: steps,
          builder: (context, _, item) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.title,
              ),
              const SizedBox(height: 8),
              Text(
                item.subtitle,
              ),
            ],
          ),
          status: (item) => StepLineStatus.fromString(item.status.name),
        ),
      ),
    );
  }
}
