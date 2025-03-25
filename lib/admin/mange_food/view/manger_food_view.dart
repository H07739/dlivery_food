import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_project/admin/edit_food/view/edit_food_view.dart';
import '../../../widgets/FutureBuilderX.dart';
import '../../add_food/view/add_food_view.dart';
import '../../edit_food/function/get_foods_admin.dart';
import '../../edit_food/model/EditFoodModel.dart';
import '../../edit_food/widget/item_food_admin.dart';

class MangerFoodView extends StatelessWidget {
  MangerFoodView({super.key});
  ValueNotifier<List<EditFoodModel>> dataFood = ValueNotifier([]);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Manger Food',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.deepOrange,

      ),
      body: Column(
        children: [
          ListTile(
            onTap: () => Get.to(AddFoodView()),
            leading: Icon(
              Icons.food_bank,
              color: Colors.blue,
            ),
            title:
                Text('Add Food', style: TextStyle(fontWeight: FontWeight.bold)),
            trailing: Icon(Icons.arrow_forward),
          ),
          Divider(),
          ListTile(
            onTap: () => Get.to(EditFoodView()),
            leading: Icon(
              Icons.food_bank_sharp,
              color: Colors.orangeAccent,
            ),
            title:
            Text('My Food', style: TextStyle(fontWeight: FontWeight.bold)),
            trailing: Icon(Icons.arrow_forward),
          ),
          Divider(),

        ],
      ),
    );
  }
}
