import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_project/main.dart';
import 'package:my_project/strings.dart';
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

           // var data = await supabase.from(Table_Food).select('*, $Table_Favorites(id_user)').eq('$Table_Favorites.id_user', '637b89a5-ef22-48ad-8b25-6cf2b0af7a29');
            //print(data);
          },
        ),
      ),
    );
  }


}
