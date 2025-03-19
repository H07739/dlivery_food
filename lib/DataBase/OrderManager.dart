import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Pages/shopping_cart/model/FoodOrderModel.dart';

class OrderManager {
  static ValueNotifier<List<FoodOrderModel>> orders = ValueNotifier([]);
  static ValueNotifier<double> totalPrice = ValueNotifier(0.0);







  /// ✅ إضافة طلب جديد
  static Future<void> addOrder(FoodOrderModel order) async {
    orders.value.add(order);
    orders.notifyListeners();

  }

  /// ✅ إزالة الطلب
  static Future<void> removeOrder(int index) async {
    if (index >= 0 && index < orders.value.length) {
      orders.value.removeAt(index);
      orders.notifyListeners();

    }
  }

  /// ✅ تحديث طلب معين
  static void updateOrder(int index, FoodOrderModel updatedOrder) {
    if (index >= 0 && index < orders.value.length) {
      orders.value[index] = updatedOrder;
      orders.notifyListeners();
    }
  }

  /// ✅ تحديث عدد الطلبات
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

  /// ✅ مسح جميع الطلبات
  static Future<void> clearOrders() async {
    orders.value.clear();
    orders.notifyListeners();

  }
}

/// ✅ **إضافة مستمع لإعادة حساب السعر الكلي عند أي تغيير في الطلبات**
void setupOrderListener() {
  OrderManager.orders.addListener(() {
    OrderManager.totalPrice.value = OrderManager.orders.value.fold(
      0.0,
          (sum, order) => sum + order.totalPrice.value,
    );
  });
}



