import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

showToast({required String msg, String type = "Error"}) {
  String title = "";
  ToastificationType toastType = ToastificationType.error;
  Color descriptionColor = Colors.black; // Default description color
  if (type == "Success") {
    title = "Success:";
    toastType = ToastificationType.success;
    descriptionColor = Colors.green.shade900; // Example: Dark green for success
  } else if (type == "Warning") {
    title = "Warning:";
    toastType = ToastificationType.warning;
    descriptionColor =
        Colors.orange.shade900; // Example: Dark orange for warning
  } else if (type == "Info") {
    title = "Info:";
    toastType = ToastificationType.info;
    descriptionColor = Colors.blue.shade900; // Example: Dark blue for info
  } else if (type == "Error") {
    title = "Error:";
    toastType = ToastificationType.error;
    descriptionColor = Colors.red.shade900; // Example: Dark red for error
  }
  return toastification.show(
    type: toastType,
    style: ToastificationStyle.flatColored,
    autoCloseDuration: const Duration(seconds: 4),
    // title: Text(title),
    // you can also use RichText widget for title and description parameters
    description: RichText(
      text: TextSpan(
        text: "$title $msg",
        style: TextStyle(
          color: descriptionColor,
          fontWeight: FontWeight.w500,
          fontSize: 16,
        ), // Apply the color here
      ),
    ),
    alignment: Alignment.topCenter,
    animationDuration: const Duration(milliseconds: 300),

    showIcon: true, // show or hide the icon
    showProgressBar: false,
    closeOnClick: false,
    pauseOnHover: true,
    dragToClose: true,
  );
}
