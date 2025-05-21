import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_project/Pages/auth/auth_view.dart';
import 'package:my_project/Pages/auth/login/loginView.dart';
import 'package:my_project/Pages/meal_plan/function/get_requests.dart';
import 'package:my_project/Pages/meal_plan/widget/meal_plan_item.dart';
import 'package:my_project/main.dart';
import 'package:my_project/widgets/FutureBuilderX.dart';

import '../../../color.dart';
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
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text('Historical',style: TextStyle(color: textBarColor),),
        backgroundColor:backgroundColor,
      ),
      body: supabase.auth.currentUser != null?FutureBuilderX<List<MealPlanModel>>(
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
      ):Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.lock_outline, size: 60, color: Colors.grey),
            SizedBox(height: 16),
            Text(
              'You need to log in first',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                Get.to(AuthView());
              },
              child: Text('Login'),
            ),
          ],
        ),
      )

      ,
    );
  }
}

