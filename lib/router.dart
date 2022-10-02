import 'package:flutter/Material.dart';
import 'package:flutter_ecommerce/view/LetsStartScreen.dart';
import 'package:flutter_ecommerce/view/LoginScreen.dart';
import 'package:flutter_ecommerce/view/MainPagesScreen.dart';
import 'package:flutter_ecommerce/view/WelcomeScreen.dart';
import 'package:flutter_ecommerce/view/CategoriesScreen.dart';

// Kullanıcı giriş işlemleri için burada state gereklidir.
class Routerer extends StatefulWidget {
  const Routerer({super.key});

  @override
  State<StatefulWidget> createState() {
    return _RouterState();
  }
}

class _RouterState extends State {
  get users => null;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        // Yönlendirmede argüman gönderdiğimiz sayfalar const olamaz
        '/': (context) => const WelcomeScreen(),
        '/login': (context) => const LoginScreen(),
        '/letsStart': (context) => const LetsStartScreen(),
        '/categories': (context) => CategoriesScreen(),
        '/products': (context) => MainPagesScreen()
      },
    );
  }
}
