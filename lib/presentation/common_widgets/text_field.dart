import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:world_cue/presentation/theme/text_style.dart';
import 'package:world_cue/utils/size_config.dart';

import 'padding_helper.dart';

Widget textField(
    {Key? key,
    required TextEditingController controller,
    required BuildContext context,
    required String outlineLabel,
    String? title,
    TextInputType keyboardType = TextInputType.text,
    AutovalidateMode? autoValidateMode,
    FocusNode? focusNode,
    int maxLines = 1,
    bool enabled = true,
    bool readOnly = false,
    FormFieldValidator<String>? validator,
    EdgeInsets? margin,
    EdgeInsets? contentPadding,
    TextStyle? outlineLabelStyle,
    Widget? prefixIcon,
    double titleGap = 0,
    bool showAsterisk = false,
    ValueChanged<String>? onFieldSubmitted,
    Function? prefixIconClick,
    TextStyle? style}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(title == null ? "" : "$title${showAsterisk ? "*" : ""}",
          maxLines: 1, overflow: TextOverflow.ellipsis, style: AppTextTheme.bodyBoldStyle),
      Padding(
        padding: padOnly(bottom: titleGap),
        child: boxH4(),
      ),
      CustomFormField(
        context: context,
        key: key,
        focusNode: focusNode,
        enabled: enabled,
        autoValidateMode: autoValidateMode ?? AutovalidateMode.onUserInteraction,
        prefixIcon: prefixIcon,
        prefixIconClick: prefixIconClick,
        validator: validator,
        controller: controller,
        readOnly: readOnly,
        keyboardType: keyboardType,
        maxLines: maxLines,
        onFieldSubmitted: onFieldSubmitted,
        style: style,
        margin: margin,
        contentPadding: contentPadding ??
            EdgeInsets.symmetric(
                vertical: ScreenUtil().setHeight(16.0), horizontal: ScreenUtil().setWidth(20.0)),
        labelStyle: outlineLabelStyle ?? AppTextTheme.bodyStyle,
        outlineLabel: outlineLabel,
      ),
    ],
  );
}

class CustomFormField extends FormField<String> {
  CustomFormField({
    required BuildContext context,
    super.key,
    this.controller,
    String? initialValue,
    FocusNode? focusNode,
    Color? fieldColor,
    InputDecoration? decoration,
    TextInputType? keyboardType,
    String? errorText,
    TextCapitalization textCapitalization = TextCapitalization.none,
    TextInputAction? textInputAction,
    TextStyle? style,
    Widget? prefixIcon,
    Function? prefixIconClick,
    String? outlineLabel,
    TextStyle? outlineLabelStyle,
    int maxLines = 1,
    String? hintText,
    TextStyle? hintStyle,
    Color inActiveBorderColor = Colors.grey,
    TextDirection? textDirection,
    TextAlign textAlign = TextAlign.start,
    bool autofocus = false,
    bool readOnly = false,
    EdgeInsetsGeometry? contentPadding,
    String? labelText,
    TextStyle? labelStyle,
    String obscuringCharacter = '•',
    bool obscureText = false,
    bool autocorrect = true,
    bool autoValidate = false,
    bool expands = false,
    int? maxLength,
    Widget? suffix,
    EdgeInsetsGeometry? margin,
    ValueChanged<String>? onChanged,
    GestureTapCallback? onTap,
    VoidCallback? onEditingComplete,
    ValueChanged<String>? onFieldSubmitted,
    super.onSaved,
    super.validator,
    bool? enabled,
    Color? fillColor,
    double cursorWidth = 2.0,
    AutovalidateMode? autoValidateMode,
    ScrollController? scrollController,
  })  : assert(maxLength == null || maxLength > 0),
        super(
          initialValue: controller != null ? controller.text : (initialValue ?? ''),
          enabled: enabled ?? decoration?.enabled ?? true,
          autovalidateMode: autoValidate
              ? AutovalidateMode.always
              : (autoValidateMode ?? AutovalidateMode.disabled),
          builder: (FormFieldState<String> field) {
            final TextFormFieldState state = field as TextFormFieldState;
            void onChangedHandler(String value) {
              field.didChange(value);
              if (onChanged != null) {
                onChanged(value);
              }
            }

            return Container(
              decoration: BoxDecoration(
                  color: fieldColor ?? Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(ScreenUtil().radius(6))),
              margin: margin ?? EdgeInsets.zero,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  labelText != null ? Text(labelText, style: labelStyle) : Container(),
                  TextField(
                      maxLines: maxLines,
                      controller: state._effectiveController,
                      textAlignVertical: TextAlignVertical.top,
                      focusNode: focusNode,
                      decoration: decoration ??
                          InputDecoration(
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            filled: true,
                            fillColor: fillColor ?? Theme.of(context).colorScheme.onPrimary,
                            alignLabelWithHint: true,
                            prefixIcon: prefixIcon != null
                                ? GestureDetector(
                                    onTap: () => prefixIconClick == null ? null : prefixIconClick(),
                                    child: prefixIcon)
                                : null,
                            labelText: outlineLabel,
                            labelStyle: hintStyle ??
                                AppTextTheme.bodyStyle
                                    .copyWith(color: Theme.of(context).colorScheme.onSurface),
                            hintStyle: hintStyle ??
                                AppTextTheme.bodyStyle
                                    .copyWith(color: Theme.of(context).colorScheme.onSurface),
                            hintText: hintText ?? '',
                            suffix: suffix,
                            contentPadding: contentPadding,
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: inActiveBorderColor, width: ScreenUtil().setHeight(1.0)),
                              borderRadius: BorderRadius.all(
                                Radius.circular(
                                  ScreenUtil().radius(8.0),
                                ),
                              ),
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: inActiveBorderColor, width: ScreenUtil().setHeight(1.0)),
                              borderRadius: BorderRadius.all(
                                Radius.circular(
                                  ScreenUtil().radius(8.0),
                                ),
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: inActiveBorderColor, width: ScreenUtil().setHeight(1.0)),
                              borderRadius: BorderRadius.all(
                                Radius.circular(
                                  ScreenUtil().radius(8.0),
                                ),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).colorScheme.primary,
                                  width: ScreenUtil().setHeight(1.0)),
                              borderRadius: BorderRadius.all(
                                Radius.circular(
                                  ScreenUtil().radius(8.0),
                                ),
                              ),
                            ),
                          ).copyWith(errorText: field.errorText),
                      keyboardType: keyboardType,
                      textInputAction: textInputAction,
                      style: style ?? const TextStyle(),
                      textAlign: textAlign,
                      textDirection: textDirection,
                      textCapitalization: textCapitalization,
                      autofocus: autofocus,
                      readOnly: readOnly,
                      obscuringCharacter: obscuringCharacter,
                      obscureText: obscureText,
                      autocorrect: autocorrect,
                      expands: expands,
                      maxLength: maxLength,
                      onChanged: onChangedHandler,
                      onTap: onTap,
                      onEditingComplete: onEditingComplete,
                      onSubmitted: onFieldSubmitted,
                      enabled: enabled ?? decoration?.enabled ?? true,
                      cursorWidth: cursorWidth,
                      scrollController: scrollController,
                      inputFormatters: [
                        keyboardType == TextInputType.phone
                            ? LengthLimitingTextInputFormatter(10)
                            : LengthLimitingTextInputFormatter(maxLength),
                      ]),
                ],
              ),
            );
          },
        );

  final TextEditingController? controller;

  @override
  TextFormFieldState createState() => TextFormFieldState();
}

class TextFormFieldState extends FormFieldState<String> {
  TextEditingController? _controller;

  TextEditingController? get _effectiveController => widget.controller ?? _controller;

  @override
  CustomFormField get widget => super.widget as CustomFormField;

  @override
  void initState() {
    super.initState();
    if (widget.controller == null) {
      _controller = TextEditingController(text: widget.initialValue);
    } else {
      widget.controller!.addListener(_handleControllerChanged);
    }
  }

  @override
  void didUpdateWidget(CustomFormField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      oldWidget.controller?.removeListener(_handleControllerChanged);
      widget.controller?.addListener(_handleControllerChanged);

      if (oldWidget.controller != null && widget.controller == null) {
        _controller = TextEditingController.fromValue(oldWidget.controller!.value);
      }
      if (widget.controller != null) {
        setValue(widget.controller!.text);
        if (oldWidget.controller == null) _controller = null;
      }
    }
  }

  @override
  void dispose() {
    widget.controller?.removeListener(_handleControllerChanged);
    super.dispose();
  }

  @override
  void didChange(String? value) {
    super.didChange(value);
    if (_effectiveController!.text != value) {
      _effectiveController!.text = value ?? '';
    }
  }

  @override
  void reset() {
    //state will be managed by the superclass so no need to manage state here
    _effectiveController!.text = widget.initialValue ?? '';
    super.reset();
  }

  void _handleControllerChanged() {
    if (_effectiveController!.text != value) {
      didChange(_effectiveController!.text);
    }
  }
}
