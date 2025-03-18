import 'package:flutter/material.dart';

class FoodDetailModel{
  String name;
  double pirec;
  bool check;

  FoodDetailModel({required this.name,required this.pirec,required this.check});
}

class FoodDetailListModel{
  ValueNotifier<List<FoodDetailModel>> details = ValueNotifier([
    FoodDetailModel(name: 'Cutshup', pirec: 6, check: false),
    FoodDetailModel(name: 'Mayounez', pirec: 8, check: false),
    FoodDetailModel(name: 'Harissa', pirec: 4, check: false),
    FoodDetailModel(name: 'Ouef', pirec: 5, check: false),
  ]);
  ValueNotifier<int> count = ValueNotifier(1);

}