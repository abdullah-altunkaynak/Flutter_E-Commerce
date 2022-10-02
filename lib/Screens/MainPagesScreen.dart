import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/data/Provider.dart';
import 'package:flutter_ecommerce/models/cart.dart';
import 'package:flutter_ecommerce/models/products.dart';
import 'package:flutter_ecommerce/models/user.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

// Bu ekranda bottom navigator bar olucak ve ürünler/sepet/profil bilgilerine erişilebilecek
class MainPagesScreen extends StatefulWidget {
  Category? selectedCategory;
  final User? user;
  MainPagesScreen({super.key, this.selectedCategory, this.user});
  @override
  _MainPagesScreenState createState() => _MainPagesScreenState();
}

class _MainPagesScreenState extends State<MainPagesScreen> {
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as MainPagesScreen;
    List<Products>? products = Provider.of<GlobalStateData>(context).products;
    final user = args.user;
    final selectedCategory = args.selectedCategory;
    List<Widget> pagesList = <Widget>[
      productsPage(products, context),
      cartsPage(),
      profilePage(),
    ];
    return Scaffold(
      body: pagesList.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.checkroom_sharp),
            label: 'Products',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Carts',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_box),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }

  productsPage(List<Products>? products, BuildContext context) {
    // kategoriye göre ürün listeleme ve detay sayfasına yönlendirme
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 6, vertical: 0),
        color: const Color.fromARGB(255, 57, 172, 229),
        height: MediaQuery.of(context).size.height * 0.8,
        child: GridView.builder(
          itemCount: products?.length,
          itemBuilder: (context, index) {
            return productCard(index, products);
          },
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 220,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              mainAxisExtent: 260),
        ),
      ),
    );
  }

  productCard(int index, List<Products>? products) {
    // indexe göre o anki ürün bilgileri gösterilir
    return Card(
        child: ListTile(
            title: Image.network(
              products![index].image!,
              width: 120,
              height: 120,
            ),
            subtitle: Container(
              margin: const EdgeInsets.only(top: 10),
              height: 110,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    flex: 4,
                    child: Text(
                      products[index].title!,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 5,
                      style: const TextStyle(color: Colors.black, fontSize: 16),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: RatingBar.builder(
                      wrapAlignment: WrapAlignment.start,
                      ignoreGestures: true,
                      initialRating: products[index].rating!.rate!,
                      itemSize: 16,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemPadding: const EdgeInsets.symmetric(horizontal: 0.0),
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {
                        rating = products[index].rating!.rate!;
                      },
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          products[index].price.toString(),
                          textAlign: TextAlign.right,
                          style: TextStyle(color: Colors.amber.shade800),
                        )),
                  ),
                ],
              ),
            )
            //leading: Text('Leading'), title'dan önce gelir
            //trailing: Text('Trailing'), title'dan sonra gelir sağda bulunur
            ));
  }

  cartsPage() {
    return const Text('Sepet Sayfası');
  }

  profilePage() {
    return const Text('Profil Sayfası');
  }
}
