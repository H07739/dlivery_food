import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_project/main.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../widgets/MaterialButtonX.dart';
import '../../profile/text_field.dart';
import 'package:my_project/main.dart';

class Loginview extends StatelessWidget {
  Loginview({super.key});
  TextEditingController controllerEmail=TextEditingController();
  TextEditingController controllerPassword=TextEditingController();

  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              width: double.infinity,
            ),
            const SizedBox(
              width: double.infinity,
            ),
            const SizedBox(
              height: 40,
            ),
            const Icon(
              Icons.lock,
              size: 50,
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Login Now To  Company ',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFieldEdit(hintTextField: 'Enter your Email', textEditingController: controllerEmail, hintText: 'Email',textInputType: TextInputType.emailAddress,),
            TextFieldEdit(hintTextField: 'Enter your Password', textEditingController: controllerPassword, hintText: 'Password',textInputType: TextInputType.text,),
            const SizedBox(height: 10,),
            Row(children:[ Expanded(child: MaterialButtonX(onPressed: (ValueNotifier<bool> keyNotifier) async{
              try{
                if(controllerEmail.text.isEmpty || controllerPassword.text.isEmpty)return;
                keyNotifier.value=true;
                await supabase.auth.signInWithPassword(email:controllerEmail.text,password: controllerPassword.text);
                keyNotifier.value=false;



                Widget nextView = await check();
                Get.off(() => nextView);



              }
              on AuthException catch(e){
                keyNotifier.value=false;
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message)));
              }
              catch(e){
                    keyNotifier.value=false;
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error : $e")));
                  }
            }, text: const Text('Login',style: TextStyle(color: Colors.white),),))])

          ],
        ),
      ),
    );
  }
}