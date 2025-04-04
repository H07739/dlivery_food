import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_project/admin/setting/controller/controller_manger.dart';
import 'package:my_project/admin/setting/function/add_manger.dart';
import 'package:my_project/admin/setting/widget/item_manger.dart';
import 'package:my_project/admin/setting/model/manger_model.dart';
import 'package:my_project/widgets/FutureBuilderX.dart';
import 'package:my_project/widgets/MaterialButtonX.dart';

import '../function/get_mangers.dart';

class MangerView extends StatelessWidget {
  MangerView({super.key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  MangerController controller = Get.put(MangerController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Manager',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.deepOrange,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Name',
                prefixIcon: Icon(Icons.person),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                prefixIcon: Icon(Icons.email),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                  child: MaterialButtonX(
                text: Text(
                  'Add manger',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: (ValueNotifier<bool> keyNotifier) async {
                  final email = _emailController.text.trim();
                  final name = _nameController.text.trim();
                  if (email.isNotEmpty && name.isNotEmpty) {
                    keyNotifier.value = true;
                    await addManger(email: email, name: name, context: context, controller: controller);
                    keyNotifier.value = false;
                  }
                },
              ))
            ],
          ),
          Divider(),
          FutureBuilderX<List<MangerModel>>(
            future: ()=>getMangers(context: context),
            loadingView: Center(child: CircularProgressIndicator(),),
            errorView: (String error, ValueNotifier<int> keyNotifier)=>Text(error),
            doneView: (List<MangerModel> data, ValueNotifier<int> keyNotifier) {
              controller.setManagers(data);
              return Obx(()=>
                  SizedBox(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height / 2,
                    child: ListView.builder(
                      itemCount: controller.managers.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ItemManger(model: controller.managers[index], controller: controller,);
                      },
                    ),
                  ),
              );
            },

          )

        ],
      ),
    );
  }
}
