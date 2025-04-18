import 'package:flutter/material.dart';
import 'package:my_project/DataBase/OrderManager.dart';
import 'package:my_project/Pages/home/function/get_food_detail.dart';
import 'package:my_project/Pages/home/model/food_model.dart';
import 'package:my_project/Pages/home/widget/image_food_detail.dart';
import 'package:my_project/widgets/FutureBuilderX.dart';
import '../../../main.dart';
import '../../../widgets/showLoginRequiredDialog.dart';
import '../../shopping_cart/model/FoodOrderModel.dart';
import '../model/food_detail_model.dart';
import '../widget/food_detail_info.dart';
import '../widget/icon_shopping.dart';

class ProductDetailPage extends StatelessWidget {
  FoodModel product;
  late FoodOrderModel orderModel;
  ProductDetailPage(
      {super.key,
      required this.product}){
    orderModel = FoodOrderModel(foodModel: product);
  }


  ValueNotifier<List<FoodDetailModelX>> detailsMe = ValueNotifier([]);


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(product.name, style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        actions: [
          IconShopping(),
        ],
      ),

      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  ImageFoodDetail(product: product),
                  FoodDetailInfo(orderModel: orderModel),
                  FutureBuilderX<List<FoodDetailModelX>>(
                    future: ()=>getFoodDetail(idFood: product.id),
                    loadingView: Center(child: CircularProgressIndicator(),),
                    errorView: (String error, ValueNotifier<int> keyNotifier)=>Text(error),
                    doneView: (List<FoodDetailModelX> data, ValueNotifier<int> keyNotifier) {
                      detailsMe.value= data;
                      return ValueListenableBuilder<List<FoodDetailModelX>>(
                        valueListenable: detailsMe,
                        builder: (context, value, child) {
                          return Column(
                            children: value.map((item) => Row(
                              children: [
                                Checkbox(
                                  value: item.check,
                                    onChanged: (bool? newValue) {
                                      if (newValue != null) {
                                        item.check = newValue;
                                        orderModel.toggleExtra(item);
                                        detailsMe.notifyListeners();
                                      }
                                    },

                                ),
                                SizedBox(width: 8),
                                Text(item.name, style: TextStyle(fontSize: 18)),
                                SizedBox(width: 8),
                                Text("${item.price} D", style: TextStyle(fontSize: 16)),
                              ],
                            )).toList(),
                          );
                        },
                      );
                    },
                  ),
                  SizedBox(height: 100), // 
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.all(12),
              child: Center(
                child: ElevatedButton(
                  onPressed: () {
                    if(supabase.auth.currentUser == null){
                      showLoginRequiredDialog(context);
                      return;
                    }
                    OrderManager.addOrder(orderModel);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepOrange,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                    textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: BorderSide(color: Colors.deepOrange),
                    ),
                  ),
                  child: Text("Add To Cart"),
                ),
              ),
            ),
          ),
        ],
      ),

    );
  }
}
