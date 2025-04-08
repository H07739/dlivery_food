import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_project/admin/edit_food/controller/food_controller.dart';
import 'package:my_project/admin/edit_food/function/get_foods_admin.dart';
import 'package:my_project/admin/edit_food/widget/item_food_admin.dart';
import 'package:my_project/widgets/FutureBuilderX.dart';

import '../model/EditFoodModel.dart';

class EditFoodView extends StatelessWidget {
  EditFoodView({super.key});
  FoodController controller = Get.put(FoodController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Food',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.deepOrange,
      ),
      body: FutureBuilderX<List<EditFoodModel>>(
        future: () => getFoodsAdmin(),
        loadingView: Center(
          child: CircularProgressIndicator(),
        ),
        errorView: (String error, ValueNotifier<int> keyNotifier) {
          return Text(error);
        },
        doneView: (List<EditFoodModel> data, ValueNotifier<int> keyNotifier) {


            if (data.isEmpty) {
              return Center(
                child: Text(
                  'You is not have any food',
                  style: TextStyle(fontSize: 22),
                ),
              );
            }
            controller.setFoods(data);

            return Obx(()=>
              ListView.builder(
                itemCount: controller.foods.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ItemFoodAdmin(
                      model: controller.foods[index],
                      controller: controller,
                    ),
                  );
                },
              ),
            );

        },
      ),
    );
  }
}
