import 'package:flutter/material.dart';
import 'package:my_project/Pages/home/model/food_model.dart';
import 'package:my_project/Pages/home/widget/image_food_detail.dart';
import '../function/addFoodToCart.dart';
import '../model/food_detail_model.dart';
import '../widget/food_detail_info.dart';
import '../widget/icon_shopping.dart';

class ProductDetailPage extends StatelessWidget {
  FoodModel product;
  ProductDetailPage(
      {super.key,
      required this.product});


  FoodDetailListModel detailListModel =FoodDetailListModel();

  ValueNotifier<double> price = ValueNotifier(0);


  @override
  Widget build(BuildContext context) {

    price.value = double.tryParse(product.price) ?? 0.0;
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
                  ImageFoodDetail(
                    product: product,
                  ),
                  FoodDetailInfo(
                    product: product,
                    pirce: price,
                    count: detailListModel.count,
                  ),
                  ValueListenableBuilder<List<FoodDetailModel>>(
                    valueListenable: detailListModel.details,
                    builder: (BuildContext context, List<FoodDetailModel> value,
                        Widget? child) {
                      return Column(
                        children: [
                          for (var i = 0; i < value.length; i++)
                            Row(
                              children: [
                                Checkbox(
                                  value: value[i].check,
                                  onChanged: (bool? newValue) {
                                    if (newValue != null) {
                                      // تحديث الحالة
                                      value[i].check = newValue;
                                      if (newValue) {
                                        price.value += value[i].pirec *
                                            detailListModel.count
                                                .value; // إضافة السعر عند التحديد
                                      } else {
                                        price.value -= value[i].pirec *
                                            detailListModel.count
                                                .value; // خصم السعر عند الإلغاء
                                      }

                                      // تحديث `details` ليعكس التغيير
                                      detailListModel.details.value = List.from(value);
                                    }
                                  },
                                ),
                                SizedBox(width: 8),
                                Text(
                                  value[i].name,
                                  style: TextStyle(fontSize: 18),
                                ),
                                SizedBox(width: 8),
                                Text(
                                  "${value[i].pirec} D",
                                  style: TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                        ],
                      );
                    },
                  ),
                  SizedBox(height: 20),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      padding: EdgeInsets.all(12),
                      child: Center(
                        child: ElevatedButton(
                          onPressed: () {
                            addFoodToCart(context: context, detailListModel: detailListModel, foodModel:product);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.deepOrange,
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(
                                vertical: 15, horizontal: 30),
                            textStyle: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
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
            ),
          )
        ],
      ),
    );
  }
}
