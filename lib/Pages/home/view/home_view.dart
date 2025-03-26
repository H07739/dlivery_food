import 'package:flutter/material.dart';

import '../../../widgets/bottomNavigationBar.dart';
import '../../meal_plan/view/meal_plan_view.dart';
import '../../profile/profile_view.dart';
import 'home_main.dart';
import 'favorite_screen.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
} 

class _HomeViewState extends State<HomeView> {
  List<Widget> pages=[
    HomeMain(),
    FavoriteScreen(),
    MealPlanView(),
    ProfileView(),
  ];
  int index=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomnavigationbarX(
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

