# Changelog

## [0.4.0]

- **BREAKING:** `Plugin` is now sourced from `df_di`. The old
  `Plugin.initialize()` hook is replaced by `Plugin.install(DI scope)` /
  `Plugin.uninstall(DI scope)`. Each installed plugin owns a fresh child DI
  scope and is torn down cleanly on uninstall — `ServiceMixin` services
  registered into the scope have their `dispose()` cascaded automatically.
- **BREAKING:** `PluginManager` now takes an optional `host: DI?` parameter.
  When provided, `register()` calls `host.installPlugin(plugin)` for proper
  lifecycle. When null (the default), the manager only accumulates plugins
  for builder-style composition — useful for pure widget-tree decorators
  with no side effects.
- Subclasses (`WidgetPlugin`, `AttachableWidgetPlugin`, `FunctionalPlugin`)
  continue to work — they inherit no-op `install`/`uninstall` by default.
- Migration: replace `@override Resolvable<Unit> initialize() => ...` with
  `@override Resolvable<Unit> install(DI scope) => ...`.

## [0.2.2]

- Released @ 7/2025 (UTC)
- Update dependencies

## [0.2.1]

- Released @ 6/2025 (UTC)
- Update dependencies

## [0.2.0]

- Released @ 6/2025 (UTC)
- Update dependencies

## [0.1.4]

- Released @ 6/2025 (UTC)
- Update dependencies

## [0.1.2]

- Released @ 6/2025 (UTC)
- chore: Update dependencies

## [0.1.1]

- Released @ 11/2024 (UTC)
- fix: Fix linter issues

## [0.1.0]

- Released @ 11/2024 (UTC)
- Initial commit
