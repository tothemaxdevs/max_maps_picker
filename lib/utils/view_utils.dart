import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:max_maps_picker/config/colors/pallete.config.dart';
import 'package:max_maps_picker/constants/dimens.constant.dart';

Widget loading({color, bool foldingCube = false}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      foldingCube
          ? SpinKitFadingCube(
              color: color ?? Pallete.primary,
              size: 20,
            )
          : SpinKitThreeBounce(
              color: color ?? Pallete.primary,
              size: 20,
            ),
    ],
  );
}

Widget divideThick({height, color, margin}) {
  return Container(
    height: height ?? Dimens.size2,
    color: color ?? const Color(0xFFF5F5F5),
    margin: margin ?? EdgeInsets.zero,
  );
}

Widget indicatorModal() {
  return Align(
    alignment: Alignment.center,
    child: Container(
      margin: const EdgeInsets.symmetric(vertical: Dimens.size8),
      width: 40,
      height: Dimens.size8,
      decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: const BorderRadius.all(Radius.circular(100))),
    ),
  );
}

void showToastError(String msg) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      fontSize: 16.0);
}
