import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'manger_orders_view.dart';

class MealPlanAdminView extends StatelessWidget {
  const MealPlanAdminView({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: Text('Meal Plan',style: TextStyle(color: Colors.white),),backgroundColor: Colors.deepOrange,),
      body: Column(children: [
        ListTile(
          onTap: ()=>Get.to(()=>MangerOrdersView()),
          leading: Icon(Icons.manage_history,color: Colors.blue,),
          title: Text('Orders', style: TextStyle(fontWeight: FontWeight.bold)),
          trailing: Icon(Icons.arrow_forward),),
        Divider(),
      ],),
    );
  }
}
