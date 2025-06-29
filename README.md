<a href="https://www.buymeacoffee.com/dev_cetera" target="_blank"><img align="right" src="https://cdn.buymeacoffee.com/buttons/default-orange.png" height="48"></a>
<a href="https://discord.gg/gEQ8y2nfyX" target="_blank"><img align="right" src="https://raw.githubusercontent.com/dev-cetera/resources/refs/heads/main/assets/discord_icon/discord_icon.svg" height="48"></a>

Dart & Flutter Packages by dev-cetera.com & contributors.

[![sponsor](https://img.shields.io/badge/sponsor-grey?logo=github-sponsors)](https://github.com/sponsors/dev-cetera)
[![patreon](https://img.shields.io/badge/patreon-grey?logo=patreon)](https://www.patreon.com/c/RobertMollentze)
[![pub](https://img.shields.io/pub/v/df_plugins.svg)](https://pub.dev/packages/df_plugins)
[![tag](https://img.shields.io/badge/tag-v0.2.1-purple?logo=github)](https://github.com/dev-cetera/df_plugins/tree/v0.2.1)
[![license](https://img.shields.io/badge/license-MIT-blue.svg)](https://raw.githubusercontent.com/dev-cetera/df_plugins/main/LICENSE)

---

<!-- BEGIN _README_CONTENT -->

## Summary

Provides methods to create plugins for Dart and Flutter. This package demonstrates ways to make Dart and Flutter even more modular.

## Example

```dart
import 'package:df_plugins/df_plugins.dart'; // for Flutter projects

// ignore_for_file: unnecessary_import
import 'package:df_plugins/df_plugins_dart.dart'; // for Dart-only projects

import 'package:flutter/material.dart';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

void main() {
  dartExample();
  flutterExample();
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
//
// Dart Plugins Example.
//
// This is an example of using Functional plugins to transform data in
// your app.
//
// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

void dartExample() {
  // Dart Plugins Example:
  final math = FunctionalPluginManager<num>();
  math.registerAll([
    const ValuePlugin(10),
    const AddPlugin(5),
    const MultiplyPlugin(2),
    const SubtractPlugin(3),
  ]);
  math.register(const AddPlugin(5));
  math.register(const MultiplyPlugin(2));
  math.register(const SubtractPlugin(3));
  final result = math.build();
  debugPrint('Total: $result'); // prints 27
}
// Define some plugins that manipulate numbers. These examples are simple, but
// you can imagine more complex plugins that perform more complex operations,
// such as matrix multiplication, image processing, or even machine learning.

final class ValuePlugin<T extends num> extends FunctionalPlugin<T> {
  final T value;
  const ValuePlugin(this.value);

  @override
  T execute(List<T> previousOutputs) {
    if (previousOutputs.isNotEmpty) {
      throw Exception('ValuePlugin must be the first plugin in the list.');
    }
    return value;
  }
}

final class AddPlugin<T extends num> extends FunctionalPlugin<T> {
  final T value;
  const AddPlugin(this.value);

  @override
  T execute(List<T> previousOutputs) {
    return previousOutputs.last + value as T;
  }
}

final class MultiplyPlugin<T extends num> extends FunctionalPlugin<T> {
  final T value;
  const MultiplyPlugin(this.value);

  @override
  T execute(List<T> previousOutputs) {
    return previousOutputs.last * value as T;
  }
}

final class SubtractPlugin<T extends num> extends FunctionalPlugin<T> {
  final T value;
  const SubtractPlugin(this.value);

  @override
  T execute(List<T> previousOutputs) {
    return previousOutputs.last - value as T;
  }
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
//
// Flutter Plugins Example.
//
// This is an example of using Widget plugins to add widgets to your app.
// Widget plugins could add modularity to your apps if properly implemented.
//
// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

void flutterExample() {
  runApp(const PluginApp());
}

class PluginApp extends StatelessWidget {
  const PluginApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        // Also try:
        // - WidgetColumnPluginBuilder to draw plugins in a Column
        // - WidgetRowPluginBuilder to draw plugins in a Row
        // - WidgetWrapPluginBuilder to draw plugins in a Wrap
        // - WidgetStackPluginBuilder to draw plugins in a Stack
        // - WidgetTreePluginBuilder to draw plugins in a tree hierarchy.
        // - Extend WidgetPluginBuilder to define your own builder.
        body: WidgetTreePluginBuilder(
          plugins: [
            // Apply plugins in order, each Treeing the previous result.
            WidgetPlugin(child: Text('Hello Plugins!!!')),
            PaddingPlugin(padding: EdgeInsets.all(8.0)),
            BackgroundColorPlugin(color: Colors.yellow),
            PaddingPlugin(padding: EdgeInsets.all(20.0)),
            BackgroundColorPlugin(color: Colors.blue),
          ],
          child: SizedBox(),
        ),
      ),
    );
  }
}

/// A simple plugin that returns its child.
class WidgetPlugin extends AttachableWidgetPlugin {
  final Widget child;
  const WidgetPlugin({required this.child});

  @override
  Widget attach(BuildContext context, Widget child) {
    return child;
  }
}

/// A simple plugin that sets the background color of the widget.
class BackgroundColorPlugin extends AttachableWidgetPlugin {
  final Color color;
  const BackgroundColorPlugin({required this.color});

  @override
  Widget attach(BuildContext context, Widget child) {
    return Container(
      color: color,
      child: child,
    );
  }
}

/// A simple plugin that adds padding around the widget.
class PaddingPlugin extends AttachableWidgetPlugin {
  final EdgeInsets padding;
  const PaddingPlugin({required this.padding});

  @override
  Widget attach(BuildContext context, Widget child) {
    return Padding(
      padding: padding,
      child: child,
    );
  }
}
```

<!-- END _README_CONTENT -->

---

☝️ Please refer to the [API reference](https://pub.dev/documentation/df_plugins/) for more information.

---

## 💬 Contributing and Discussions

This is an open-source project, and we warmly welcome contributions from everyone, regardless of experience level. Whether you're a seasoned developer or just starting out, contributing to this project is a fantastic way to learn, share your knowledge, and make a meaningful impact on the community.

### ☝️ Ways you can contribute

- **Buy me a coffee:** If you'd like to support the project financially, consider [buying me a coffee](https://www.buymeacoffee.com/dev_cetera). Your support helps cover the costs of development and keeps the project growing.
- **Find us on Discord:** Feel free to ask questions and engage with the community here: https://discord.gg/gEQ8y2nfyX.
- **Share your ideas:** Every perspective matters, and your ideas can spark innovation.
- **Help others:** Engage with other users by offering advice, solutions, or troubleshooting assistance.
- **Report bugs:** Help us identify and fix issues to make the project more robust.
- **Suggest improvements or new features:** Your ideas can help shape the future of the project.
- **Help clarify documentation:** Good documentation is key to accessibility. You can make it easier for others to get started by improving or expanding our documentation.
- **Write articles:** Share your knowledge by writing tutorials, guides, or blog posts about your experiences with the project. It's a great way to contribute and help others learn.

No matter how you choose to contribute, your involvement is greatly appreciated and valued!

### ☕ We drink a lot of coffee...

If you're enjoying this package and find it valuable, consider showing your appreciation with a small donation. Every bit helps in supporting future development. You can donate here: https://www.buymeacoffee.com/dev_cetera

<a href="https://www.buymeacoffee.com/dev_cetera" target="_blank"><img src="https://cdn.buymeacoffee.com/buttons/default-orange.png" height="40"></a>

## 🧑‍⚖️ License

This project is released under the [MIT License](https://raw.githubusercontent.com/dev-cetera/df_plugins/main/LICENSE). See [LICENSE](https://raw.githubusercontent.com/dev-cetera/df_plugins/main/LICENSE) for more information.
