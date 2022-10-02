import 'dart:convert';

import 'package:flutter_ecommerce/model/cart.dart';
import 'package:flutter_ecommerce/model/products.dart';
import 'package:flutter_ecommerce/model/user.dart';
import 'package:http/http.dart' as http;

//We will use the models we created in this class to populate an API over the internet.
// flutter pub add http ** required **
class RestApi {
  Future<List<Products>?> getAllProducts() async {
    var client = http.Client();
    var uri = Uri.parse('https://fakestoreapi.com/products');
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      // was succesful
      var json = response.body;
      return productsFromJson(json); // this method comes from model
    }
  }

  Future<List<Cart>?> getAllCarts() async {
    var client = http.Client();
    var uri = Uri.parse('https://fakestoreapi.com/carts');
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      // was succesful
      var json = response.body;
      return cartFromJson(json); // this method comes from model
    }
  }

  Future<List<User>?> getAllUsers() async {
    var client = http.Client();
    var uri = Uri.parse('https://fakestoreapi.com/users');
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      // was succesful
      var json = response.body;
      return userFromJson(json); // this method comes from model
    }
  }

  Future<bool> userLogin(user) async {
    Map<String, String> userToJson(String username, String password) => {
          "username": username,
          "password": password,
        };
    var client = http.Client();
    var uri = Uri.parse('https://fakestoreapi.com/auth/login');
    var response = await client.post(uri,
        body: userToJson(user['username'], user['password']));
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
