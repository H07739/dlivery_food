import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../color.dart';

class MaterialButtonX extends StatelessWidget {
  MaterialButtonX({super.key,required this.onPressed,required this.text,this.padding,this.color,this.height,this.circular});
  Color? color;
  double? height;
  double? circular;
  Text text;
  EdgeInsetsGeometry? padding;
  Function(ValueNotifier<bool> keyNotifier) onPressed;
  final ValueNotifier<bool> _keyNotifier = ValueNotifier(false);
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: _keyNotifier,
      builder: (BuildContext context, bool value, Widget? child) {
        return Padding(
          padding: padding ?? const EdgeInsets.all(8),
          child: Obx(()=>MaterialButton(
              onPressed:()=>onPressed(_keyNotifier),
              color: color ?? ThemeController.primaryColor,
              height: height ?? 50,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(circular ?? 8),
              ),
              child: value
                  ? const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Colors.white),
              )
                  : text,
            ),
          ),
        );
      },
    );
  }
}
