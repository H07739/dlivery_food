import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Create a controller to manage theme colors
class ThemeController extends GetxController {
  static ThemeController get to => Get.find();

  final backgroundColor = const Color(0xffffffff).obs;
  final textBarColor = const Color(0xff090606).obs;
  final bottomNavigtionBarColor = const Color(0xffffffff).obs;
  final selectBottomItemColor = const Color(0xff579f8c).obs;
  final unselectBottomItemColor = const Color(0xff568A9F).obs;
  final logoUrl = RxString('');

  // Other static colors
  static const Color textFieldColor = Color.fromRGBO(168, 160, 149, 0.6);
  static const Color primaryColor = Colors.orange;
  static const Color secondary = Colors.orangeAccent;
  static const Color colorTextField = Color.fromRGBO(249, 249, 249, 0.98);
  static const Color kprimaryColor = Color(0xff568A9F);
  static const Color kBannerColor = Color(0xff579f8c);

  void updateColors({
    Color? backgroundColor,
    Color? textBarColor,
    Color? bottomNavigtionBarColor,
    Color? selectBottomItemColor,
    Color? unselectBottomItemColor,
    String? logoUrl,
  }) {
    if (backgroundColor != null) this.backgroundColor.value = backgroundColor;
    if (textBarColor != null) this.textBarColor.value = textBarColor;
    if (bottomNavigtionBarColor != null) this.bottomNavigtionBarColor.value = bottomNavigtionBarColor;
    if (selectBottomItemColor != null) this.selectBottomItemColor.value = selectBottomItemColor;
    if (unselectBottomItemColor != null) this.unselectBottomItemColor.value = unselectBottomItemColor;
    if (logoUrl != null) this.logoUrl.value = logoUrl;
  }
}

class SettingModel {
  final Color? unselectBottomItemColor;
  final Color? selectBottomItemColor;
  final Color? bottomNavigtionBarColor;
  final Color? textBarColor;
  final Color? backgroundColor;
  final String? logo_url;

  SettingModel({
    this.unselectBottomItemColor,
    this.selectBottomItemColor,
    this.bottomNavigtionBarColor,
    this.textBarColor,
    this.backgroundColor,
    this.logo_url,
  });

  factory SettingModel.fromJson(Map<String, dynamic> json) {
    Color? parseColor(dynamic value) {
      if (value == null) return null;
      try {
        // Handle both hex string formats (0x and #)
        String colorStr = value.toString();
        if (colorStr.startsWith('0x')) {
          return Color(int.parse(colorStr.replaceFirst('0x', '0xff')));
        } else if (colorStr.startsWith('#')) {
          return Color(int.parse(colorStr.replaceFirst('#', '0xff')));
        } else {
          // If it's just a hex number without prefix
          return Color(int.parse('0xff' + colorStr.padLeft(6, '0')));
        }
      } catch (e) {
        print('Error parsing color: $e');
        return null;
      }
    }

    return SettingModel(
      unselectBottomItemColor: parseColor(json['unselectBottomItemColor']),
      selectBottomItemColor: parseColor(json['selectBottomItemColor']),
      bottomNavigtionBarColor: parseColor(json['bottomNavigtionBarColor']),
      textBarColor: parseColor(json['textBarColor']),
      backgroundColor: parseColor(json['backgroundColor']),
      logo_url: json['logo_url'],
    );
  }

  void applyToController() {
    final controller = ThemeController.to;
    controller.updateColors(
      backgroundColor: backgroundColor,
      textBarColor: textBarColor,
      bottomNavigtionBarColor: bottomNavigtionBarColor,
      selectBottomItemColor: selectBottomItemColor,
      unselectBottomItemColor: unselectBottomItemColor,
      logoUrl: logo_url,
    );
  }
}
