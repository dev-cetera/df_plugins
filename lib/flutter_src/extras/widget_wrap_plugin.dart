//.title
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// Dart/Flutter (DF) Packages by dev-cetera.com & contributors. The use of this
// source code is governed by an MIT-style license described in the LICENSE
// file located in this project's root directory.
//
// See: https://opensource.org/license/mit
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//.title~

import 'package:flutter/widgets.dart';

import '/df_plugins.dart';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

class WidgetWrapPluginManager
    extends WidgetPluginManager<Widget, AttachableWidgetPlugin> {
  final Key? key;
  final AlignmentGeometry alignment;
  final Axis direction;
  final Clip clipBehavior;
  final double runSpacing;
  final double spacing;
  final TextDirection? textDirection;
  final VerticalDirection verticalDirection;
  final WrapAlignment alignmentWrap;
  final WrapAlignment runAlignment;
  final WrapCrossAlignment crossAxisAlignment;

  WidgetWrapPluginManager({
    super.plugins,
    this.key,
    this.alignment = AlignmentDirectional.topStart,
    this.alignmentWrap = WrapAlignment.start,
    this.clipBehavior = Clip.none,
    this.crossAxisAlignment = WrapCrossAlignment.start,
    this.direction = Axis.horizontal,
    this.runAlignment = WrapAlignment.start,
    this.runSpacing = 0.0,
    this.spacing = 0.0,
    this.textDirection,
    this.verticalDirection = VerticalDirection.down,
  });

  @override
  Widget Function({required BuildContext context, required Widget child})
  get build {
    return ({required BuildContext context, required Widget child}) {
      final children = [child];
      for (final plugin in plugins) {
        children.add(plugin.attach(context, children.last));
      }
      return Wrap(
        key: key,
        alignment: alignmentWrap,
        crossAxisAlignment: crossAxisAlignment,
        direction: direction,
        spacing: spacing,
        runSpacing: runSpacing,
        runAlignment: runAlignment,
        textDirection: textDirection,
        clipBehavior: clipBehavior,
        verticalDirection: verticalDirection,
        children: children,
      );
    };
  }
}

class WidgetWrapPluginBuilder
    extends WidgetPluginBuilder<Widget, AttachableWidgetPlugin> {
  final AlignmentGeometry alignment;
  final Axis direction;
  final WrapAlignment runAlignment;
  final WrapCrossAlignment crossAxisAlignment;
  final TextDirection? textDirection;
  final WrapAlignment alignmentWrap;
  final double spacing;
  final double runSpacing;
  final Clip clipBehavior;

  const WidgetWrapPluginBuilder({
    super.key,
    required super.plugins,
    this.alignment = AlignmentDirectional.topStart,
    this.direction = Axis.horizontal,
    this.runAlignment = WrapAlignment.start,
    this.crossAxisAlignment = WrapCrossAlignment.start,
    this.textDirection,
    this.alignmentWrap = WrapAlignment.start,
    this.spacing = 0.0,
    this.runSpacing = 0.0,
    this.clipBehavior = Clip.none,
    required super.child,
  });

  @override
  Widget build(BuildContext context) {
    return WidgetWrapPluginManager(
      plugins: plugins,
      key: key,
      alignment: alignment,
      direction: direction,
      runAlignment: runAlignment,
      crossAxisAlignment: crossAxisAlignment,
      textDirection: textDirection,
      alignmentWrap: alignmentWrap,
      spacing: spacing,
      runSpacing: runSpacing,
      clipBehavior: clipBehavior,
    ).build(context: context, child: child);
  }
}
