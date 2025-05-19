import 'package:flutter/material.dart';
import 'package:my_project/Pages/home/model/food_model.dart';
import 'package:my_project/widgets/favorite_item.dart';

import '../../shopping_cart/model/FoodOrderModel.dart';
import '../function/add_favorite.dart';
import '../model/food_detail_model.dart';


class FoodDetailInfo extends StatelessWidget {
  FoodDetailInfo({super.key,required this.orderModel});
  FoodOrderModel orderModel;


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                orderModel.foodModel.name,
                style:
                TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            Row(
              children: [
                FavoriteItem(
                  like: orderModel.foodModel.is_favorite,
                  onPressed: (bool state) async{
                     orderModel.foodModel.is_favorite = state;
                    if (state) {
                      addFavorite(model: orderModel.foodModel,context: context);
                    } else {
                      removeFavorite(model: orderModel.foodModel,context: context);
                    }
                  },
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 12),
        Text(
          orderModel.foodModel.description,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey.shade600,
            height: 1.5,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(height: 8),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ValueListenableBuilder<double>(valueListenable: orderModel.totalPrice, builder: (BuildContext context, double value, Widget? child) {
              return Text(
                "$value D",
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepOrange),
              );
            },),
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.remove),
                  onPressed: () {
                    if (orderModel.count.value > 1) {
                      orderModel.setCount(orderModel.count.value - 1);
                    }
                  },
                ),

                ValueListenableBuilder<int>(
                  valueListenable: orderModel.count,
                  builder: (BuildContext context, int value, Widget? child) {
                    return Text(
                      "$value",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    );
                  },
                ),

                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    orderModel.setCount(orderModel.count.value + 1);
                  },
                ),

              ],
            ),

          ],
        ),
        SizedBox(height: 12),


        SizedBox(height: 16),
        SizedBox(height: 8),
      ],
    );
  }
}
