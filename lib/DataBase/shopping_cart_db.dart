import 'package:flutter/cupertino.dart';

import '../Pages/shopping_cart/model/food_item_cart.dart';

class ShoppingCartDB{
  static ValueNotifier<List<FoodItemCart>> itemsShoppingFood=ValueNotifier([]);
}