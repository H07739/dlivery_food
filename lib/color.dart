import 'package:flutter/material.dart';
import 'package:get/get.dart';

 const Color textFieldColor = Color.fromRGBO(168, 160, 149, 0.6);
 const Color primaryColor = Colors.orange;
 const Color secondary = Colors.orangeAccent;
 const Color colorTextField = Color.fromRGBO(249, 249, 249, 0.98);
 const Color kprimaryColor = Color(0xff568A9F);
 const Color kBannerColor = Color(0xff579f8c);


Color backgroundColor = const Color(0xffffffff);
Color textBarColor = const Color(0xff090606);
Color bottomNavigtionBarColor = const Color(0xffffffff);
Color selectBottomItemColor = const Color(0xff579f8c);
Color unselectBottomItemColor = const Color(0xff568A9F);
String? logo_url;

class SeteingModel {
  Color? unselectBottomItemColor;
  Color? selectBottomItemColor;
  Color? bottomNavigtionBarColor;
  Color? textBarColor;
  Color? backgroundColor;
  String? logo_url;

  SeteingModel({
    required this.unselectBottomItemColor,
    required this.selectBottomItemColor,
    required this.bottomNavigtionBarColor,
    required this.textBarColor,
    required this.backgroundColor,
    required this.logo_url,
  });

  factory SeteingModel.fromJson(Map<String, dynamic> json) {
    Color hexToColor(String hexString) {
      hexString = hexString.replaceAll("#", "");
      if (hexString.length == 6) {
        hexString = "ff$hexString"; // إضافة شفافية كاملة إذا لم تكن موجودة
      }
      return Color(int.parse(hexString, radix: 16));
    }


    return SeteingModel(
      unselectBottomItemColor: hexToColor(json['unselectBottomItemColor']),
      selectBottomItemColor: hexToColor(json['selectBottomItemColor']),
      bottomNavigtionBarColor: hexToColor(json['bottomNavigtionBarColor']),
      textBarColor: hexToColor(json['textBarColor']),
      backgroundColor: hexToColor(json['backgroundColor']),
      logo_url: json['logo_url'],
    );
  }
}
