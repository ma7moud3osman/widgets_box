## 0.2.0

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
