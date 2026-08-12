library;

// NOTE: this barrel intentionally does NOT re-export third-party packages
// (e.g. Lottie). Re-exporting a dependency leaks its entire public surface —
// and transitively `dart:ui` names like `TextDirection` — into every consumer,
// forcing them to `hide` symbols to avoid ambiguous-import clashes with Flutter
// itself. Consumers that need Lottie import `package:lottie/lottie.dart`
// directly.

// Backwards-compatible aliases for the pre-WB class names.
export 'src/wb_aliases.dart';

// app info
export 'src/app_info/app_version_widget.dart';
export 'src/app_info/powered_by_widget.dart';
export 'src/config/main_config.dart';
// environment
export 'src/environment/app_environment.dart';
export 'src/environment/environment_config.dart';
export 'src/environment/environment_manager.dart';
export 'src/environment/environment_switcher.dart';
// extension
export 'src/extension/context_extension.dart';
export 'src/extension/initials_extension.dart';
export 'src/extension/string_extension.dart';
export 'src/extension/theme_mode_extension.dart';
export 'src/extension/widget_extension.dart';
// functions
export 'src/functions/date_function/date_format.dart';
export 'src/functions/date_function/get_date.dart';
export 'src/functions/debouncer.dart';
export 'src/functions/hex_color.dart';
export 'src/functions/separated_widget.dart';
export 'src/functions/wb_validators.dart';
export 'src/functions/show_toast_function.dart';
export 'src/main_button/widgets/image_widget.dart';
export 'src/main_button/widgets/main_button.dart';
// restart
export 'src/restart/app_restarter.dart';
export 'src/text_field/functions/get_input_decoration.dart';
export 'src/text_field/functions/validation_functions.dart';
export 'src/text_field/main_text_field.dart';
// toast
export 'src/toast/custom_animation.dart';
export 'src/toast/custom_size_transition.dart';
export 'src/toast/styled_toast.dart';
export 'src/toast/styled_toast_enum.dart';
export 'src/toast/styled_toast_manage.dart';
export 'src/toast/styled_toast_theme.dart';
export 'src/toast/wb_toast.dart';
export 'src/widgets/smart_cached_images.dart';
export 'src/widgets/smart_empty_screen.dart';
export 'src/widgets/smart_loading_widget.dart';
export 'src/widgets/smart_refresh_indicator.dart';
// widgets
export 'src/widgets/wb_card.dart';
export 'src/widgets/wb_detail_row.dart';
export 'src/widgets/wb_list_row.dart';
export 'src/widgets/wb_section_header.dart';
export 'src/widgets/wb_status_badge.dart';
export 'src/widgets/smart_screen.dart';
export 'src/widgets/smart_status_widget.dart';
export 'src/widgets/smart_tag_widget.dart';
export 'src/widgets/smart_user_image.dart';
export 'src/widgets/smart_welcome_widget.dart';
