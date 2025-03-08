
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:my_project/Pages/auth/auth_view.dart';
import 'package:my_project/Pages/profile/text_field.dart';
import 'package:my_project/main.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../color.dart';
import '../../widgets/MaterialButtonX.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerEmail = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profile',
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
        ),
        elevation: 2,
        shadowColor: Colors.grey.withOpacity(0.5),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        leading: IconButton(
            onPressed: () => Get.back(), icon: Icon(Icons.arrow_back_ios)),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ListView(
              children: [
                TextFieldEdit(
                  hintText: 'Name',
                  hintTextField: controllerName.text.isEmpty
                      ? 'Enter Name'
                      : controllerName.text,
                  colorTextField: colorTextField,
                  colorText: Colors.black,
                  textEditingController: controllerName,
                ),
                const SizedBox(height: 10),
                TextFieldEdit(
                  hintText: 'Email',
                  hintTextField: controllerEmail.text.isEmpty
                      ? 'Enter Email'
                      : controllerEmail.text,
                  colorTextField: colorTextField,
                  colorText: Colors.black,
                  textInputType: TextInputType.emailAddress,
                  textEditingController: controllerEmail,
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                        child: MaterialButtonX(
                      text: const Text(
                        'Sig out',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: (ValueNotifier<bool> keyNotifier) async {
                        keyNotifier.value = true;
                        await supabase.auth.signOut();
                        keyNotifier.value = false;
                        Get.offAll(() => AuthView());
                      },
                          color: Colors.red,
                    ))
                  ],
                )
              ],
            ),
          ),
          Positioned(
              left: 20,
              right: 20,
              bottom: 20,
              child: MaterialButtonX(
                text: const Text(
                  'Updata',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                onPressed: (ValueNotifier<bool> keyNotifier) async {
                  try {
                    if (controllerName.text.isEmpty ||
                        controllerEmail.text.isEmpty) return;
                    keyNotifier.value = true;
                    await supabase.auth.updateUser(
                      UserAttributes(
                        data: {
                          "name": controllerName.text,
                        },
                      ),
                    );
                    keyNotifier.value = false;
                    setState(() {});
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("User updated successfully")));
                  } catch (e) {
                    print(e);
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text("Error : $e")));
                    keyNotifier.value = false;
                  }
                },
              )),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    String? name = supabase.auth.currentUser!.userMetadata!['name'];
    String? email = supabase.auth.currentUser!.userMetadata!['email'];
    print(supabase.auth.currentUser!.userMetadata);
    if (name != null) {
      setState(() {
        controllerName.text = name;
      });
    }
    if (email != null) {
      setState(() {
        controllerEmail.text = email;
      });
    }
  }
}
