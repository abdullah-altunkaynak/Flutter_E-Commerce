import 'package:flutter/Material.dart';
import 'package:animations/animations.dart';
import 'package:flutter_ecommerce/view/LoginScreen.dart';
import 'package:flutter_ecommerce/viewmodel/Provider.dart';
import 'package:flutter_ecommerce/model/cart.dart';
import 'package:flutter_ecommerce/model/products.dart';
import 'package:flutter_ecommerce/model/user.dart';
import 'package:flutter_ecommerce/services/rest_api.dart';
import 'package:provider/provider.dart';

class LetsStartScreen extends StatefulWidget {
  const LetsStartScreen({super.key});

  @override
  _LetsStartScreenState createState() => _LetsStartScreenState();
}

class _LetsStartScreenState extends State<LetsStartScreen> {
  int count = 0;
  Widget childForTransition = firstScreen();
  bool isNextButtonDisabled = false;
  bool isBackButtonDisabled = true;
  String nextButtonText = "Next";
  List<User>? users;
  List<Products>? products;
  List<Cart>? carts;
  screenFinder(int counter) {
    switch (counter) {
      case 0:
        setState(() {
          childForTransition = firstScreen();
        });
        break;
      case 1:
        setState(() {
          childForTransition = secondScreen(
              productLength: products?.length,
              categoryLength: Category.values.length,
              cartLength: carts?.length,
              userLength: users?.length);
        });
        break;
      case 2:
        setState(() {
          childForTransition = thirdScreen();
        });
        break;
      default:
        setState(() {
          childForTransition = firstScreen();
        });
        break;
    }
  }

  void toggleButtonDisabled(int counter) {
    if (counter == 0) {
      setState(() {
        isBackButtonDisabled = true;
      });
    } else if (counter == 2) {
      setState(() {
        nextButtonText = "Login";
      });
    } else {
      setState(() {
        nextButtonText = "Next";
        isBackButtonDisabled = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!Provider.of<GlobalStateData>(context).checkValues()) {
      if (users == null && products == null && carts == null) {
        setState(() {
          users = Provider.of<GlobalStateData>(context).users;
          products = Provider.of<GlobalStateData>(context).products;
          carts = Provider.of<GlobalStateData>(context).carts;
        });
      }
      return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
            child: Column(
          children: [
            Expanded(
                child: PageTransitionSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (child, animation, secondaryAnimation) {
                return SharedAxisTransition(
                    animation: animation,
                    secondaryAnimation: secondaryAnimation,
                    transitionType: SharedAxisTransitionType.horizontal,
                    child: child);
              },
              child: childForTransition,
            )),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: isBackButtonDisabled
                        ? null
                        : () {
                            if (count > 0) {
                              count--;
                              toggleButtonDisabled(count);
                              screenFinder(count);
                            }
                          },
                    child: const Text("Back"),
                  ),
                  ElevatedButton(
                    onPressed: isNextButtonDisabled
                        ? null
                        : () {
                            if (count < 2) {
                              count++;
                              toggleButtonDisabled(count);
                              screenFinder(count);
                            } else if (count == 2) {
                              Navigator.pushNamed(context, '/login');
                            }
                          },
                    child: Text(nextButtonText),
                  ),
                ],
              ),
            ),
          ],
        )),
      );
    } else {
      return const Scaffold(
          backgroundColor: Color.fromARGB(255, 57, 172, 229),
          body: Center(
            child: CircularProgressIndicator(
              color: Colors.white,
              //Burada güzel bir loading ekranı olmalı
              semanticsLabel: 'Circular progress indicator',
            ),
          ));
    }
  }
}

Widget firstScreen() {
  return Scaffold(
      body: Container(
    width: double.infinity,
    height: double.infinity,
    decoration: BoxDecoration(
      image: const DecorationImage(
          alignment: Alignment(-0.8, -0.3),
          scale: 8.0,
          image: AssetImage('assets/images/logo.png')),
      color: const Color.fromARGB(255, 57, 172, 229),
      border: Border.all(width: 1, color: const Color.fromRGBO(230, 81, 0, 1)),
    ),
    child: Column(
      children: [companyNameText(), infoText(), warningText()],
    ),
  ));
}

warningText() {
  return const Padding(
    padding: EdgeInsets.only(right: 0, top: 10),
    child: Text(
      '"Tamamen örnek amaçlıdır."',
      style: TextStyle(
          color: Color.fromARGB(255, 113, 112, 112),
          fontSize: 22,
          fontWeight: FontWeight.bold),
    ),
  );
}

infoText() {
  return const Padding(
    padding: EdgeInsets.only(left: 70, top: 80),
    child: Text('Bu Uygulama Fake API kullanılarak yapılmıştır.',
        style: TextStyle(
            color: Colors.white, fontSize: 27, fontWeight: FontWeight.bold)),
  );
}

companyNameText() {
  return const Padding(
    padding: EdgeInsets.only(left: 50, top: 200),
    child: Text('Company Name',
        style: TextStyle(
            color: Color.fromRGBO(230, 81, 0, 1),
            fontSize: 35,
            fontWeight: FontWeight.bold)),
  );
}

Widget secondScreen(
    {int? productLength,
    int? categoryLength,
    int? cartLength,
    int? userLength}) {
  return SafeArea(
      child: Container(
          decoration: BoxDecoration(
              color: const Color.fromARGB(255, 57, 172, 229),
              border: Border.all(
                  width: 1, color: const Color.fromRGBO(230, 81, 0, 1))),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Expanded(
                      child: Padding(
                    padding:
                        EdgeInsets.only(left: 0, right: 0, top: 80, bottom: 0),
                    child: Text(
                      'Bu uygulumada neler var',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 40,
                          color: Color.fromARGB(255, 115, 0, 255),
                          fontWeight: FontWeight.bold),
                    ),
                  ))
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  leftColumn(productLength, categoryLength),
                  rightColumn(cartLength, userLength)
                ],
              ),
            ],
          )));
}

rightColumn(int? cartLength, int? userLength) {
  return Expanded(
    flex: 1,
    child: Column(
      children: [userBox(userLength), cartBox(cartLength)],
    ),
  );
}

cartBox(int? cartLength) {
  return Padding(
    padding: const EdgeInsets.only(left: 5, right: 20, top: 30, bottom: 0),
    child: Container(
      alignment: Alignment.center,
      width: 200,
      height: 100,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          border: Border.all(color: Colors.white, width: 2),
          color: const Color.fromARGB(255, 219, 78, 2)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            cartLength.toString(),
            style: const TextStyle(
                fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          const Text(
            'Sepet',
            style: TextStyle(
                fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ],
      ),
    ),
  );
}

userBox(int? userLength) {
  return Padding(
    padding: const EdgeInsets.only(left: 5, right: 20, top: 100, bottom: 0),
    child: Container(
      alignment: Alignment.center,
      width: 200,
      height: 100,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          border: Border.all(color: Colors.white, width: 2),
          color: const Color.fromARGB(255, 219, 78, 2)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            userLength.toString(),
            style: const TextStyle(
                fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          const Text(
            'Kullanıcı',
            style: TextStyle(
                fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ],
      ),
    ),
  );
}

leftColumn(int? productLength, int? categoryLength) {
  return Expanded(
    flex: 1,
    child: Column(
      children: [productBox(productLength), categoryBox(categoryLength)],
    ),
  );
}

categoryBox(int? categoryLength) {
  return Padding(
    padding: const EdgeInsets.only(left: 20, right: 0, top: 30, bottom: 0),
    child: Container(
      alignment: Alignment.center,
      width: 200,
      height: 100,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          border: Border.all(color: Colors.white, width: 2),
          color: const Color.fromARGB(255, 219, 78, 2)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            categoryLength.toString(),
            style: const TextStyle(
                fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          const Text(
            'Kategori',
            style: TextStyle(
                fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ],
      ),
    ),
  );
}

productBox(int? productLength) {
  return Padding(
    padding: const EdgeInsets.only(left: 20, right: 0, top: 100, bottom: 0),
    child: Container(
      alignment: Alignment.center,
      width: 200,
      height: 100,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          border: Border.all(color: Colors.white, width: 2),
          color: const Color.fromARGB(255, 219, 78, 2)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            productLength.toString(),
            style: const TextStyle(
                fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          const Text(
            'Ürün',
            style: TextStyle(
                fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ],
      ),
    ),
  );
}

Widget thirdScreen() {
  return const Text('Third Screen');
}
