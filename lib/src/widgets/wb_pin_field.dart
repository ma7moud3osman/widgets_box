import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// A boxed PIN / OTP input — the `PinCodeTextFieldWidget` every app re-implements
/// via `pin_code_fields`, here dependency-free.
///
/// Renders [length] cells with a single transparent [TextField] overlaid to
/// capture input, so focus/paste/backspace behave like a normal field. Reports
/// progress via [onChanged] and fires [onCompleted] when all cells are filled.
class WBPinField extends StatefulWidget {
  final int length;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onCompleted;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final double cellSize;
  final double spacing;
  final double radius;
  final bool autofocus;
  final bool obscure;
  final Color? activeColor;
  final Color? borderColor;
  final Color? fillColor;
  final TextStyle? textStyle;

  const WBPinField({
    super.key,
    this.length = 4,
    this.onChanged,
    this.onCompleted,
    this.controller,
    this.focusNode,
    this.cellSize = 56,
    this.spacing = 10,
    this.radius = 12,
    this.autofocus = false,
    this.obscure = false,
    this.activeColor,
    this.borderColor,
    this.fillColor,
    this.textStyle,
  });

  @override
  State<WBPinField> createState() => _WBPinFieldState();
}

class _WBPinFieldState extends State<WBPinField> {
  late final TextEditingController _controller =
      widget.controller ?? TextEditingController();
  late final FocusNode _focusNode = widget.focusNode ?? FocusNode();
  bool get _ownsController => widget.controller == null;
  bool get _ownsFocus => widget.focusNode == null;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFocusChange);
  }

  void _onFocusChange() => setState(() {});

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    if (_ownsController) _controller.dispose();
    if (_ownsFocus) _focusNode.dispose();
    super.dispose();
  }

  void _onChanged(String value) {
    setState(() {});
    widget.onChanged?.call(value);
    if (value.length == widget.length) widget.onCompleted?.call(value);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final text = _controller.text;
    final active = widget.activeColor ?? theme.colorScheme.primary;
    final idle = widget.borderColor ?? theme.dividerColor;
    final hasFocus = _focusNode.hasFocus;

    final cells = Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(widget.length, (i) {
        final filled = i < text.length;
        final isCurrent = hasFocus && i == text.length;
        return Container(
          width: widget.cellSize,
          height: widget.cellSize,
          margin: EdgeInsets.only(right: i == widget.length - 1 ? 0 : widget.spacing),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: widget.fillColor,
            borderRadius: BorderRadius.circular(widget.radius),
            border: Border.all(
              color: (isCurrent || filled) ? active : idle,
              width: isCurrent ? 1.6 : 1,
            ),
          ),
          child: Text(
            filled ? (widget.obscure ? '•' : text[i]) : '',
            style: widget.textStyle ??
                theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
          ),
        );
      }),
    );

    return GestureDetector(
      onTap: _focusNode.requestFocus,
      child: Stack(
        children: [
          cells,
          Positioned.fill(
            child: TextField(
              controller: _controller,
              focusNode: _focusNode,
              autofocus: widget.autofocus,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              showCursor: false,
              cursorColor: Colors.transparent,
              style: const TextStyle(color: Colors.transparent),
              inputFormatters: [
                LengthLimitingTextInputFormatter(widget.length),
                FilteringTextInputFormatter.digitsOnly,
              ],
              decoration: const InputDecoration(
                counterText: '',
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
              ),
              onChanged: _onChanged,
            ),
          ),
        ],
      ),
    );
  }
}
