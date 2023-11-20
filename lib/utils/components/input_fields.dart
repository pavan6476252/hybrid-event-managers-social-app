import 'package:flutter/material.dart';
import 'package:hybrid/theme/t_constants.dart';

class CustomInputFields {
  CustomInputFields._();

  static inputField(
      {required BuildContext context,
      required String hintText,
      double? radius,
      TextEditingController? controller,
      String? title}) {
    TextFormField textFormField = TextFormField(
      controller: controller,
      decoration: InputDecoration(
          filled: true,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(radius ?? 15),
              borderSide: BorderSide(color: AppColorConstants.gray)),
          contentPadding: const EdgeInsets.all(15),
          fillColor: AppColorConstants.white,
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: AppColorConstants.gray,
              ),
              borderRadius: BorderRadius.circular(radius ?? 15)),
          // labelText: 'Name',
          focusColor: AppColorConstants.gray,
          hintText: hintText),
    );
    if (title == null) {
      return textFormField;
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleSmall,
          ),
          const SizedBox(height: 4),
          textFormField
        ],
      );
    }
  }

  static inputFieldWithTailButton(
      {required BuildContext context,
      required String hintText,
      double? radius,
      TextEditingController? controller,
      String? title,
      Color? bgColor,
      required Icon icon,
      required VoidCallback onTap}) {
    TextFormField textFormField = TextFormField(
      controller: controller,
      decoration: InputDecoration(
          suffixIcon: IconButton(
            onPressed: onTap,
            icon: icon,
          ),
          filled: true,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(radius ?? 15),
              borderSide: BorderSide(color: AppColorConstants.gray)),
          contentPadding: const EdgeInsets.all(15),
          fillColor: bgColor ?? AppColorConstants.white,
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: AppColorConstants.gray,
              ),
              borderRadius: BorderRadius.circular(radius ?? 15)),
          // labelText: 'Name',
          focusColor: AppColorConstants.gray,
          hintText: hintText),
    );
    if (title == null) {
      return textFormField;
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleSmall,
          ),
          const SizedBox(height: 4),
          textFormField
        ],
      );
    }
  }

  static diabledInputField({
    required BuildContext context,
    required String hintText,
    required VoidCallback onTap,
    double? radius,
    TextEditingController? controller,
    String? title,
    Icon? icon,
  }) {
    GestureDetector textFormField = GestureDetector(
      onTap: onTap,
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
            suffixIcon: icon,
            enabled: false,
            filled: true,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(radius ?? 15),
                borderSide: BorderSide(color: AppColorConstants.gray)),
            contentPadding: const EdgeInsets.all(15),
            fillColor: AppColorConstants.white,
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: AppColorConstants.gray,
                ),
                borderRadius: BorderRadius.circular(radius ?? 15)),
            // labelText: 'Name',
            focusColor: AppColorConstants.gray,
            hintText: hintText),
      ),
    );
    if (title == null) {
      return textFormField;
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleSmall,
          ),
          const SizedBox(height: 4),
          textFormField
        ],
      );
    }
  }
}
