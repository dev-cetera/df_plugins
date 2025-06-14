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

import 'dart:async';

import 'package:df_safer_dart/df_safer_dart.dart';
import 'package:meta/meta.dart';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

@immutable
abstract class Plugin {
  const Plugin();
  @visibleForOverriding
  FutureOr<void> initialize() {}
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

abstract class PluginManager<TPlugin extends Plugin> {
  PluginManager({List<TPlugin> plugins = const []}) {
    this.plugins.addAll(plugins.cast<TPlugin>());
  }

  @protected
  final List<TPlugin> plugins = [];

  /// Register a plugin to the manager.
  FutureOr<void> register(TPlugin plugin) {
    plugins.add(plugin);
    return plugin.initialize();
  }

  // Register a sequence of plugins to the manager.
  FutureOr<void> registerAll(Iterable<TPlugin> plugins) {
    final seq = SafeSequencer();
    for (final plugin in plugins) {
      seq.add(() => register(plugin));
    }
    return seq.last.value;
  }

  Function get build;
}
