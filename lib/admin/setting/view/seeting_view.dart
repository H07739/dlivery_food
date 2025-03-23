import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_project/main.dart';
import 'package:my_project/widgets/MaterialButtonX.dart';

import '../../../Pages/auth/auth_view.dart';

class SeetingView extends StatelessWidget {
  const SeetingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Setting',style: TextStyle(color: Colors.white),),backgroundColor: Colors.deepOrange,),
      body: Column(
        children: [
          Row(children: [
            Expanded(child: MaterialButtonX(text: Text('Log out'), onPressed: (ValueNotifier<bool> keyNotifier) {
              supabase.auth.signOut();
              Get.offAll(()=>AuthView());
      },))
          ],)
        ],
      ),
    );
  }
}
