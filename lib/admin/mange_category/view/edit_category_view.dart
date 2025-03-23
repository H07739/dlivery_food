import 'package:flutter/material.dart';
import 'package:my_project/admin/mange_category/function/get_category.dart';
import 'package:my_project/admin/mange_category/widget/item_categort_admin.dart';
import 'package:my_project/widgets/FutureBuilderX.dart';

import '../model/category_admin_model.dart';

class EditCategoryView extends StatelessWidget {
  EditCategoryView({super.key});
  ValueNotifier<List<CategoryAdminModel>> categoryList = ValueNotifier([]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Category',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.deepOrange,
      ),
      body: FutureBuilderX<List<CategoryAdminModel>>(
        future: () => getCategory(),
        loadingView: Center(
          child: CircularProgressIndicator(),
        ),
        errorView: (String error, ValueNotifier<int> keyNotifier) {
          return Text(error);
        },
        doneView:
            (List<CategoryAdminModel> data, ValueNotifier<int> keyNotifier) {
          if (categoryList.value != data) {
            categoryList.value = data;
          }
          return ValueListenableBuilder<List<CategoryAdminModel>>(
            valueListenable: categoryList,
            builder: (BuildContext context, List<CategoryAdminModel> value,
                Widget? child) {
              if (value.isEmpty) {
                return Center(
                    child: Text(
                  'No Category found',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ));
              }
              return ListView.builder(
                  itemCount: categoryList.value.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ItemCategortAdmin(
                      model: value[index],
                      categoryList: categoryList,
                      index: index,
                    );
                  });
            },
          );
        },
      ),
    );
  }
}
