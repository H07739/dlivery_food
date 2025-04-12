import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'add_detail_view.dart';
import 'manger_orders_view.dart';
import 'my_detail_view.dart';

class MealPlanAdminView extends StatelessWidget {
  const MealPlanAdminView({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: Text('Meal Plan',style: TextStyle(color: Colors.white),),backgroundColor: Colors.deepOrange,),
      body: Column(children: [

        // ListTile(
        //   onTap: ()=>Get.to(()=>AddDetailView()),
        //   leading: Icon(Icons.details,color: Colors.green,),
        //   title: Text('Add Detail', style: TextStyle(fontWeight: FontWeight.bold)),
        //   trailing: Icon(Icons.arrow_forward),),
        Divider(),
        // ListTile(
        //   onTap: ()=>Get.to(()=>MyDetailView()),
        //   leading: Icon(Icons.details,color: Colors.deepPurple,),
        //   title: Text('my Detail', style: TextStyle(fontWeight: FontWeight.bold)),
        //   trailing: Icon(Icons.arrow_forward),),
        Divider(),
      ],),
    );
  }
}
