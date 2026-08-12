import 'package:flutter/material.dart';

import 'wb_field_label.dart';

/// A titled dropdown form field — the `CustomDropdownButtonFormField` every app
/// re-implements. Supply either ready [items] or a plain [options] list plus an
/// [itemLabel] mapper; the field integrates with `Form` validation/saving.
class WBDropdownField<T> extends StatelessWidget {
  final String? title;
  final String? hintText;
  final T? value;

  /// Pre-built menu items. Takes precedence over [options].
  final List<DropdownMenuItem<T>>? items;

  /// Plain values, rendered via [itemLabel] (defaults to `toString`).
  final List<T>? options;
  final String Function(T value)? itemLabel;

  final ValueChanged<T?>? onChanged;
  final FormFieldSetter<T>? onSaved;
  final FormFieldValidator<T>? validator;
  final bool isRequired;
  final bool enabled;
  final double radius;
  final Widget? prefixIcon;

  const WBDropdownField({
    super.key,
    this.title,
    this.hintText,
    this.value,
    this.items,
    this.options,
    this.itemLabel,
    this.onChanged,
    this.onSaved,
    this.validator,
    this.isRequired = false,
    this.enabled = true,
    this.radius = 8,
    this.prefixIcon,
  });

  List<DropdownMenuItem<T>> _resolveItems() {
    if (items != null) return items!;
    final opts = options ?? const [];
    return opts
        .map((o) => DropdownMenuItem<T>(
              value: o,
              child: Text(itemLabel?.call(o) ?? o.toString()),
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(radius),
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (title != null) WBFieldLabel(title!, isRequired: isRequired),
        DropdownButtonFormField<T>(
          initialValue: value,
          isExpanded: true,
          items: _resolveItems(),
          onChanged: enabled ? onChanged : null,
          onSaved: onSaved,
          validator: validator ??
              (isRequired
                  ? (v) => v == null ? '' : null
                  : null),
          decoration: InputDecoration(
            hintText: hintText,
            prefixIcon: prefixIcon,
            border: border,
            enabledBorder: border,
            filled: !enabled,
          ),
        ),
      ],
    );
  }
}
