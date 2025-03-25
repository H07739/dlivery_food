import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'add_category.dart';
import 'edit_category_view.dart';

class MangeCategoryView extends StatelessWidget {
  const MangeCategoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Mange Category',style: TextStyle(color: Colors.white),),backgroundColor: Colors.deepOrange,),
      body: Column(
        children: [
          ListTile(
            onTap: ()=>Get.to(AddCategory()),
            leading: Icon(Icons.category_outlined,color: Colors.blue,),
            title: Text('Add Category', style: TextStyle(fontWeight: FontWeight.bold)),
            trailing: Icon(Icons.arrow_forward),),
          Divider(),
          ListTile(
            onTap: ()=>Get.to(EditCategoryView()),
            leading: Icon(Icons.category,color: Colors.red,),
            title: Text('My Category', style: TextStyle(fontWeight: FontWeight.bold)),
            trailing: Icon(Icons.arrow_forward),),
          Divider(),

        ],
      ),
    );
  }
}
