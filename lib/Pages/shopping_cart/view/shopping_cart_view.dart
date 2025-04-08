import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_project/DataBase/OrderManager.dart';
import 'package:my_project/Pages/shopping_cart/function/add_request.dart';
import 'package:my_project/widgets/MaterialButtonX.dart';
import '../model/FoodOrderModel.dart';
import '../widget/shopping_cart_item.dart';

class ShoppingCartView extends StatelessWidget {
  const ShoppingCartView({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<FoodOrderModel>>(
      valueListenable: OrderManager.orders,
      builder: (BuildContext context, List<FoodOrderModel> value, Widget? child) {
        if(value.isNotEmpty){
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
            body: Column(
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
                              itemCount:value.length,
                              itemBuilder: (BuildContext context, int index) {
                                return ShoppingCartItem(
                                  orderModel: value[index], index: index,
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
                            builder: (BuildContext context, double value, Widget? child) {
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
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: MaterialButtonX(
                      onPressed: (ValueNotifier<bool> v) async{
                        try {
                          v.value = true;


                          List<FoodOrderModel> ordersCopy = List.from(OrderManager.orders.value);

                          for (var model in ordersCopy) {
                            await addRequest(order: model, context: context);
                            OrderManager.removeOrder(0); // Always delete the first item after sending  
                          }
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Request added successfully')));

                          v.value = false;
                        } catch (e) {
                          print('Error: $e');
                          v.value = false;
                          
                        }


                      },
                      text: const Text('CHECKOUT',style: TextStyle(color: Colors.white),),
                    ),
                  ),
                ),
              ],
            ),
          );
        }
        else{
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
            body: Center(child: Text('Your Cart Is Empty',style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),),
          );
        }
        
      },
    );
  }
}
