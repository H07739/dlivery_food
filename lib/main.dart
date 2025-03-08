import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:my_project/Pages/add_food/view/add_food_view.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:my_project/Pages/auth/auth_view.dart';
import 'package:my_project/Pages/auth/wellcom_view.dart';

import 'Pages/category/view/add_category.dart';
import 'Pages/home/view/food_detail_view.dart';

late SupabaseClient supabase;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialisation de Supabase
  await Supabase.initialize(
    url: 'https://nbwsqixsnycekwvdyxsl.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im5id3NxaXhzbnljZWt3dmR5eHNsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzgyODE3MjgsImV4cCI6MjA1Mzg1NzcyOH0.XJXaG-bQzhof2MwHwHMsTeMbat9fiG8fULI0N2oVPCQ',
  );

  supabase = Supabase.instance.client;

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false, //test hussein
      title: 'My Project fgdfg',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: supabase.auth.currentUser != null ?  RestaurantHomePage() : const AuthView(),


    );

  }
}


