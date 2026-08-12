part of 'main_text_field.dart';

class _NumberMainTextField extends WBTextField {
  const _NumberMainTextField({
    required super.maxWidth,
    required super.title,
    required super.spaceBetween,
    required super.onTap,
    required super.inputFormatters,
    required super.readOnly,
    required super.initialValue,
    required super.controller,
    required super.style,
    required super.autoValidateMode,
    required super.textAlign,
    required super.onChanged,
    required super.onEditingComplete,
    required super.onSaved,
    required super.isRequired,
    required super.validator,
    required super.textInputAction,
    required super.focusNode,
    required super.textCapitalization,
    required super.textAlignVertical,
    required super.decoration,
    required super.filled,
    required super.fillColor,
    required super.prefixIcon,
    required super.suffixIcon,
    required super.contentPadding,
    required super.labelText,
    required super.hintText,
    required super.isDense,
    required super.isEnable,
    required super.hideAsterisk,
    required super.cursorHeight,
    required super.titleStyle,
    required super.iconColor,
    required super.showPrefixIcon,
    required super.minLines,
    required super.maxLines,
    required super.maxLength,
    required super.textDirection,
    required super.hintTextDirection,
  });

  @override
  State<_NumberMainTextField> createState() => _NumberMainTextFieldState();
}

class _NumberMainTextFieldState extends State<_NumberMainTextField> {
  @override
  Widget build(BuildContext context) {
    return WBTextField(
      titleStyle: widget.titleStyle,
      maxWidth: widget.maxWidth,
      title: widget.title ?? SmartLocalize.number,
      spaceBetween: widget.spaceBetween,
      onTap: widget.onTap,
      readOnly: widget.readOnly,
      initialValue: widget.initialValue,
      controller: widget.controller,
      style: widget.style,
      autoValidateMode: widget.autoValidateMode,
      textAlign: widget.textAlign,
      onChanged: widget.onChanged,
      onEditingComplete: widget.onEditingComplete,
      onSaved: widget.onSaved,
      isRequired: widget.isRequired,
      validator: widget.validator ?? (val) => validateNumberFormat(val),
      // Decimal-tolerant by default (money/quantity inputs) with a decimal
      // keyboard. Callers can still supply their own formatters, which run
      // after this default filter.
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      inputFormatters:
          widget.inputFormatters ??
          [FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))],
      textInputAction: widget.textInputAction,
      focusNode: widget.focusNode,
      textCapitalization: widget.textCapitalization,
      textAlignVertical: widget.textAlignVertical,
      decoration: widget.decoration,
      filled: widget.filled,
      fillColor: widget.fillColor,
      prefixIcon:
          widget.prefixIcon ??
          buildPrefixIcon(
            assetPath: AppImages.calculator,
            icon: Icons.lock,
            color: widget.iconColor,
            context: context,
            showIcon: widget.showPrefixIcon,
          ),
      suffixIcon: widget.suffixIcon,
      contentPadding: widget.contentPadding,
      labelText: widget.labelText,
      hintText: widget.hintText ?? SmartLocalizePlaceholder.pleaseEnterNumber,
      isDense: widget.isDense,
      isEnable: widget.isEnable,
      hideAsterisk: widget.hideAsterisk,
      cursorHeight: widget.cursorHeight,
      minLines: widget.minLines,
      maxLines: widget.maxLines,
      maxLength: widget.maxLength,
      textDirection: widget.textDirection,
      hintTextDirection: widget.hintTextDirection,
    );
  }
}
