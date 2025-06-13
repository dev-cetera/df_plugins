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

class WidgetTreePluginManager<W extends Widget>
    extends WidgetPluginManager<W, AttachableWidgetPlugin<W>> {
  WidgetTreePluginManager({super.plugins});

  /// Build a widget tree with all registered plugins, passing each previous
  /// child as input to the next plugin.
  @override
  W Function({required BuildContext context, required W child}) get build {
    // Apply plugins in order, each wrapping the previous result.
    return ({required BuildContext context, required W child}) {
      return plugins.fold(child, (previousChild, plugin) {
        return plugin.attach(context, previousChild);
      });
    };
  }
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

class WidgetTreePluginBuilder<W extends Widget>
    extends WidgetPluginBuilder<W, AttachableWidgetPlugin<W>> {
  const WidgetTreePluginBuilder({
    super.key,
    required super.plugins,
    required super.child,
  });

  @override
  Widget build(BuildContext context) {
    return WidgetTreePluginManager<W>(
      plugins: plugins,
    ).build(context: context, child: child);
  }
}
