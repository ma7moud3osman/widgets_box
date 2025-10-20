part of 'main_text_field.dart';

class _PasswordMainTextField extends MainTextField {
  const _PasswordMainTextField({
    required super.maxWidth,
    required super.title,
    required super.titleStyle,
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
    required super.showPrefixIcon,
    required super.iconColor,
  });

  @override
  State<_PasswordMainTextField> createState() => _PasswordMainTextFieldState();
}

class _PasswordMainTextFieldState extends State<_PasswordMainTextField> {
  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    return MainTextField(
      autofillHints: [AutofillHints.password],
      maxWidth: widget.maxWidth,
      title: widget.title ?? SmartLocalize.password,
      isRequired: widget.isRequired,
      hideAsterisk: widget.hideAsterisk,
      spaceBetween: widget.spaceBetween,
      onTap: widget.onTap,
      validator: widget.validator ?? (val) => validatePasswordFormat(val),
      inputFormatters: [
        FilteringTextInputFormatter.deny(RegExp(r'\s')),
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
      textInputAction: widget.textInputAction,
      focusNode: widget.focusNode,
      textCapitalization: widget.textCapitalization,
      textAlignVertical: widget.textAlignVertical,
      decoration: widget.decoration,
      filled: widget.filled,
      fillColor: widget.fillColor,
      hintText: widget.hintText ?? SmartLocalizePlaceholder.enterPassword,
      prefixIcon:
          widget.prefixIcon ??
          PrefixIconWidget(
            assetPath: AppImages.lock,
            color: widget.iconColor,
            isShow: widget.showPrefixIcon,
          ),
      suffixIcon:
          widget.suffixIcon ??
          IconButton(
            onPressed: () => setState(() {
              showPassword = !showPassword;
            }),
            icon: PrefixIconWidget(
              assetPath: showPassword ? AppImages.eyeSlash : AppImages.eye,
              color: widget.iconColor,
              isShow: true,
            ),
          ),
      contentPadding: widget.contentPadding,
      labelText: widget.labelText,
      isDense: widget.isDense,
      isEnable: widget.isEnable,
      cursorHeight: widget.cursorHeight,
      showPrefixIcon: widget.showPrefixIcon,
      obscureText: !showPassword,
      obscuringCharacter: '*',
      textDirection: widget.textDirection,
      keyboardType: TextInputType.visiblePassword,
      minLines: widget.minLines,
      maxLines: widget.maxLines,
      maxLength: widget.maxLength,
      showAsterisk: widget.showAsterisk,
      titleStyle: widget.titleStyle,
    );
  }
}
