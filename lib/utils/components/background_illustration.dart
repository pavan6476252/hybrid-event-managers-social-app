import 'package:flutter/material.dart';
import 'package:hybrid/theme/t_constants.dart';

class BackGroundIllustrations {
  static backGroundIllustration(
      {required BuildContext context,
      double? top,
      double? left,
      double? right,
      double? bottom}) {
    return Positioned(
        top: top,
        left: left,
        bottom: bottom,
        right: right,
        child: Transform.rotate(
            angle: 40,
            child: Container(
              
              padding: EdgeInsets.all(60),
              decoration: BoxDecoration(
                border: Border.all(color: AppColorConstants.mainThemeColor),
                borderRadius: BorderRadius.circular(152),
              ),
              child: Container(
                padding: EdgeInsets.all(60),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColorConstants.mainThemeColor),
                  borderRadius: BorderRadius.circular(152),
                ),
                child: Container(
                  width: 649,
                  height: 575,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(152),
                      color: AppColorConstants.mainThemeColor),
                ),
              ),
            )));
  }
}
