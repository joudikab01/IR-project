import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../widgets/app_toast.dart';

class Toaster {
  static FToast fToast = FToast();

  static showToast(
    BuildContext context, {
    String? title,
    required String message,
    int duration = 5,
    ToastStatus status = ToastStatus.fail,
  }) {
    fToast.init(context);
    try {
      fToast.removeCustomToast();
    } catch (_) {}
    FocusManager.instance.primaryFocus?.unfocus();
    if (title == null) {
      if (status == ToastStatus.success) {
        title = "success";
      } else if (status == ToastStatus.warning) {
        title = "warning";
      } else {
        title = "failure";
      }
    }
    fToast.showToast(
      child: AppToast(
        title: title,
        message: message,
        status: status,
      ),
      toastDuration: const Duration(seconds: 2),
    );
  }

  static hideToast() {
    fToast.removeCustomToast();
  }
}
