import 'package:flutter/material.dart';

import '../../../widgets/bottomNavigationBar.dart';
import '../../mange_category/view/mange_category_view.dart';
import '../../mange_food/view/manger_food_view.dart';

class AdminView extends StatefulWidget {
  const AdminView({super.key});

  @override
  State<AdminView> createState() => _AdminViewState();
}

class _AdminViewState extends State<AdminView> {
  List<Widget> pages=[
    MangerFoodView(),
    MangeCategoryView(),
  ];
  int index=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomnavigationbarAdmin(
        index: (int index) {
          setState(() {
            this.index = index;
          });

        },
      ),
      body: pages[index],
    );
  }
}

