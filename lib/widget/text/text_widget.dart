import 'package:flutter/material.dart';
import 'package:max_maps_picker/constants/dimens.constant.dart';

enum TextWidgetSize { h1, h2, h3, h4, h5, h6, h7, h8, h9 }

class TextWidget extends StatelessWidget {
  final String? text;
  final Color? textColor;
  final Color? color;
  final bool? ellipsed;
  final bool? isCurrency;
  TextAlign? textAlign;
  double? fontSize;
  int? maxLines;
  int? maxLength;
  final FontWeight? weight;
  final TextWidgetSize? size;
  TextWidget(this.text,
      {Key? key,
      this.textColor,
      this.color,
      this.ellipsed = false,
      this.size,
      this.weight,
      this.isCurrency = false,
      this.maxLength,
      this.fontSize,
      this.maxLines,
      this.textAlign})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (size) {
      case TextWidgetSize.h9:
        fontSize = Dimens.size8;
        break;
      case TextWidgetSize.h8:
        fontSize = Dimens.size10;
        break;
      case TextWidgetSize.h7:
        fontSize = Dimens.size12;
        break;
      case TextWidgetSize.h6:
        fontSize = Dimens.size14;
        break;
      case TextWidgetSize.h5:
        fontSize = Dimens.size16;
        break;
      case TextWidgetSize.h4:
        fontSize = Dimens.size18;
        break;
      case TextWidgetSize.h3:
        fontSize = Dimens.size20;
        break;
      case TextWidgetSize.h2:
        fontSize = Dimens.size24;
        break;
      case TextWidgetSize.h1:
        fontSize = Dimens.size32;
        break;
      default:
    }
    return Text(
      maxLength != null && text!.length > num.tryParse('$maxLength')!
          ? '${text!.substring(0, maxLength)}...'
          : '$text',
      maxLines: maxLines,
      textAlign: textAlign,
      style: TextStyle(
          color: textColor ?? color ?? Colors.black,
          overflow:
              ellipsed == true ? TextOverflow.ellipsis : TextOverflow.visible,
          fontSize: fontSize ?? Dimens.size16,
          fontWeight: weight),
    );
  }
}

extension ExtendedText on TextWidget {
  addMargin({padding}) {
    return Container(
      margin: EdgeInsets.all(padding ?? Dimens.size16),
      child: this,
    );
  }

  addMarginV({vertical}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: vertical ?? Dimens.size6),
      child: this,
    );
  }

  addMarginH({horizontal}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: horizontal ?? Dimens.size16),
      child: this,
    );
  }

  addPaddingHorizontal({padding}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: padding ?? Dimens.size16),
      child: this,
    );
  }
}
