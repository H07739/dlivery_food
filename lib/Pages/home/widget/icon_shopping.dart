import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_project/DataBase/shopping_cart_db.dart';
import 'package:my_project/Pages/shopping_cart/view/shopping_cart_view.dart';
import 'package:badges/badges.dart' as badges;
import '../../shopping_cart/model/food_item_cart.dart';

class IconShopping extends StatelessWidget {
  const IconShopping({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<FoodItemCart>>(valueListenable: ShoppingCartDB.itemsShoppingFood, builder: (BuildContext context, List<FoodItemCart> value, Widget? child) {
      print(value);
      return IconButton(
        icon: badges.Badge(
          badgeContent: value.isEmpty?null:Text('${value.length}',style: TextStyle(color:Colors.white),),
          child: Icon(Icons.shopping_cart, color: Colors.deepOrange),
        ),
        onPressed: () {
          Get.to(()=>ShoppingCartView());
        },
      );
    },);
  }
}
