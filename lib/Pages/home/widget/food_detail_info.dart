import 'package:flutter/material.dart';
import 'package:my_project/Pages/home/model/food_model.dart';
import 'package:my_project/widgets/favorite_item.dart';


class FoodDetailInfo extends StatelessWidget {
  FoodDetailInfo({super.key,required this.product,required this.pirce});
  FoodModel product;
  ValueNotifier<double> pirce;
  ValueNotifier<int> count =  ValueNotifier(1);

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
                product.name,
                style:
                TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            Row(
              children: [
                FavoriteItem(
                  like: product.is_favorite,
                  onPressed: (bool state) {
                    product.is_favorite = state;
                    if (state) {
                      product.addFood(product);
                    } else {
                      product.removeFood(product.id);
                    }
                  },
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ValueListenableBuilder<double>(valueListenable: pirce, builder: (BuildContext context, double value, Widget? child) {
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
                    if (count.value > 1) {
                      count.value--;
                      pirce.value -= (pirce.value / (count.value + 1));
                    }
                  },
                ),
                ValueListenableBuilder<int>(
                  valueListenable: count,
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
                    count.value++;
                    pirce.value += (pirce.value / (count.value - 1));
                  },
                ),
              ],
            ),

          ],
        ),
        SizedBox(height: 12),
        Text(
          "Options Supplémentaires",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),

        SizedBox(height: 16),
        SizedBox(height: 8),
      ],
    );
  }
}
