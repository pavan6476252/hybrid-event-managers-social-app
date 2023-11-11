import 'package:flutter/material.dart';
import 'package:hybrid/theme/t_constants.dart';

class CustomButtons {
  CustomButtons._();

  static flatButton(
      {required VoidCallback onTap,
      required Widget child,
      Color? bgColor,
      double? borderRadius,
      double? padding}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(padding ?? 8),
        decoration: BoxDecoration(
            borderRadius: BorderRadiusDirectional.circular(borderRadius ?? 12),
            color: bgColor ?? AppColorConstants.black),
        child: child,
      ),
    );
  }
}
