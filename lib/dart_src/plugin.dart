//.title
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//
// Copyright © dev-cetera.com & contributors.
//
// The use of this source code is governed by an MIT-style license described in
// the LICENSE file located in this project's root directory.
//
// See: https://opensource.org/license/mit
//
// ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
//.title~

// `Plugin` (and its `installPlugin` / `uninstallPlugin` host extension) lives
// in `df_di`. Re-exported so callers can keep importing it from `df_plugins`.
export 'package:df_di/df_di.dart' show Plugin, PluginHostX;

import 'package:df_di/df_di.dart';
import 'package:meta/meta.dart';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

/// A collection of [Plugin]s with an optional [DI] host. When a host is
/// provided, [register] installs each plugin into the host scope via
/// `host.installPlugin(plugin)` — services, resources and child scopes the
/// plugin sets up are torn down automatically on uninstall.
///
/// When [host] is null, plugins are accumulated for builder-style composition
/// only (e.g. widget-tree decorators) and lifecycle is not driven.
abstract class PluginManager<TPlugin extends Plugin> {
  PluginManager({DI? host, List<TPlugin> plugins = const []}) : _host = host {
    this.plugins.addAll(plugins.cast<TPlugin>());
  }

  final DI? _host;

  @protected
  final plugins = <TPlugin>[];

  /// Adds [plugin] to this manager. If a host scope was provided, also
  /// installs the plugin into it.
  Resolvable<Unit> register(TPlugin plugin) {
    plugins.add(plugin);
    final h = _host;
    if (h == null) return syncUnit();
    return h.installPlugin(plugin).toUnit();
  }

  /// Adds and (if a host was provided) installs every plugin in [plugins],
  /// preserving order.
  Resolvable<Unit> registerAll(Iterable<TPlugin> plugins) {
    final seq = TaskSequencer();
    for (final plugin in plugins) {
      seq.then((_) => register(plugin).then((e) => Some(e)));
    }
    return seq.completion.toUnit();
  }

  Function get build;
}
