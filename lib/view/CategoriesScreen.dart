import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/view/MainPagesScreen.dart';
import 'package:flutter_ecommerce/viewmodel/Provider.dart';
import 'package:flutter_ecommerce/model/products.dart';
import 'package:flutter_ecommerce/model/user.dart';
import 'package:provider/provider.dart';

class CategoriesScreen extends StatelessWidget {
  final User? user;
  const CategoriesScreen({super.key, this.user});
  findCategory(List<Products>? products, Category category) {
    int counter = products!.length;
    for (int i = 0; i < counter; i++) {
      if (products[i].category == category) {
        return products[i];
      }
    }
    return null;
  }

//Burada kategori kartlarının içinde örnek resimler birden çok olmalı animasyonla geçmeli
  @override
  Widget build(BuildContext context) {
    final user = ModalRoute.of(context)!.settings.arguments as CategoriesScreen;
    List<Products>? products = Provider.of<GlobalStateData>(context).products;
    Products categoryElectronicsItem =
        findCategory(products, Category.ELECTRONICS);
    Products categoryJeweleryItem = findCategory(products, Category.JEWELERY);
    Products categoryMensClothingItem =
        findCategory(products, Category.MEN_S_CLOTHING);
    Products categoryWomensClothingItem =
        findCategory(products, Category.WOMEN_S_CLOTHING);
    return Scaffold(
        body: Container(
      color: const Color.fromARGB(255, 57, 172, 229),
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 60.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            categoryCard(categoryElectronicsItem, 'Elektronik', 1, context),
            SizedBox(height: MediaQuery.of(context).size.height * 0.03),
            categoryCard(categoryJeweleryItem, 'Takı', 3, context),
            SizedBox(height: MediaQuery.of(context).size.height * 0.03),
            categoryCard(categoryMensClothingItem, 'Erkek Giyim', 1, context),
            SizedBox(height: MediaQuery.of(context).size.height * 0.03),
            categoryCard(categoryWomensClothingItem, 'Kadın Giyim', 3, context),
          ],
        ),
      ),
    ));
  }

  categoryCard(
      Products product, String category, int rotate, BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/products',
            arguments: MainPagesScreen(
              selectedCategory: product.category,
              selectedCategoryName: category,
              user: user,
            ));
      },
      child: Container(
        padding: EdgeInsets.all(10),
        width: double.infinity,
        height: 250,
        decoration: BoxDecoration(
            border: Border.all(
                color: const Color.fromRGBO(230, 81, 0, 1), width: 2),
            borderRadius: BorderRadius.circular(6),
            color: Color.fromARGB(255, 255, 255, 255),
            image: DecorationImage(
                image: NetworkImage(product.image!),
                fit: BoxFit.contain,
                scale: 1,
                alignment: Alignment.center)),
        child: RotatedBox(
          quarterTurns: rotate,
          child: Text(
            category,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 35,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
      ),
    );
  }
}
