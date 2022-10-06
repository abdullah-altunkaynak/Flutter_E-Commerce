import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/viewmodel/Provider.dart';
import 'package:flutter_ecommerce/model/cart.dart';
import 'package:flutter_ecommerce/model/products.dart';
import 'package:flutter_ecommerce/model/user.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

// Bu ekranda bottom navigator bar olucak ve ürünler/sepet/profil bilgilerine erişilebilecek
class MainPagesScreen extends StatefulWidget {
  Category? selectedCategory;
  String? selectedCategoryName;
  User? user;
  MainPagesScreen(
      {super.key, this.selectedCategory, this.selectedCategoryName, this.user});
  @override
  _MainPagesScreenState createState() => _MainPagesScreenState();
}

class _MainPagesScreenState extends State<MainPagesScreen> {
  int _selectedIndex = 0;
  String? selectedSort = 'LowToHighPrice';
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  dropdownCallBack(String? value) {
    setState(() {
      selectedSort = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as MainPagesScreen;
    List<Products>? products = Provider.of<GlobalStateData>(context).products;
    User? user = args.user;
    print(user!.username);
    List<Cart>? userCarts =
        Provider.of<GlobalStateData>(context).getuserCarts(user);
    Category? selectedCategory = args.selectedCategory;
    String? selectedCategoryName = args.selectedCategoryName;
    Provider.of<GlobalStateData>(context)
        .filterProductsWithCategory(products, selectedCategory);
    Provider.of<GlobalStateData>(context).sortProducts(
        Provider.of<GlobalStateData>(context).filteredSortedProducts,
        selectedSort);
    final filteredSortedProducts =
        Provider.of<GlobalStateData>(context).filteredSortedProducts;
    List<Widget> pagesList = <Widget>[
      productsPage(
          filteredSortedProducts, context, selectedSort, selectedCategoryName),
      cartsPage(userCarts, context, products),
      profilePage(user),
    ];

    return Scaffold(
      appBar: PreferredSize(
          preferredSize:
              Size.fromHeight(MediaQuery.of(context).size.height * 0.08),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 3),
            decoration: BoxDecoration(
                image: const DecorationImage(
                    alignment: Alignment(-0.95, 0),
                    scale: 13,
                    image: AssetImage('assets/images/logo.png')),
                color: Colors.blueGrey.shade900,
                border: const Border(
                    top: BorderSide(
                        width: 1.0, color: Color.fromRGBO(230, 81, 0, 1)),
                    left: BorderSide(
                        width: 1.0, color: Color.fromRGBO(230, 81, 0, 1)),
                    right: BorderSide(
                        width: 1.0, color: Color.fromRGBO(230, 81, 0, 1)))),
            height: MediaQuery.of(context).size.height * 0.08,
            child: const Center(
              child: Text(
                'Company Name',
                style: TextStyle(
                    color: Color.fromRGBO(230, 81, 0, 1),
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
            ),
          )),
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

  productsPage(List<Products>? filteredProducts, BuildContext context,
      String? selectedSort, String? selectedCategory) {
    // kategoriye göre ürün listeleme ve detay sayfasına yönlendirme
    return Column(
      children: [
        Expanded(
          flex: 1,
          child: Container(
            color: const Color.fromARGB(255, 57, 172, 229),
            height: MediaQuery.of(context).size.height * 0.1,
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  selectedCategory!,
                  style: const TextStyle(color: Colors.white, fontSize: 24),
                ),
                DropdownButton(
                  dropdownColor: const Color.fromARGB(255, 57, 172, 229),
                  iconEnabledColor: Colors.white,
                  focusColor: Colors.amber,
                  style: const TextStyle(color: Colors.white, fontSize: 20),
                  value: selectedSort,
                  items: const [
                    DropdownMenuItem(
                      child: Text('En düşük fiyat'),
                      value: 'LowToHighPrice',
                    ),
                    DropdownMenuItem(
                      child: Text('En yüksek fiyat'),
                      value: 'HighToLowPrice',
                    ),
                    DropdownMenuItem(
                      child: Text('Çok Satanlar'),
                      value: 'BestSeller',
                    ),
                    DropdownMenuItem(
                      child: Text('Çok popüler'),
                      value: 'Popular',
                    ),
                  ],
                  onChanged: (value) {
                    dropdownCallBack(value);
                  },
                )
              ],
            ),
          ),
        ),
        Expanded(
          flex: 9,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 0),
              color: const Color.fromARGB(255, 57, 172, 229),
              height: MediaQuery.of(context).size.height * 0.9,
              child: GridView.builder(
                itemCount: filteredProducts?.length,
                itemBuilder: (context, index) {
                  return productCard(index, filteredProducts);
                },
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 220,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    mainAxisExtent: 260),
              ),
            ),
          ),
        )
      ],
    );
  }

  productCard(int index, List<Products>? filteredProducts) {
    // indexe göre o anki ürün bilgileri gösterilir
    return Card(
        child: ListTile(
            title: Image.network(
              filteredProducts![index].image!,
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
                      filteredProducts[index].title!,
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
                      initialRating: filteredProducts[index].rating!.rate!,
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
                        rating = filteredProducts[index].rating!.rate!;
                      },
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          "${filteredProducts[index].price.toString()} \$",
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

  cartsPage(
      List<Cart>? userCarts, BuildContext context, List<Products>? products) {
    return Container(
      margin: const EdgeInsets.only(left: 10, right: 10),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: userCarts!.length,
        itemBuilder: (context, index) {
          return cartCard(userCarts, index, products);
        },
      ),
    );
  }

  cartCard(List<Cart>? userCarts, int index, List<Products>? products) {
    Cart cart = userCarts![index];
    return Container(
      margin: const EdgeInsets.only(top: 30),
      decoration: const BoxDecoration(
          color: Color.fromARGB(255, 60, 127, 160),
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Flexible(
        child: ListView.builder(
            padding: const EdgeInsets.all(10),
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            itemCount: userCarts[index].products.length,
            itemBuilder: (context, index) {
              return cartProductCard(cart, index, products);
            }),
      ),
    );
  }

  cartProductCard(Cart cart, int index, List<Products>? products) {
    Products product = Provider.of<GlobalStateData>(context)
        .getSingleProduct(cart.products[index].productId);
    return Card(
      child: ListTile(
        leading: Image.network(
          product.image!,
          width: 120,
          height: 120,
        ),
        title: Text(product.title!),
        trailing: Text("- ${cart.products[index].quantity.toString()} +"),
        subtitle: Text(
          (product.price! * cart.products[index].quantity.toDouble())
              .toString(),
          textAlign: TextAlign.right,
          style: TextStyle(color: Colors.amber.shade900, fontSize: 15),
        ),
      ),
    );
  }

  profilePage(User? user) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              labelWidget("City"),
              inputWidget(user!.address!.city.toString()),
              labelWidget("Street"),
              inputWidget(user.address!.street.toString()),
              labelWidget("Number"),
              inputWidget(user.address!.number.toString()),
              labelWidget("Zip"),
              inputWidget(user.address!.zipcode.toString()),
            ],
          ),
          SizedBox(
            width: 20,
            height: 0,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              labelWidget("E-Mail"),
              inputWidget(user.email.toString()),
              labelWidget("User Name"),
              inputWidget(user.username.toString()),
              labelWidget("Full Name"),
              inputWidget(user.name!.firstname.toString() +
                  " " +
                  user.name!.lastname.toString()),
              labelWidget("Phone Number"),
              inputWidget(user.phone.toString()),
            ],
          )
        ],
      ),
    );
  }

  labelWidget(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10, top: 20),
      child: Text(
        text,
        style: TextStyle(
          color: Color.fromARGB(255, 57, 172, 229),
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  inputWidget(String? text) {
    return SizedBox(
        width: 170,
        height: 40,
        child: TextField(
            enabled: false,
            decoration: InputDecoration(
              enabled: false,
              disabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 1, color: Colors.black)),
              labelText: text,
              labelStyle: TextStyle(
                  color: Color.fromARGB(255, 79, 77, 77),
                  fontWeight: FontWeight.bold),
              border: OutlineInputBorder(),
              hintText: 'Enter a search term',
            )));
  }
}
