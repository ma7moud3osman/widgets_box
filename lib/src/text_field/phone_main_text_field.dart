part of 'main_text_field.dart';

class _PhoneMainTextField extends MainTextField {
  final void Function(CountryCode)? onChangedCountryCode;
  final List<String> favoriteCountryCode;
  final String? countryCode;

  const _PhoneMainTextField({
    required this.onChangedCountryCode,
    required this.countryCode,
    required this.favoriteCountryCode,
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
    required super.textDirection,
    required super.titleStyle,
    required super.showPrefixIcon,
    required super.minLines,
    required super.maxLines,
    required super.maxLength,
    required super.hintTextDirection,
  });

  @override
  State<_PhoneMainTextField> createState() => _PhoneMainTextFieldState();
}

class _PhoneMainTextFieldState extends State<_PhoneMainTextField> {
  @override
  Widget build(BuildContext context) {
    return MainTextField(
      autofillHints: [AutofillHints.username],
      maxWidth: widget.maxWidth,
      title: widget.title ?? SmartLocalize.phone,
      spaceBetween: widget.spaceBetween,
      onTap: widget.onTap,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        NoLeadingZeroInputFormatter(),
        ...?widget.inputFormatters,
      ],
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
      validator: widget.validator ?? (val) => validatePhoneFormat(val),
      textInputAction: widget.textInputAction,
      focusNode: widget.focusNode,
      textCapitalization: widget.textCapitalization,
      textAlignVertical: widget.textAlignVertical,
      decoration: widget.decoration,
      prefixIcon:
          widget.prefixIcon ??
          (widget.showPrefixIcon
              ? CountryCodePicker(
                  dialogSize: Size(300, 500),
                  textStyle: Theme.of(context).textTheme.bodyMedium,
                  onChanged: widget.onChangedCountryCode,
                  padding: EdgeInsets.zero,
                  initialSelection: widget.countryCode,
                  flagWidth: 30,
                  showCountryOnly: false,
                  showOnlyCountryWhenClosed: false,
                  favorite: widget.favoriteCountryCode,
                  flagDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                  ),
                )
              : null),
      suffixIcon: widget.suffixIcon,
      contentPadding: widget.contentPadding,
      labelText: widget.labelText,
      isDense: widget.isDense,
      isEnable: widget.isEnable,
      hideAsterisk: widget.hideAsterisk,
      cursorHeight: widget.cursorHeight,
      minLines: widget.minLines,
      maxLines: widget.maxLines,
      maxLength: widget.maxLength,
      hintTextDirection: widget.hintTextDirection,
      keyboardType: TextInputType.phone,
      hintText: widget.hintText ?? SmartLocalizePlaceholder.enterPhone,
      textDirection: widget.textDirection,
      filled: widget.filled,
      fillColor: widget.fillColor,
      titleStyle: widget.titleStyle,
    );
  }
}

class NoLeadingZeroInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // If the new value starts with '0' and is not empty, revert to the old value
    if (newValue.text.startsWith('0')) {
      return oldValue;
    }
    return newValue;
  }
}
