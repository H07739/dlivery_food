import 'package:flutter/cupertino.dart';

import '../Pages/shopping_cart/model/food_item_cart.dart';

class ShoppingCartDB{
  static ValueNotifier<List<FoodItemCart>> oredes=ValueNotifier([]);

  static void updateItem(FoodItemCart item) {
    final items = List<FoodItemCart>.from(itemsShoppingFood.value);
    final index = items.indexWhere((element) => element.id == item.id);
    print(item.id);

    if (index != -1) {
      items[index] = item;
      itemsShoppingFood.value = [...items]; // إعادة تعيين القائمة لتحديث جميع المستمعين
      print('updateItem');
    }
    else{
      print('Item not found');
    }
  }


  /// حذف عنصر من السلة باستخدام الـ ID
  static void removeItem(String itemId) {
    final items = List<FoodItemCart>.from(itemsShoppingFood.value)
        .where((item) => item.id != itemId)
        .toList();
    itemsShoppingFood.value = items;
  }

  /// حذف جميع العناصر من السلة
  static void clearCart() {
    itemsShoppingFood.value = [];
  }
}