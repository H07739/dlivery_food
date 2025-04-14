import 'package:flutter/material.dart';
import 'package:my_project/Pages/home/function/getCategorys.dart';
import 'package:my_project/Pages/home/function/getFood.dart';
import 'package:my_project/Pages/home/model/food_model.dart';
import 'package:my_project/Pages/home/widget/selectedCategory.dart';
import 'package:my_project/widgets/FutureBuilderX.dart';
import '../../../color.dart';
import 'package:get/get.dart';

import '../../../main.dart';
import '../../../widgets/showLoginRequiredDialog.dart';
import '../../notification/view/notification_view.dart';
import '../widget/food_item.dart';
import '../widget/icon_shopping.dart';

class HomeMain extends StatelessWidget {
  HomeMain({super.key});
  ValueNotifier<String?> category = ValueNotifier(null);
  TextEditingController searchController = TextEditingController();
  bool searcher = false;
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
            onPressed: () {
              if(supabase.auth.currentUser == null){
                showLoginRequiredDialog(context);
                return;
              }
              Get.to(()=>NotificationView());
            },
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
                    children: [
                      Expanded(
                        child: TextField(
                          controller: searchController,
                          decoration: InputDecoration(
                            hintText: 'Search For Food ...',
                            prefixIcon: Icon(Icons.search, color: Colors.grey),
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.grey, width: 0.5),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.grey, width: 0.5),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.blue, width: 1.0),
                            ),
                          ),
                          onChanged: (String? data){
                            if(data != null){
                              searcher = true;
                              category.value = data;
                            }
                            else{
                              searcher = false;
                            }

                          },
                        ),
                      ),
                    ],
                  ),


                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Categories",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepOrange,
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
                          searcher = false;
                        },
                        categorys: data,
                      );
                    },
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Products",
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
                        future: () {
                          if(searcher){
                            return getFood(foodName: value);
                          }
                          else{
                            return  getFood(category: value);
                          }

                        },
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

                ],
              ),
            ),
          ),
      ),
      
    );
  }

}
