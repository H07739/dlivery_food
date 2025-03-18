import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_project/widgets/MaterialButtonX.dart';

import '../../../DataBase/shopping_cart_db.dart';
import '../model/food_item_cart.dart';

class ShoppingCartView extends StatelessWidget {
  const ShoppingCartView({super.key});


  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<FoodItemCart>>(
      valueListenable: ShoppingCartDB.itemsShoppingFood,
      builder: (BuildContext context, List<FoodItemCart> value, Widget? child) {
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
          body: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 60), // لإعطاء مساحة للزر
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height/2,
                      child: ListView.builder(
                          itemCount: ShoppingCartDB.itemsShoppingFood.value.length,
                          itemBuilder: (BuildContext context,int index){
                            return Card(
                              child: ListTile(

                                leading: CircleAvatar(
                                  backgroundImage: NetworkImage(
                                    ShoppingCartDB.itemsShoppingFood.value[index].foodModel.image,
                                  ),
                                ),
                                title: Text(ShoppingCartDB.itemsShoppingFood.value[index].foodModel.name),
                                subtitle:  Text('${ShoppingCartDB.itemsShoppingFood.value[index].foodModel.price}\$'),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.remove),
                                      onPressed: () {},
                                    ),
                                    Text(
                                      "${ShoppingCartDB.itemsShoppingFood.value[index].detailListModel.count.value}",
                                      style: TextStyle(
                                          fontSize: 20, fontWeight: FontWeight.bold),
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.add),
                                      onPressed: () {},
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                    ),
                    Divider(),
                    SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Total : \$ 10',style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
                    )
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: double.infinity,
                  color: Colors.white, // لون الخلفية لضمان ظهور الزر
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                  child: MaterialButtonX(
                    onPressed: (ValueNotifier<bool> keyNotifier) {},
                    text: const Text('CHECK OUT'),

                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
