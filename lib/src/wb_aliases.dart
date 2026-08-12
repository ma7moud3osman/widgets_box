import 'main_button/widgets/main_button.dart';
import 'text_field/main_text_field.dart';
import 'widgets/smart_cached_images.dart';
import 'widgets/smart_empty_screen.dart';
import 'widgets/smart_loading_widget.dart';
import 'widgets/smart_refresh_indicator.dart';
import 'widgets/smart_screen.dart';
import 'widgets/smart_status_widget.dart';
import 'widgets/smart_tag_widget.dart';
import 'widgets/smart_user_image.dart';
import 'widgets/smart_welcome_widget.dart';

/// Backwards-compatible aliases for the pre-`WB` class names.
///
/// The public widgets were rebranded with a consistent `WB` prefix. These
/// deprecated typedefs keep existing consumer code compiling while it migrates
/// to the new names; they resolve to the exact same classes and will be removed
/// in a future major version.
@Deprecated('Use WBButton')
typedef MainButton = WBButton;
@Deprecated('Use WBButtonType')
typedef MainButtonEnum = WBButtonType;
@Deprecated('Use WBTextField')
typedef MainTextField = WBTextField;
@Deprecated('Use WBScreen')
typedef SmartScreen = WBScreen;
@Deprecated('Use WBEmptyState')
typedef SmartEmptyWidget = WBEmptyState;
@Deprecated('Use WBLoading')
typedef SmartLoadingWidget = WBLoading;
@Deprecated('Use WBCachedImage')
typedef SmartCachedImages = WBCachedImage;
@Deprecated('Use WBUserImage')
typedef SmartUserImage = WBUserImage;
@Deprecated('Use WBWelcome')
typedef SmartWelcomeWidget = WBWelcome;
@Deprecated('Use WBRefreshIndicator')
typedef SmartRefreshIndicator = WBRefreshIndicator;
@Deprecated('Use WBPositionedStatus')
typedef SmartStatusWidget = WBPositionedStatus;
@Deprecated('Use WBStatus')
typedef StatusWidget = WBStatus;
@Deprecated('Use WBTag')
typedef SmartTagWidget = WBTag;
