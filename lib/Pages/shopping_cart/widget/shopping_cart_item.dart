import 'package:flutter/material.dart';
import 'package:my_project/DataBase/OrderManager.dart';
import 'package:my_project/Pages/home/model/food_detail_model.dart';
import '../../home/model/food_model.dart';
import '../model/FoodOrderModel.dart';

class ShoppingCartItem extends StatelessWidget {
  ShoppingCartItem({
    super.key,
    required this.orderModel,
    required this.index,

  });

  FoodOrderModel orderModel;
  int index;


  @override
  Widget build(BuildContext context) {


    return ExpansionTile(
      title: Text(orderModel.foodModel.name),

      leading: CircleAvatar(
        backgroundImage: NetworkImage(orderModel.foodModel.image),
      ),
      children: [
        ValueListenableBuilder<List<FoodDetailModelX>>(
          valueListenable: orderModel.selectedExtras,
          builder: (BuildContext context, List<FoodDetailModelX> value,
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
                            orderModel.toggleExtra(value[i]);
                            OrderManager.updateOrder(index, orderModel);
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
                        "${value[i].price} D ",
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
              ],
            );
          },
        ),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ValueListenableBuilder<double>(valueListenable: orderModel.totalPrice,
                builder: (BuildContext context, double value, Widget? child) { return Text('Total price : $value D',style: TextStyle(fontSize: 18),); },
              ),
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // IconButton(
                //   icon: Icon(Icons.remove),
                //   onPressed: () {
                //     if (orderModel.count.value > 1) {
                //
                //
                //       OrderManager.updateOrderCount(index, orderModel.count.value - 1);
                //     } else {
                //       OrderManager.removeOrder(index);
                //     }
                //   },
                // ),


                // ValueListenableBuilder<int>(
                //   valueListenable: orderModel.count,
                //   builder: (BuildContext context, int value, Widget? child) {
                //     return Text(
                //       "$value",
                //       style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                //     );
                //   },
                // ),

                // IconButton(
                //   icon: Icon(Icons.add),
                //   onPressed: () {
                //
                //     OrderManager.updateOrderCount(index, orderModel.count.value + 1);
                //   },
                // ),

              ],
            ),

          ],
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Align(
            alignment: Alignment.topLeft,
            child: ValueListenableBuilder<int>(
              valueListenable: orderModel.count,
              builder: (BuildContext context, int value, Widget? child) {
                return Text(
                  "pirce : $value * ${orderModel.foodModel.price} D",
                  style: TextStyle(fontSize: 20,),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
