import 'package:flutter/material.dart';
import 'package:my_project/Pages/meal_plan/function/get_requests.dart';
import 'package:my_project/Pages/meal_plan/widget/meal_plan_item.dart';
import 'package:my_project/widgets/FutureBuilderX.dart';

import '../../shopping_cart/model/FoodOrderModel.dart';
import '../model/meal_plan_model.dart';

class MealPlanView extends StatefulWidget {
  const MealPlanView({super.key});

  @override
  State<MealPlanView> createState() => _MealPlanViewState();
}

class _MealPlanViewState extends State<MealPlanView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meal Plan'),
        backgroundColor: Colors.white,
      ),
      body: FutureBuilderX<List<MealPlanModel>>(
        future: () => getRequests(),
        loadingView: Center(
          child: CircularProgressIndicator(),
        ),
        errorView: (String error, ValueNotifier<int> keyNotifier) {
          return Text('Error: $error');
        }, doneView: (List<MealPlanModel> data, ValueNotifier<int> keyNotifier) {
          if(data.isEmpty){
            return Center(child: Text('This Meal Plan is Empty',style: TextStyle(fontSize: 22),),);
          }
        return ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) {
            return MealPlanItem(orderModel: data[index], onTap: () { setState(() {

            }); },);
          },
        );

      },
      ),
    );
  }
}

