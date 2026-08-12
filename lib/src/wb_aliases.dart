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

/// `WB`-prefixed aliases for the package's existing public widgets.
///
/// These make every `widgets_box` component discoverable by typing `WB` in the
/// IDE, and give the package one consistent naming face, without a breaking
/// rename: the original names keep working, and these resolve to the exact same
/// classes (a `WBButton(...)` is a `MainButton(...)`).
typedef WBButton = MainButton;
typedef WBTextField = MainTextField;
typedef WBScreen = SmartScreen;
typedef WBStatus = StatusWidget;
typedef WBStatusPositioned = SmartStatusWidget;
typedef WBTag = SmartTagWidget;
typedef WBEmpty = SmartEmptyWidget;
typedef WBLoading = SmartLoadingWidget;
typedef WBImage = SmartCachedImages;
typedef WBUserImage = SmartUserImage;
typedef WBWelcome = SmartWelcomeWidget;
typedef WBRefreshIndicator = SmartRefreshIndicator;
