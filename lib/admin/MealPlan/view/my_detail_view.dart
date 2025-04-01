import 'package:flutter/material.dart';
import 'package:my_project/admin/MealPlan/model/detail_model.dart';
import 'package:my_project/admin/MealPlan/widget/item_detail.dart';
import 'package:my_project/main.dart';
import 'package:my_project/strings.dart';
import 'package:my_project/widgets/FutureBuilderX.dart';

class MyDetailView extends StatelessWidget {
  MyDetailView({super.key});

  ValueNotifier<int> fetchTrigger = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: Text(
          'My Detail',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.deepOrange,
      ),
      body: ValueListenableBuilder<int>(
        valueListenable: fetchTrigger,
        builder: (context, _, __) {
          return FutureBuilderX<List<DetailModel>>(
            future: () async {

              List<Map<String, dynamic>> details = await supabase
                  .from(Table_Detail)
                  .select('*')
                  .eq('admin', supabase.auth.currentUser!.id)
                  .order('id', ascending: false);
              return details.map((detail) => DetailModel.fromJson(detail)).toList();
            },
            loadingView: Center(
              child: CircularProgressIndicator(),
            ),
            errorView: (String error, ValueNotifier<int> keyNotifier) {
              return Text(error);
            },
            doneView: (List<DetailModel> data, ValueNotifier<int> keyNotifier) {
              if (data.isEmpty) {
                return Center(
                  child: Text(
                    'No Details found',
                    style: TextStyle(color: Colors.white),
                  ),
                );
              }
              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (BuildContext context, int index) {
                  return ItemDetail(
                    model: data[index],
                    index: index,
                    onDelete: (int index) async {
                      fetchTrigger.value++;
                    },
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
