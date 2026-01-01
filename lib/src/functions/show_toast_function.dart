import 'package:flutter/material.dart';

import '../toast/styled_toast.dart';
import '../toast/styled_toast_enum.dart';
import '../toast/styled_toast_manage.dart';

enum ToastStatus { success, failure }

void showToastSmart({
  required String msg,
  required ToastStatus status,
  required Widget icon,
  Color? backgroundColor,
  Color? textColor,
  BuildContext? context,
  double radius = 12,
  BorderRadiusGeometry? borderRadius,
}) {
  dismissAllToast(showAnim: true);
  Future.delayed(const Duration(milliseconds: 100), () {
    showToastWidget(
      builder: (context, theme) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            minHeight: 40,
            minWidth: 350,
            maxWidth: double.infinity - 20,
          ),
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: backgroundColor ?? theme?.backgroundColor,
              borderRadius:
                  borderRadius ?? BorderRadius.all(Radius.circular(radius)),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Row(
                children: [
                  icon,
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      msg,
                      maxLines: 2,
                      style: theme?.textStyle?.copyWith(color: textColor),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      context: context?.mounted == true ? context : null,
      animation: StyledToastAnimation.fade,
      animDuration: const Duration(milliseconds: 100),
      duration: const Duration(seconds: 3),
      dismissOtherToast: true,
    );
  });
}

void showToastError({
  required String msg,
  Color? backgroundColor,
  Widget? icon,
  BuildContext? context,
}) {
  showToastSmart(
    msg: msg,
    status: ToastStatus.failure,
    backgroundColor: backgroundColor ?? Colors.red,
    icon: icon ?? const Icon(Icons.cancel),
    context: context,
  );
}

void showToastSuccess({
  required String msg,
  Color? backgroundColor,
  Widget? icon,
  BuildContext? context,
}) {
  showToastSmart(
    msg: msg,
    status: ToastStatus.success,
    backgroundColor: backgroundColor ?? Colors.green,
    icon: icon ?? const Icon(Icons.check_circle),
    context: context,
  );
}
