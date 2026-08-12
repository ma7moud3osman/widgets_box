import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'wb_field_label.dart';

/// A titled, read-only date field that opens the date picker on tap and reports
/// the chosen day — the `CustomDateWidget` every app re-implements. Purely
/// controlled: it renders whatever [value] you pass and calls [onChanged].
class WBDateField extends StatelessWidget {
  final String? title;
  final String? hintText;
  final DateTime? value;
  final ValueChanged<DateTime>? onChanged;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final String pattern;
  final bool enabled;
  final bool isRequired;
  final double radius;
  final Widget? prefixIcon;

  const WBDateField({
    super.key,
    this.title,
    this.hintText,
    this.value,
    this.onChanged,
    this.firstDate,
    this.lastDate,
    this.pattern = 'dd/MM/yyyy',
    this.enabled = true,
    this.isRequired = false,
    this.radius = 8,
    this.prefixIcon,
  });

  Future<void> _pick(BuildContext context) async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: value ?? now,
      firstDate: firstDate ?? DateTime(now.year - 100),
      lastDate: lastDate ?? DateTime(now.year + 100),
    );
    if (picked != null) onChanged?.call(picked);
  }

  @override
  Widget build(BuildContext context) {
    final text = value == null ? '' : DateFormat(pattern).format(value!);
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(radius),
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (title != null) WBFieldLabel(title!, isRequired: isRequired),
        TextField(
          readOnly: true,
          enabled: enabled,
          controller: TextEditingController(text: text),
          onTap: enabled ? () => _pick(context) : null,
          decoration: InputDecoration(
            hintText: hintText,
            prefixIcon: prefixIcon ?? const Icon(Icons.calendar_today, size: 18),
            border: border,
            enabledBorder: border,
          ),
        ),
      ],
    );
  }
}
