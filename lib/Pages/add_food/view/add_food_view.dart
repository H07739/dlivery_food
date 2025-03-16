import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_project/Pages/add_food/function/add_food.dart';
import 'package:my_project/color.dart';
import 'package:get/get.dart';
import 'package:my_project/widgets/MaterialButtonX.dart';

import '../../../widgets/FutureBuilderX.dart';
import '../../home/function/getCategorys.dart';
import '../../home/model/category_model.dart';
import '../../home/widget/selectedCategory.dart';
import '../function/pickImage.dart';

class AddFoodView extends StatelessWidget {
  AddFoodView({super.key});
  String? category;
  TextEditingController nameFoodController = TextEditingController();
  TextEditingController descriptionFoodController = TextEditingController();
  TextEditingController priceFoodController = TextEditingController();
  ValueNotifier<bool> imageSelect = ValueNotifier(false);
  File? _image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Food',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: kBannerColor,
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.grey,
            )),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Text(
              'select food',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FutureBuilderX<List<CategoryModel>>(
                future: () => getCategory(),
                loadingView: Center(
                  child: CircularProgressIndicator(),
                ),
                errorView: (String error, ValueNotifier<int> keyNotifier) =>
                    Text(error),
                doneView:
                    (List<CategoryModel> data, ValueNotifier<int> keyNotifier) {
                  return Selectedcategory(
                    onSelected: (int index) {
                      category = data[index].name;
                    },
                    categorys: data,
                  );
                },
              ),
            ),
            Container(
                padding: EdgeInsets.all(10),
                child: TextField(
                  controller: nameFoodController,
                  decoration: InputDecoration(hintText: 'choose name food'),
                )),
            Container(
                padding: EdgeInsets.all(10),
                child: TextField(
                  controller: descriptionFoodController,
                  decoration:
                      InputDecoration(hintText: 'choose description food'),
                )),
            Container(
                padding: EdgeInsets.all(10),
                child: TextField(
                  controller: priceFoodController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: InputDecoration(
                    hintText: ' choose price food   ',
                  ),
                )),
            SizedBox(
              height: 20,
            ),
            ValueListenableBuilder<bool>(
              valueListenable: imageSelect,
              builder: (BuildContext context, bool value, Widget? child) {
                if (value) {
                  return Column(
                    children: [
                      Image.file(
                        height: 200,
                        width: MediaQuery.of(context).size.width / 2,
                        _image!,
                        fit: BoxFit.cover,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            _image = null;
                            imageSelect.value = false;
                          },
                          child: Text('change image'))
                    ],
                  );
                } else {
                  return Container(
                    width: MediaQuery.of(context).size.width / 2,
                    height: 200,
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 10,
                              color: Colors.black.withOpacity(0.2))
                        ]),
                    child: IconButton(
                      icon: Icon(
                        Icons.image,
                        color: Colors.white,
                      ),
                      onPressed: () async {
                        _image = await pickImage(imageSelect: imageSelect);
                      },
                    ),
                  );
                }
              },
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                    child: MaterialButtonX(
                  text: Text('post data'),
                  onPressed: (ValueNotifier<bool> keyNotifier) async {
                    keyNotifier.value = true;
                    try {
                      if (_image == null) {
                        throw 'place selected image';
                      }
                      if (nameFoodController.text.isEmpty) {
                        throw 'place input name';
                      }
                      if (descriptionFoodController.text.isEmpty) {
                        throw 'place input description';
                      }
                      if (priceFoodController.text.isEmpty) {
                        throw 'place input price';
                      }
                      if (category == null) {
                        throw 'place selected category';
                      }

                      await addFood(
                          name: nameFoodController.text,
                          imageFile: _image!,
                          description: descriptionFoodController.text,
                          price: priceFoodController.text,
                          categorys: category!,
                          context: context);
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Add food successfully')));
                      imageSelect.value = false;
                      _image = null;
                      nameFoodController.clear();
                      descriptionFoodController.clear();
                      priceFoodController.clear();
                      category = null;
                    } catch (error) {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text('$error')));
                    }
                    keyNotifier.value = false;
                  },
                ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
