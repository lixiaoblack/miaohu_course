import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

void appLog(msg) {
  var logger = Logger();
  logger.i(msg);
}

void showToastView(msg,
    {Color color = const Color(0xCC000000), int secondsInt = 2}) {
  showToast(
    msg,
    context: Get.context,
    textPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 4.h),
    textStyle: TextStyle(fontSize: 11.sp, color: Colors.white),
    duration: Duration(seconds: secondsInt),
    position: const StyledToastPosition(align: Alignment.center),
    animation: StyledToastAnimation.fade,
    reverseAnimation: StyledToastAnimation.fade,
    backgroundColor: color,
    borderRadius: BorderRadius.circular(5.h),
  );
}
