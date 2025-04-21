import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_project/DataBase/OrderManager.dart';
import 'package:my_project/Pages/shopping_cart/function/add_request.dart';
import 'package:my_project/widgets/MaterialButtonX.dart';
import '../../../main.dart';
import '../../../widgets/showLoginRequiredDialog.dart';
import '../model/FoodOrderModel.dart';
import '../widget/shopping_cart_item.dart';

class ShoppingCartView extends StatelessWidget {
  ShoppingCartView({super.key});

  ValueNotifier<String?> selectedMethod = ValueNotifier(null);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<FoodOrderModel>>(
      valueListenable: OrderManager.orders,
      builder:
          (BuildContext context, List<FoodOrderModel> value, Widget? child) {
        if (value.isNotEmpty) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: const Text(
                'Cart',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              leading: IconButton(
                onPressed: () => Get.back(),
                icon: const Icon(Icons.arrow_back_ios),
              ),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                      padding: const EdgeInsets.only(bottom: 60),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height / 2,
                            child: ListView.builder(
                                itemCount: value.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return ShoppingCartItem(
                                    orderModel: value[index],
                                    index: index,
                                  );
                                }),
                          ),
                          Divider(),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ValueListenableBuilder<double>(
                              valueListenable: OrderManager.totalPrice,
                              builder: (BuildContext context, double value,
                                  Widget? child) {
                                return Text(
                                  'Total : $value D',
                                  style: TextStyle(
                                      fontSize: 22, fontWeight: FontWeight.bold),
                                );
                              },
                            ),
                          )
                        ],
                      )),
                  ValueListenableBuilder<String?>(
                    valueListenable: selectedMethod,
                    builder: (BuildContext context, String? value, Widget? child) {  return Row(
                      children: [
                        Expanded(
                          child: RadioListTile<String>(
                            title: Text("delivery"),
                            value: "delivery",
                            groupValue: value,
                            onChanged: (value) {
                              selectedMethod.value = value!;
                            },
                          ),
                        ),
                        Expanded(
                          child: RadioListTile<String>(
                            title: Text("pickup"),
                            value: "pickup",
                            groupValue: value,
                            onChanged: (value) {
                              selectedMethod.value = value!;
                            },
                          ),
                        ),
                      ],
                    );},

                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: MaterialButtonX(
                        onPressed: (ValueNotifier<bool> v) async {
                          try {
                            if(supabase.auth.currentUser == null){
                              showLoginRequiredDialog(context);
                              return;
                            }
                            if (selectedMethod.value == null) {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content: Text('Please select a delivery method'),backgroundColor: Colors.red,));
                            }
              
                            v.value = true;
              
                            List<FoodOrderModel> ordersCopy =
                                List.from(OrderManager.orders.value);
              
                            for (var model in ordersCopy) {
                              await addRequest(order: model, context: context, delivery:selectedMethod.value!);
                              OrderManager.removeOrder(
                                  0); // Always delete the first item after sending
                            }
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text('Request added successfully')));
              
                            v.value = false;
                          } catch (e) {
                            print('Error: $e');
                            v.value = false;
                          }
                        },
                        text: const Text(
                          'CHECKOUT',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: const Text(
                'Cart',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              leading: IconButton(
                onPressed: () => Get.back(),
                icon: const Icon(Icons.arrow_back_ios),
              ),
            ),
            body: Center(
              child: Text(
                'Your Cart Is Empty',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
          );
        }
      },
    );
  }
}
