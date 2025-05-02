import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:my_project/DataBase/OrderManager.dart';
import 'package:my_project/Pages/home/view/home_view.dart';
import 'package:my_project/color.dart';
import 'package:my_project/strings.dart';
import 'package:my_project/super_admin/home/view/home_view.dart';
import 'package:my_project/test_view.dart';
import 'package:my_project/widgets/FutureBuilderX.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:my_project/Pages/auth/auth_view.dart';
import 'admin/MealPlan/view/manger_orders_view.dart';
import 'admin/home/view/admin_view.dart';
import 'admin/setting/model/manger_model.dart';
import 'package:get/get.dart';

late SupabaseClient supabase;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Supabase
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
      debugShowCheckedModeBanner: false,
      title: 'My Project',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
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
}

Future<Widget> check() async {
  try {
    // Load theme colors
    List<Map<String, dynamic>> settings = await supabase
        .from(Table_Seteing)
        .select()
        .eq('id', 1);

    SeteingModel seteingModel = SeteingModel.fromJson(settings.first);

    backgroundColor = seteingModel.backgroundColor ?? backgroundColor;
    textBarColor = seteingModel.textBarColor ?? textBarColor;
    bottomNavigtionBarColor = seteingModel.bottomNavigtionBarColor ?? bottomNavigtionBarColor;
    selectBottomItemColor = seteingModel.selectBottomItemColor ?? selectBottomItemColor;
    unselectBottomItemColor = seteingModel.unselectBottomItemColor ?? unselectBottomItemColor;
    logo_url = seteingModel.logo_url;
    print(logo_url);

  } catch (e) {
    print('Error loading theme settings: $e');
  }

  final user = supabase.auth.currentUser;

  if (user == null) {
    return HomeView();
  }

  List<Map<String, dynamic>> superAdmin = await supabase
      .from(Table_Super_Admin)
      .select('*')
      .eq('uuid', supabase.auth.currentUser!.id);

  List<Map<String, dynamic>> admin = await supabase
      .from(Table_Admins)
      .select('*')
      .eq('uuid', supabase.auth.currentUser!.id);

  List<Map<String, dynamic>> manger = await supabase
      .from(Table_Manger)
      .select('*')
      .eq('id_user', supabase.auth.currentUser!.id);

  if (superAdmin.isNotEmpty) {
    return SuperAdminHomeView();
  } else if (admin.isNotEmpty) {
    await supabase.auth.updateUser(
      UserAttributes(
        data: {
          "admin": true,
        },
      ),
    );
    return AdminView();
  } else if (manger.isNotEmpty) {
    return MangerOrdersView(model: MangerModel.fromJson(manger[0]));
  } else {
    return HomeView();
  }
}
