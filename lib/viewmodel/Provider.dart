import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/model/cart.dart';
import 'package:flutter_ecommerce/model/products.dart';
import 'package:flutter_ecommerce/model/user.dart';
import 'package:flutter_ecommerce/services/rest_api.dart';
import 'package:http/http.dart';

//Loading durumu tutulmalı
class GlobalStateData extends ChangeNotifier {
  List<Products>? products;
  List<Products>? filteredSortedProducts;
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

  // Tüm productları bu fonksiyona gönderip seçili kategoriyi filtreliyoruz
  filterProductsWithCategory(List<Products>? products, Category? category) {
    filteredSortedProducts =
        products!.where((i) => i.category == category).toList();
    notifyListeners();
  }

  // Sıralanmasını istediğimiz listeyi fonksiyona sokuyoruz
  sortProducts(List<Products>? products, String? selectedSort) {
    switch (selectedSort) {
      case 'LowToHighPrice':
        products!.sort(((a, b) => a.price!.compareTo(b.price!)));
        filteredSortedProducts = products;
        break;
      case 'HighToLowPrice':
        products!.sort(((a, b) => b.price!.compareTo(a.price!)));
        filteredSortedProducts = products;
        break;
      case 'BestSeller':
        products!
            .sort(((a, b) => b.rating!.count!.compareTo(a.rating!.count!)));
        filteredSortedProducts = products;
        break;
      case 'Popular':
        products!.sort(((a, b) => b.rating!.rate!.compareTo(a.rating!.rate!)));
        filteredSortedProducts = products;
        break;
      default:
        break;
    }
    notifyListeners();
  }

  // aslında sisteme giriş yapan user bilgisini de provider içerisinde tutmak gerekir ama bu uygulama
  // öğrenme amaçlı olduğu için user nesnesini router yapısında arg olarak aktarıyoruz bu yüzden bu fonksiyon
  // ile user'ın sepetlerini bulup geri döndürcez
  getuserCarts(User? user) {
    return this.carts!.where((element) => element.userId == user?.id).toList();
  }

  getSingleProduct(int productId) {
    return this.products!.firstWhere((element) => element.id == productId);
  }
}
