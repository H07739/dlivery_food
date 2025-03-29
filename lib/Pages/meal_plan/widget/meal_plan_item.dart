import 'package:flutter/material.dart';
import 'package:my_project/Pages/meal_plan/function/cancel_order.dart';
import 'package:my_project/widgets/MaterialButtonX.dart';
import '../../home/model/food_detail_model.dart';
import '../model/meal_plan_model.dart';

class MealPlanItem extends StatelessWidget {
  MealPlanItem({super.key, required this.orderModel, required this.onTap});
  MealPlanModel orderModel;
  Function() onTap;
  @override
  Widget build(BuildContext context) {

    return ExpansionTile(
      title: Text(orderModel.orderModel.foodModel.name),
      subtitle: Text(orderModel.status),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(orderModel.orderModel.foodModel.image),
      ),
      children: [
        ValueListenableBuilder<List<FoodDetailModelX>>(
          valueListenable: orderModel.orderModel.selectedExtras,
          builder: (BuildContext context, List<FoodDetailModelX> value,
              Widget? child) {
            return Column(
              children: [
                for (var i = 0; i < value.length; i++)
                  Row(
                    children: [
                      Checkbox(
                        value: value[i].check,
                        onChanged: (bool? newValue) {},
                      ),
                      SizedBox(width: 8),
                      Text(
                        value[i].name,
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(width: 8),
                      Text(
                        "${value[i].price} D",
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
              ],
            );
          },
        ),
        Text(
          "food price : ${orderModel.orderModel.foodModel.price}",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Divider(),
        Text(
          "Quantity : ${orderModel.foodCount}",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Divider(),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Total price : ${orderModel.price}",
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.red),
          ),
        ),
        Visibility(
          visible: orderModel.status == 'Pending',
          child: Row(
            children: [
              Expanded(
                  child: MaterialButtonX(
                text: Text(
                  'Cancel order',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: (ValueNotifier<bool> keyNotifier) async {
                  try {
                    await cancelOrder(idOrder: orderModel.id);
                    onTap();
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Faild Cancel Order Try Agin')));
                  }
                },
                color: Colors.red,
              ))
            ],
          ),
        )
      ],
    );
  }
}
