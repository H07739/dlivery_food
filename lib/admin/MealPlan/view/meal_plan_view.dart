import 'package:flutter/material.dart';

class MealPlanAdminView extends StatelessWidget {
  const MealPlanAdminView({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: Text('Meal Plan',style: TextStyle(color: Colors.white),),backgroundColor: Colors.deepOrange,),
    );
  }
}
