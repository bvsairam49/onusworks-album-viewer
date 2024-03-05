import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

enum ErrorStatus {
  success,
  error,
  inProgress,
}

class Toast {
  static void showCustomToast(
      {required BuildContext context,
      required String message,
      ErrorStatus status = ErrorStatus.success}) {
    showToast(message,
        context: context,
        animation: StyledToastAnimation.slideFromTop,
        reverseAnimation: StyledToastAnimation.slideToTop,
        position: StyledToastPosition.top,
        startOffset: Offset(0.0, -3.0),
        reverseEndOffset: Offset(0.0, -3.0),
        duration: Duration(seconds: 3),
        //Animation duration   animDuration * 2 <= duration
        animDuration: Duration(seconds: 1),
        curve: Curves.elasticOut,
        reverseCurve: Curves.fastOutSlowIn,
        backgroundColor: status == ErrorStatus.error
            ? Colors.red.shade500
            : status == ErrorStatus.success
                ? Colors.green.shade500
                : Colors.blue.shade500);
  }
}
