import 'package:flutter/material.dart';
import 'package:my_project/Pages/meal_plan/function/get_requests.dart';
import 'package:my_project/widgets/FutureBuilderX.dart';
import '../../../Pages/meal_plan/model/meal_plan_model.dart';
import '../../../strings.dart';
import '../widget/item_select_state_order.dart';
import '../widget/item_order_manger.dart';

class MangerOrdersView extends StatefulWidget {
  const MangerOrdersView({super.key});

  @override
  State<MangerOrdersView> createState() => _MangerOrdersViewState();
}

class _MangerOrdersViewState extends State<MangerOrdersView> {
  ValueNotifier<List<MealPlanModel>> orders = ValueNotifier([]);
  ValueNotifier<List<MealPlanModel>> orderSelect = ValueNotifier([]);
  String itemDefault = items[0];

  void updateOrderSelect(String selectedItem) {
    itemDefault = selectedItem;
    orderSelect.value =
        orders.value.where((m) => m.status == itemDefault).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Manager Orders',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.deepOrange,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ItemSelectStateOrder(
              items: items,
              onItemSelected: (String item) {
                updateOrderSelect(item);
              },
            ),
            const Divider(),
            FutureBuilderX<List<MealPlanModel>>(
              future: () => getRequests(),
              loadingView: const Center(
                child: CircularProgressIndicator(),
              ),
              errorView: (String error, ValueNotifier<int> keyNotifier) {
                return Center(child: Text(error));
              },
              doneView:
                  (List<MealPlanModel> data, ValueNotifier<int> keyNotifier) {
                orders.value = data;
                updateOrderSelect(
                    itemDefault);

                return ValueListenableBuilder<List<MealPlanModel>>(
                  valueListenable: orderSelect,
                  builder: (BuildContext context, List<MealPlanModel> value,
                      Widget? child) {
                    if (value.isEmpty) {
                      return const Center(child: Text("Not Found Any Request"));
                    } else {
                      return SizedBox(
                        height: 800,
                        child: ListView.builder(
                          itemCount: value.length,
                          itemBuilder: (BuildContext context, int index) {
                            return ItemOrderManger(
                              orderModel: value[index],
                              onTapUpdate: (String newStatus,
                                  MealPlanModel orderModel) {
                                 updateOrderStatus(order: orderModel, newStatus: newStatus);
                              }, onTapDelete: (MealPlanModel orderModel) { deleteOrder(orderModel); },
                            );
                          },
                        ),
                      );
                    }
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void updateOrderStatus({required MealPlanModel order,required String newStatus}) {
    int index = orders.value.indexWhere((element) => element == order);
    if (index != -1) {
      orders.value[index].status = newStatus;
    }

    orderSelect.value = orderSelect.value
        .where((element) => element.status == itemDefault)
        .toList();

    orders.notifyListeners();
    orderSelect.notifyListeners();
  }

  void deleteOrder(MealPlanModel order){
    orders.value.remove(order);
    orders.notifyListeners();
    orderSelect.value = orderSelect.value.where((element) => element!= order).toList();
    orderSelect.notifyListeners();
  }
}
