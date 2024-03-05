import 'package:flutter/material.dart';
import 'package:onusworks_albums_app/core/app_color.dart';

class CustomTextButtonWidget extends StatelessWidget {
  final Widget childWidget;
  final VoidCallback onPressed;
  const CustomTextButtonWidget({
    super.key,
    required this.childWidget,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColor.appBarColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 12.0,
          horizontal: 30.0,
        ),
        textStyle: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w500,
        ),
        foregroundColor: Colors.white,
      ),
      onPressed: onPressed,
      child: childWidget,
    );
  }
}
