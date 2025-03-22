import 'package:flutter/material.dart';
import 'package:my_project/admin/edit_food/function/get_foods_admin.dart';
import 'package:my_project/admin/edit_food/widget/item_food_admin.dart';
import 'package:my_project/widgets/FutureBuilderX.dart';

import '../model/EditFoodModel.dart';
import '../model/food_admin_model.dart';

class EditFoodView extends StatelessWidget {
  EditFoodView({super.key});

  ValueNotifier<List<EditFoodModel>> dataFood = ValueNotifier([]);
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

            dataFood.value = data;
            return ValueListenableBuilder<List<EditFoodModel>>(
              valueListenable: dataFood,
              builder: (BuildContext context, List<EditFoodModel> value,
                  Widget? child) {
                if (value.isEmpty) {
                  return Center(
                    child: Text(
                      'You is not have any food',
                      style: TextStyle(fontSize: 22),
                    ),
                  );
                }
                return ListView.builder(
                  itemCount: value.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ItemFoodAdmin(
                        model: value[index],
                        onDelete: (int index) {
                          dataFood.value = List.from(dataFood.value)..removeAt(index);


                        },
                        index: index,
                      ),
                    );
                  },
                );
              },
            );

        },
      ),
    );
  }
}
