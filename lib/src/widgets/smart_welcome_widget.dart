import 'package:flutter/material.dart';
import 'package:smart_localize/smart_localize.dart';

import '../extension/context_extension.dart';
import '../functions/date_function/date_format.dart';
import '../functions/date_function/get_date.dart';
import 'smart_user_image.dart';

class WBWelcome extends StatelessWidget {
  final String firstName;
  final String? lastName;
  final String userImage;
  final double? spaceBetween;
  final double? imageSize;
  final Widget? trailing;
  final VoidCallback? onTap;
  final DateFormats? dateFormat;
  final TextStyle? dateStyle;
  final TextStyle? userNameStyle;
  final TextStyle? greetingStyle;

  const WBWelcome({
    super.key,
    required this.firstName,
    required this.userImage,
    this.lastName,
    this.trailing,
    this.spaceBetween = 12,
    this.onTap,
    this.imageSize,
    this.dateFormat,
    this.dateStyle,
    this.userNameStyle,
    this.greetingStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Row(
            children: [
              WBUserImage(
                imageSize: imageSize ?? 40,
                displayName: [
                  firstName,
                  lastName,
                ].whereType<String>().where((part) => part.isNotEmpty).join(' '),
                photo: userImage,
              ),
              SizedBox(width: spaceBetween),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    getFormatedDate(
                      date: DateTime.now().toString(),
                      format: dateFormat ?? DateFormats.weekdayMonthDay,
                    ),
                    style: dateStyle ?? context.bodyMedium,
                  ),
                  Row(
                    children: [
                      Text(
                        _greeting,
                        style:
                            greetingStyle ??
                            context.labelSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                      ),
                      Text(
                        ' $firstName ',
                        style:
                            userNameStyle ??
                            context.labelSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        const Spacer(),
        if (trailing != null) trailing!,
      ],
    );
  }
}

String get _greeting {
  final hour = DateTime.now().hour;
  if (hour < 12) {
    return SmartLocalize.goodMorning; // Morning greeting
  } else if (hour < 17) {
    return SmartLocalize.goodAfternoon; // Afternoon greeting
  } else {
    return SmartLocalize.goodEvening; // Evening greeting
  }
}
