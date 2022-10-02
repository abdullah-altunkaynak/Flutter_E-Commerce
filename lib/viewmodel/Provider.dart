import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/model/cart.dart';
import 'package:flutter_ecommerce/model/products.dart';
import 'package:flutter_ecommerce/model/user.dart';
import 'package:flutter_ecommerce/services/rest_api.dart';
import 'package:http/http.dart';

//Loading durumu tutulmalı
class GlobalStateData extends ChangeNotifier {
  List<Products>? products;
  List<Cart>? carts;
  List<User>? users;
  bool loading = true;
  GlobalStateData() {
    getProducts();
    getCarts();
    getUsers();
    checkValues();
  }
  checkValues() {
    if (products != null && carts != null && users != null) {
      loading = false;
    } else {
      loading = true;
    }
    notifyListeners();
    return loading;
  }

  getProducts() async {
    products = await RestApi().getAllProducts();
    notifyListeners();
  }

  getCarts() async {
    carts = await RestApi().getAllCarts();
    notifyListeners();
  }

  getUsers() async {
    users = await RestApi().getAllUsers();
    notifyListeners();
  }
}
