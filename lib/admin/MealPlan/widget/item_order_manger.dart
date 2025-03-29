import 'package:flutter/material.dart';
import 'package:my_project/admin/MealPlan/function/delete_order.dart';
import 'package:my_project/admin/MealPlan/function/update_states.dart';
import 'package:my_project/strings.dart';
import '../../../Pages/home/model/food_detail_model.dart';
import '../../../Pages/meal_plan/model/meal_plan_model.dart';
import '../../../widgets/MaterialButtonX.dart';

class ItemOrderManger extends StatelessWidget {
  ItemOrderManger(
      {super.key, required this.orderModel, required this.onTapUpdate,required this.onTapDelete});
  MealPlanModel orderModel;
  Function(String newStatus, MealPlanModel orderModel) onTapUpdate;
  late ValueNotifier<String> selected;
  Function(MealPlanModel orderModel) onTapDelete;

  @override
  Widget build(BuildContext context) {
    selected = ValueNotifier(orderModel.status);
    return ExpansionTile(
      title: Text(orderModel.orderModel.foodModel.name),
      subtitle: Text(orderModel.status),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(orderModel.orderModel.foodModel.image),
      ),
      trailing: IconButton(onPressed: ()async{
        await deleteOrder(model: orderModel, context: context);
        onTapDelete(orderModel);

      }, icon: Icon(Icons.delete,color: Colors.red,)),
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: double.infinity,
              ),
              Text(
                "price Food : ${orderModel.orderModel.foodModel.price}",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              Divider(),
              Text('Quantity : ${orderModel.foodCount}'),
              Divider(),
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
              Divider(),
              Text(
                "Total price : ${orderModel.orderModel.totalPrice.value}",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.red),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Status',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  ValueListenableBuilder<String>(
                    valueListenable: selected,
                    builder:
                        (BuildContext context, String value, Widget? child) {
                      return DropdownButton<String>(
                        value: value,
                        items: List.generate(items.length, (int index) {
                          return DropdownMenuItem(
                              value: items[index], child: Text(items[index]));
                        }),
                        onChanged: (String? value) {
                          if (value != null) {
                            selected.value = value;
                          }
                        },
                      );
                    },
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                      child: MaterialButtonX(
                    text: Text('Update Status',style: TextStyle(color: Colors.white),),
                    onPressed: (ValueNotifier<bool> keyNotifier) async{
                      try{
                        keyNotifier.value = true;
                        orderModel.status = selected.value;
                        await updateState(model: orderModel);
                        keyNotifier.value = false;
                      }
                      catch(e){
                        keyNotifier.value = false;
                        return;
                      }
                      onTapUpdate(selected.value,orderModel);
                    },
                  ))
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}
