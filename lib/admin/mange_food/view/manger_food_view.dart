import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Pages/add_food/view/add_food_view.dart';

class MangerFoodView extends StatelessWidget {
  const MangerFoodView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Manger Food',style: TextStyle(color: Colors.white),),backgroundColor:Colors.orangeAccent,),
      body: Column(

        children: [

          ListTile(
            onTap: ()=>Get.to(AddFoodView()),
            leading: Icon(Icons.food_bank,color: Colors.blue,),
            title: Text('Add Food', style: TextStyle(fontWeight: FontWeight.bold)),
            trailing: Icon(Icons.arrow_forward),),
          Divider(),
        ],
      ),
    );
  }
}
