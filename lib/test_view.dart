import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_project/widgets/MaterialButtonX.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TestView extends StatelessWidget {
  TestView({super.key});
  String ordersKey = 'food_orders';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Test View',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
      ),
      body: Center(
        child: MaterialButtonX(
          text: Text('ok'),
          onPressed: (ValueNotifier<bool> keyNotifier) async{

          },
        ),
      ),
    );
  }


}
