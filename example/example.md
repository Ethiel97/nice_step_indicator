#Usage Example

```dart
import "package:nice_step_indicator/nice_step_indicator.dart";

/// A model representing a step in the progress indicator.
class ProgressStep {
  /// Creates a [ProgressStep] with the given [title], [subtitle], and [status].
  const ProgressStep({
    required this.title,
    required this.subtitle,
    this.status = StepLineStatus.inactive,
  });

  /// The title of the step.
  final String title;

  /// The subtitle of the step.
  final String subtitle;

  /// The status of the step, which can be active, completed, or inactive.
  final StepLineStatus status;
}

/// The main application widget.

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    // Generate a list of steps for the progress indicator.
    final steps = List.generate(
      5,
          (index) =>
          ProgressStep(
            subtitle: 'Step ${index + 1} subtitle',
            title: 'Step ${index + 1}',
          ),
    );

    return MaterialApp(
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: Theme
              .of(context)
              .colorScheme
              .inversePrimary,
        ),
        useMaterial3: true,
      ),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Center(
        child: NiceStepIndicator<ProgressStep>(
          items: steps,
          builder: (context, _, item) =>
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.title),
                  const SizedBox(height: 8),
                  Text(item.subtitle),
                ],
              ),
          status: (item) => StepLineStatus.fromString(item.status.name),
        ),
      ),
    );
  }
}
```
