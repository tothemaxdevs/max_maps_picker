import 'package:flutter/material.dart';
import 'package:max_maps_picker/config/colors/pallete.config.dart';
import 'package:max_maps_picker/constants/dimens.constant.dart';
import 'package:max_maps_picker/constants/divider.constant.dart';
import 'package:max_maps_picker/utils/view_utils.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final Color? color;
  final Function()? press;
  final Color? iconColor;
  final Color? textColor;
  final Color? borderColor;
  final double? width;
  final double? heigth;
  final double? borderRadius;
  final double? textSize;
  final FontWeight? fontWeight;

  final bool isLoading;
  final EdgeInsetsGeometry? padding;

  const RoundedButton(
      {Key? key,
      required this.text,
      required this.press,
      this.color,
      this.iconColor,
      this.padding,
      this.textColor,
      this.width,
      this.heigth,
      this.isLoading = false,
      this.borderRadius,
      this.borderColor,
      this.textSize,
      this.fontWeight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: heigth,
      width: width,
      child: Container(
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(Dimens.size10))),
          child: ElevatedButton(
              onPressed: !isLoading ? press ?? null : null,
              style: ButtonStyle(
                  elevation: MaterialStateProperty.all(0),
                  padding: MaterialStateProperty.all(
                      padding ?? const EdgeInsets.all(Dimens.size16)),
                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                      if (states.contains(MaterialState.pressed)) {
                        return Pallete.border;
                      } else if (states.contains(MaterialState.disabled)) {
                        return Pallete.secondary;
                      } else if (states.contains(MaterialState.focused)) {
                        return Pallete.primary;
                      }
                      return color ??
                          Pallete.primary; // Use the component's default.
                    },
                  ),
                  textStyle: MaterialStateProperty.all<TextStyle>(TextStyle(
                      color: textColor ?? Pallete.dark1, fontSize: textSize)),
                  shape:
                      MaterialStateProperty.resolveWith<RoundedRectangleBorder>(
                          (states) {
                    return RoundedRectangleBorder(
                        side: !(states.contains(MaterialState.pressed))
                            ? BorderSide(
                                color: borderColor ?? Colors.transparent)
                            : const BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.circular(
                            borderRadius ?? Dimens.size10));
                  })),
              child: isLoading
                  ? loading(color: Pallete.dark1)
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          text,
                          style: TextStyle(
                              color: textColor ?? Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: textSize),
                        ),
                      ],
                    ))
          // : Text(
          //     text,
          //     style: TextStyle(
          //         color: textColor ?? Colors.black,
          //         fontWeight: fontWeight ?? FontWeight.w500),
          //   ).tr()),
          ),
    );
  }
}
