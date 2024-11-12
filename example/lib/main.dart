//.title
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// Dart/Flutter (DF) Packages by DevCetra.com & contributors. The use of this
// source code is governed by an MIT-style license described in the LICENSE
// file located in this project's root directory.
//
// See: https://opensource.org/license/mit
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//.title~

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
