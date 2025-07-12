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

import 'package:df_safer_dart/df_safer_dart.dart';
import 'package:meta/meta.dart';

import 'plugin.dart';

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

@immutable
abstract class FunctionalPlugin<T extends Object> extends Plugin {
  const FunctionalPlugin();

  /// Execute the plugin with a list of previous outputs.
  @protected
  Resolvable<T> execute(List<T> previousOutputs);
}

// ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

class FunctionalPluginManager<T extends Object> extends PluginManager<FunctionalPlugin<T>> {
  FunctionalPluginManager({super.plugins});

  /// Execute all registered plugins, passing the result of all previous ones
  /// as input.
  @override
  Resolvable<T> Function() get build {
    return () {
      final seq = TaskSequencer();
      final previousOutputs = <T>[];
      for (final plugin in plugins) {
        seq.then(
          (_) => plugin.execute(previousOutputs).then((e) {
            previousOutputs.add(e);
            return Some(e);
          }),
        );
      }
      return seq.completion.then((e) => previousOutputs.last);
    };
  }
}
