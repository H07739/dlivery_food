import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Pages/shopping_cart/model/FoodOrderModel.dart';

class OrderManager {
  static ValueNotifier<List<FoodOrderModel>> orders = ValueNotifier([]);
  static ValueNotifier<double> totalPrice = ValueNotifier(0.0);







  /// add new order ✅ 
  static Future<void> addOrder(FoodOrderModel order) async {
    orders.value.add(order);
    orders.notifyListeners();

  }

  /// delete order ✅ 
  static Future<void> removeOrder(int index) async {
    if (index >= 0 && index < orders.value.length) {
      orders.value.removeAt(index);
      orders.notifyListeners();

    }
  }

  /// Update a specific request   ✅  
  static void updateOrder(int index, FoodOrderModel updatedOrder) {
    if (index >= 0 && index < orders.value.length) {
      orders.value[index] = updatedOrder;
      orders.notifyListeners();
    }
  }

  /// ✅ Update the number of orders 
  static Future<void> updateOrderCount(int index, int newCount) async {
    if (index >= 0 && index < orders.value.length) {
      if (newCount > 0) {
        orders.value[index].setCount(newCount);


      } else {
        removeOrder(index);
      }
      orders.notifyListeners();

    }
  }

  /// ✅ Clear all orders  
  static Future<void> clearOrders() async {
    orders.value.clear();
    totalPrice.value=0;
    orders.notifyListeners();

  }
}

/// ✅ **Add a listener to recalculate the total price whenever there is a change in the orders**  

void setupOrderListener() {
  OrderManager.orders.addListener(() {
    OrderManager.totalPrice.value = OrderManager.orders.value.fold(
      0.0,
          (sum, order) => sum + order.totalPrice.value,
    );
  });
}



