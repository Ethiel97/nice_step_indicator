```markdown
# nice_step_indicator

A package for nice step indicators in your app.

## Features

- Customizable active and inactive colors
- Builder for child widgets
- Supports different step statuses (active, completed, inactive)

## Installation

Add `nice_step_indicator` to your `pubspec.yaml`:

```yaml
dependencies:
  nice_step_indicator: ^1.0.0
```

Then run `flutter pub get` to install the package.

## Usage

### Import the package

```dart
import 'package:nice_step_indicator/nice_step_indicator.dart';
```

### Example

Here is an example of how to use the `NiceStepIndicator` widget:

```dart
import 'package:flutter/material.dart';
import 'package:nice_step_indicator/nice_step_indicator.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Nice Step Indicator Example'),
        ),
        body: Center(
          child: NiceStepIndicator<String>(
            items: ['Step 1', 'Step 2', 'Step 3'],
            builder: (context, index, item) => Text(item),
            status: (item) {
              switch (item) {
                case 'Step 1':
                  return StepLineStatus.active;
                case 'Step 2':
                  return StepLineStatus.completed;
                case 'Step 3':
                default:
                  return StepLineStatus.inactive;
              }
            },
          ),
        ),
      ),
    );
  }
}
```

### Customization

You can customize the `NiceStepIndicator` widget by providing different values for the following properties:

- `activeColor`: The color of the active step.
- `inactiveColor`: The color of the inactive step.
- `dotOffset`: Optional offset for the dot indicator item.
- `offset`: Optional offset for the step indicator item, providing padding around the step.
- `strokeWidth`: The width of the stroke.

### API Reference

#### NiceStepIndicator

A widget that displays a series of step indicators.

##### Properties

- `activeColor`: The color of the active step.
- `builder`: The child widget builder.
- `dotOffset`: Optional offset for the dot indicator item.
- `inactiveColor`: The color of the inactive step.
- `items`: The data to render in the steps.
- `offset`: Optional offset for the step indicator item, providing padding around the step.
- `status`: The indicator status builder.
- `strokeWidth`: The width of the stroke.

#### StepWidgetBuilder

A function that builds a widget for a step indicator item.

##### Parameters

- `BuildContext context`: The build context.
- `int index`: The index of the item.
- `T item`: The item itself.

#### StepStatusBuilder

A function that determines the status of a step indicator item.

##### Parameters

- `T item`: The item itself.

##### Returns

- `StepLineStatus`: The status of the step indicator item.

## License

This project is licensed under the MIT License.
```