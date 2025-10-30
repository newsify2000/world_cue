import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:world_cue/presentation/theme/text_style.dart';
import 'package:world_cue/utils/size_config.dart';

enum PinFieldInputType { none, password, custom }

enum PinFieldDecoration {
  defaultPinBoxDecoration,
  underlinedPinBoxDecoration,
  roundedPinBoxDecoration,
  custom
}

class OtpView extends StatefulWidget {
  final int maxLength;
  final PinFieldStyle? otpPinFieldStyle;
  final void Function(String text) onSubmit;
  final PinFieldInputType otpPinFieldInputType;
  final String otpPinInputCustom;
  final PinFieldDecoration otpPinFieldDecoration;
  final TextInputType keyboardType;
  final bool autoFocus;
  final bool highlightBorder;

  const OtpView({
    super.key,
    this.maxLength = 6,
    this.otpPinFieldStyle = const PinFieldStyle(),
    this.otpPinFieldInputType = PinFieldInputType.none,
    this.otpPinFieldDecoration = PinFieldDecoration.defaultPinBoxDecoration,
    this.otpPinInputCustom = "*",
    required this.onSubmit,
    this.keyboardType = TextInputType.number,
    this.autoFocus = true,
    this.highlightBorder = true,
  });

  @override
  State<StatefulWidget> createState() {
    return OtpViewState();
  }
}

class PinFieldStyle {
  final Color activeFieldBackgroundColor;
  final Color defaultFieldBackgroundColor;
  final Color defaultFieldBorderColor;
  final double fieldBorderRadius;
  final double fieldBorderWidth;

  const PinFieldStyle({
    this.defaultFieldBorderColor = Colors.grey,
    this.activeFieldBackgroundColor = Colors.white,
    this.defaultFieldBackgroundColor = Colors.white,
    this.fieldBorderRadius = 2.0,
    this.fieldBorderWidth = 2.0,
  });
}

class OtpViewState extends State<OtpView> with SingleTickerProviderStateMixin {
  late FocusNode _focusNode;
  late List<String> pinsInput;
  bool ending = false;
  bool hasFocus = false;
  String text = "";

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    pinsInput = [];
    for (var i = 0; i < widget.maxLength; i++) {
      pinsInput.add("");
    }
    _focusNode.addListener(_focusListener);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_focusListener);
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: screenWidth(percentage: 16),
      child: Stack(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _buildBody(context),
        ),
        Opacity(
          opacity: 0.0,
          child: TextField(
            maxLength: widget.maxLength,
            autofocus: !kIsWeb ? widget.autoFocus : false,
            enableInteractiveSelection: false,
            inputFormatters: widget.keyboardType == TextInputType.number
                ? <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly]
                : null,
            focusNode: _focusNode,
            keyboardType: widget.keyboardType,
            onSubmitted: (text) {
              if (kDebugMode) {
                print(text);
              }
            },
            onChanged: (text) {
              this.text = text;
              if (ending && text.length == widget.maxLength) {
                return;
              }
              _bindTextIntoWidget(text);
              setState(() {});
              ending = text.length == widget.maxLength;
              if (ending) {
                widget.onSubmit(text);
                FocusScope.of(context).unfocus();
              }
            },
          ),
        )
      ]),
    );
  }

  List<Widget> _buildBody(BuildContext context) {
    var tmp = <Widget>[];
    for (var i = 0; i < widget.maxLength; i++) {
      tmp.add(_buildFieldInput(context, i));
      if (i < widget.maxLength - 1) {
        tmp.add(SizedBox(
          width: ScreenUtil().setWidth(12),
        ));
      }
    }
    return tmp;
  }

  Widget _buildFieldInput(BuildContext context, int i) {
    late Color fieldBorderColor;
    Color? fieldBackgroundColor;
    BoxDecoration boxDecoration;

    if (widget.highlightBorder) {
      fieldBorderColor = Theme.of(context).colorScheme.primary;
      fieldBackgroundColor = widget.highlightBorder && _shouldHighlight(i)
          ? widget.otpPinFieldStyle!.activeFieldBackgroundColor
          : widget.otpPinFieldStyle!.defaultFieldBackgroundColor;
    }

    if (widget.otpPinFieldDecoration == PinFieldDecoration.underlinedPinBoxDecoration) {
      boxDecoration = BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: fieldBorderColor,
            width: 2.0,
          ),
        ),
      );
    } else if (widget.otpPinFieldDecoration == PinFieldDecoration.defaultPinBoxDecoration) {
      boxDecoration = BoxDecoration(
          border: Border.all(
            color: fieldBorderColor,
            width: 2.0,
          ),
          color: fieldBackgroundColor,
          borderRadius: BorderRadius.circular(5.0));
    } else if (widget.otpPinFieldDecoration == PinFieldDecoration.roundedPinBoxDecoration) {
      boxDecoration = BoxDecoration(
        border: Border.all(
          color: fieldBorderColor,
          width: widget.otpPinFieldStyle!.fieldBorderWidth,
        ),
        shape: BoxShape.circle,
        color: fieldBackgroundColor,
      );
    } else {
      boxDecoration = BoxDecoration(
          border: Border.all(
            color: fieldBorderColor,
            width: 2.0,
          ),
          color: fieldBackgroundColor,
          borderRadius: BorderRadius.circular(widget.otpPinFieldStyle!.fieldBorderRadius));
    }

    return InkWell(
      onTap: () {
        _focusNode.requestFocus();
      },
      child: Container(
          width: screenWidth(percentage: 12),
          height: screenWidth(percentage: 12),
          alignment: Alignment.center,
          decoration: boxDecoration,
          child: Text(
            _getPinDisplay(i),
            style: AppTextTheme.titleBoldStyle,
            textAlign: TextAlign.center,
          )),
    );
  }

  String _getPinDisplay(int position) {
    var display = "";
    var value = pinsInput[position];
    switch (widget.otpPinFieldInputType) {
      case PinFieldInputType.password:
        display = "*";
        break;
      case PinFieldInputType.custom:
        display = widget.otpPinInputCustom;
        break;
      default:
        display = value;
        break;
    }
    return value.isNotEmpty ? display : value;
  }

  void _bindTextIntoWidget(String text) {
    ///Reset value
    for (var i = text.length; i < pinsInput.length; i++) {
      pinsInput[i] = "";
    }
    if (text.isNotEmpty) {
      for (var i = 0; i < text.length; i++) {
        pinsInput[i] = text[i];
      }
    }
  }

  void _focusListener() {
    if (mounted == true) {
      setState(() {
        hasFocus = _focusNode.hasFocus;
      });
    }
  }

  bool _shouldHighlight(int i) {
    return hasFocus &&
        (i == text.length || (i == text.length - 1 && text.length == widget.maxLength));
  }
}
