import 'package:flutter/material.dart';
import 'package:my_project/Pages/home/function/getCategorys.dart';
import 'package:my_project/Pages/home/function/getFood.dart';
import 'package:my_project/Pages/home/model/food_model.dart';
import 'package:my_project/Pages/home/widget/selectedCategory.dart';
import 'package:my_project/Pages/shopping_cart/view/shopping_cart_view.dart';
import 'package:my_project/widgets/FutureBuilderX.dart';
import '../../../color.dart';
import 'package:get/get.dart';

import '../widget/food_item.dart';
import '../widget/icon_shopping.dart';

class HomeMain extends StatelessWidget {
  HomeMain({super.key});
  ValueNotifier<String?> category = ValueNotifier(null);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: kbackgroundColor,
      appBar: AppBar(
        leading: IconButton(onPressed: ()=>Get.back(), icon: Icon(Icons.arrow_back_ios)),
        centerTitle: true,
        title: Text(
          "Fast Food Menu",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(Icons.notifications, color: Colors.deepOrange),
            onPressed: () {},
          ),
          IconShopping(),
        ],
      ),
      body:SafeArea(
        child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Catégories",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepOrange,
                        ),
                      ),
                      TextButton(
                        onPressed: () {

                        },
                        child: Text(
                          "View All",
                          style: TextStyle(
                            color: Colors.deepOrange,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  FutureBuilderX(
                    future: () => getCategory(),
                    loadingView: Center(
                      child: CircularProgressIndicator(),
                    ),
                    errorView: (String error, ValueNotifier<int> keyNotifier) =>
                        Text(error),
                    doneView: (data, ValueNotifier<int> keyNotifier) {
                      return Selectedcategory(
                        onSelected: (int i,String index,) {
                          category.value = index;
                        },
                        categorys: data,
                      );
                    },
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Produits",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepOrange,
                    ),
                  ),
                  SizedBox(height: 10),
                  ValueListenableBuilder<String?>(
                    valueListenable: category,
                    builder: (BuildContext context, String? value, Widget? child) {
                      return FutureBuilderX<List<FoodModel>>(
                        future: () => getFood(category: value),
                        loadingView: Center(
                          child: CircularProgressIndicator(),
                        ),
                        errorView: (String error, ValueNotifier<int> keyNotifier) =>
                            Text(error),
                        doneView:
                            (List<FoodModel> data, ValueNotifier<int> keyNotifier) {
                          if(data.isEmpty)return Center(child: Text('Not Found Food in This category'),);
                          return Column(
                            children: List.generate(data.length, (int index) {
                              return FoodItem(
                                model: data[index],
                              );
                            }),
                          );
                        },
                      );
                    },

                  ),
                 // headerParts(),
                ],
              ),
            ),
          ),
      ),
      
    );
  }

}
