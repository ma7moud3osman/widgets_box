## 0.2.0

* **BREAKING (with migration):** public widgets renamed to a consistent `WB` prefix — `MainButton`→`WBButton`, `MainTextField`→`WBTextField`, `SmartScreen`→`WBScreen`, `SmartEmptyWidget`→`WBEmptyState`, `SmartLoadingWidget`→`WBLoading`, `SmartCachedImages`→`WBCachedImage`, `SmartUserImage`→`WBUserImage`, `SmartWelcomeWidget`→`WBWelcome`, `SmartRefreshIndicator`→`WBRefreshIndicator`, `SmartStatusWidget`→`WBPositionedStatus`, `StatusWidget`→`WBStatus`, `SmartTagWidget`→`WBTag`, `MainButtonEnum`→`WBButtonType`. `@Deprecated` typedef aliases keep old names compiling.
* **BREAKING:** removed the `export 'package:lottie/lottie.dart'` re-export — it leaked third-party + `dart:ui` names (e.g. `TextDirection`) into consumers and forced `hide` clauses. Import Lottie directly if needed.
* fix: privatized/namespaced leaked generic top-level symbols (`getWidget`, the legacy debouncer `timer`, the toast `currentContext`) to avoid consumer collisions.
* feat: parity with app-local wrappers — `WBCachedImage` (nullable url + fallback, `blendMode`, mem-cache, fade-out, `useOldImageOnUrlChange`); `WBCard` (`width`/`height`/`alignment`); `WBStatus`/`WBStatusBadge` (fill+border, leading dot, `onTap`, asymmetric radius); `WBSectionHeader` (leading, required asterisk, inline badge, action color); `WBDetailRow` (`onTap`, phone-LTR, `valueIcon`, flex ratios); `WBListRow` (selected, bordered surface); `WBTextField` (title-row action slot, `semanticsIdentifier`); `WBButton` (gradient background, `semanticsIdentifier`).
* refactor: button color resolvers are now typed (`Color` returns) and DRY (shared resolver, loading delegates to text color).
* test: first test suite for the package — 88 tests; ~86% line coverage excluding the legacy toast engine.
* feat: new promoted components — **WBCard** (+`.media`), **WBListRow** (`.menu`/`.toggle`/`.picker`), **WBStatusBadge** (hex/semantic color resolver), **WBSectionHeader**, **WBDetailRow** (+`.money`) — mined from patterns every consuming app re-implements.
* feat: `WBCardConfig` token config; extended `StatusWidget` with `icon` + `outlined`.
* feat: improved existing widgets in place — `SmartCachedImages` (SVG + asset + local-file + fade, no darken-on-transparent), `SmartEmptyWidget` (retry action + `.toSliver()`, fixed subtitle/SVG detection).
* feat: **WBToast** — theme/`ColorScheme`-aware toast reading `ToastConfig` (fixes fixed-350 overflow + maxLines), no name collision with app toast helpers.
* feat: `MainButton` colors now derive from `ColorScheme` (`primary`/`onPrimary`/`secondary`) instead of hardcoded `primaryColor`/`Colors.white`.
* feat: `WB`-prefixed aliases for existing widgets (`WBButton`, `WBTextField`, `WBScreen`, `WBStatus`, `WBTag`, `WBEmpty`, `WBLoading`, `WBImage`, …) for IDE discoverability; original names unchanged.
* chore: replaced 8 self-referential barrel imports with specific relative imports; README rewrite (name, component families, styling precedence).
* feat: generic debug **environment switcher** (`WBEnvironmentManager`, `WBEnvironmentConfig`, `WBAppEnvironment`, `WBEnvironmentSwitcher`) — config-driven, debug-only, release-safe.
* feat: `WBAppRestarter` — dependency-free in-process app remount (replaces `flutter_phoenix`).
* feat: `WBPoweredBy` and `WBAppVersion` (app version/build + Shorebird patch) reusable widgets.
* fix: config system — value equality + `hashCode` on `WidgetsBoxConfig`/`ButtonConfig`/`TextFieldConfig` (correct `updateShouldNotify`); single `WidgetsBoxConfig.defaults` source of truth; previously-dead `ButtonConfig`/`TextFieldConfig` fields are now consumed.
* feat: text field — expose more `TextFormField` capability on the base field (`onFieldSubmitted`, `autofocus`, `cursorColor`, `enableInteractiveSelection`, overridable `onTapOutside`); `.number` now uses a decimal keyboard + decimal-tolerant formatter.
* fix: text field — opt-in `filled`/`fillColor`/border/radius/label color (defers to `InputDecorationTheme` when unset); email min-length false-reject and password special-char regex corrected.
* fix: button — background used the border color for non-primary variants; disabled label + border width now configurable.
* fix: `HexColor` no longer throws on malformed input (supports `#RGB`); per-instance `Debouncer`; `SmartRefreshIndicator` spinner color; `SmartWelcomeWidget` "null" name; `toCapitalLetter` on empty string.
* chore: export-barrel cleanup (removed dead `app_font`, fixed `string_extension` filename), added `ToastConfig`.

## 0.1.0

* feat: add string extensions for date formatting and phone number pars…
## 0.0.9

This PR introduces significant refactoring to the text field widgets for improved consistency,
enhances the icon button with new positioning options, and updates the project documentation.

## 0.0.8

* Refactor `MainTextField` and its subclasses for parameter normalization.
* Add `minLines`, `maxLines`, `maxLength`, `textDirection`, `hintTextDirection` to all text fields.
* Add `isIconEnd` to `MainButton.icon` to support placing icon after (end of) the label.
* Fix image ordering in `MainButton.icon` to respect text direction.

## 0.0.7

* add skeleton widget
* add empty widget

## 0.0.6

* fix images

## 0.0.5

* add icon customization options to text fields

## 0.0.4

* update pubspec for version 0.0.4

## 0.0.3

* update pubspec for version 0.0.3

## 0.0.2

* add show toast function

## 0.0.1

* initial release
