import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:my_project/DataBase/OrderManager.dart';
import 'package:my_project/Pages/home/view/home_view.dart';
import 'package:my_project/strings.dart';
import 'package:my_project/test_view.dart';
import 'package:my_project/widgets/FutureBuilderX.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:my_project/Pages/auth/auth_view.dart';

import 'admin/home/view/admin_view.dart';

late SupabaseClient supabase;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialisation de Supabase
  await Supabase.initialize(
    url: 'https://nbwsqixsnycekwvdyxsl.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im5id3NxaXhzbnljZWt3dmR5eHNsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzgyODE3MjgsImV4cCI6MjA1Mzg1NzcyOH0.XJXaG-bQzhof2MwHwHMsTeMbat9fiG8fULI0N2oVPCQ',
  );

  supabase = Supabase.instance.client;
  setupOrderListener();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false, //
      title: 'My Project fgdfg',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      //home: AdminView(),
      home: FutureBuilderX<Widget>(
        future: () => check(),
        loadingView: Material(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ),
        errorView: (String error, ValueNotifier<int> keyNotifier) {
          return Text(error);
        },
        doneView: (Widget data, ValueNotifier<int> keyNotifier) {
          return data;
        },
      ),
    );
  }

  Future<Widget> check() async {
    final user = supabase.auth.currentUser;

    if (user == null) {
      return const AuthView();
    }

    List<Map<String, dynamic>> admin = await supabase
        .from(Table_Admins)
        .select('*')
        .eq('uuid', supabase.auth.currentUser!.id);

    if (admin.isNotEmpty) {
      await supabase.auth.updateUser(
        UserAttributes(
          data: {
            "admin": true,
          },
        ),
      );
      return AdminView();
    } else {
      return HomeView();
    }
  }
}
