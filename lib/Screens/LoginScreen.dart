import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/Screens/CategoriesScreen.dart';
import 'package:flutter_ecommerce/data/Provider.dart';
import 'package:flutter_ecommerce/models/user.dart';
import 'package:flutter_ecommerce/services/rest_api.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String username = 'johnd';
  String password = 'm38rmF\$';
  @override
  Widget build(BuildContext context) {
    List<User>? users = Provider.of<GlobalStateData>(context).users;
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 57, 172, 229),
        body: Form(
          child: Container(
            height: double.infinity,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 40.0, vertical: 100.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  logo(context),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      userNameField(height),
                      SizedBox(
                        height: height * 0.03,
                      ),
                      passwordField(height),
                      SizedBox(
                        height: height * 0.06,
                      ),
                      loginButton(width, users),
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }

  logo(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Container(
      height: height * .10,
      decoration: const BoxDecoration(
          image: DecorationImage(
              scale: 1, image: AssetImage('assets/images/logo.png'))),
    );
  }

  userNameField(double height) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      TextFormField(
        initialValue: username,
        onChanged: ((value) => setState(() {
              username = value;
            })),
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          label: Text(
            'User Name',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          hintStyle: TextStyle(color: Color.fromARGB(255, 121, 121, 120)),
          icon: Icon(
            Icons.account_box_rounded,
            color: Colors.white,
            size: 30,
          ),
        ),
      ),
    ]);
  }

  passwordField(double height) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      TextFormField(
        initialValue: password,
        onChanged: ((value) => setState(() {
              password = value;
            })),
        obscureText: true,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          label: Text(
            'Password',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          hintStyle: TextStyle(color: Color.fromARGB(255, 121, 121, 120)),
          icon: Icon(
            Icons.lock,
            color: Colors.white,
            size: 30,
          ),
        ),
      ),
    ]);
  }

  loginButton(double width, List<User>? users) {
    return ElevatedButton(
        onPressed: () {
          authUser(users);
        },
        style: ButtonStyle(
            textStyle: MaterialStateProperty.all<TextStyle>(
                const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            fixedSize: MaterialStateProperty.all<Size>(Size(width, 50)),
            foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
            backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
            side: MaterialStateProperty.all<BorderSide>(
                const BorderSide(color: Colors.white))),
        child: const Text('Log In'));
  }

  void authUser(List<User>? users) async {
    var user = {'username': username, 'password': password};
    bool response = await RestApi().userLogin(user);
    if (response == true) {
      //Giriş başarılı
      //Aşağıdaki fonksiyonda giriş işlemi için kullanılabilir ama gerçekçi bir proje için doğruluğu
      //Apı'post ile kontrol ediyoruz.
      var returnFindPerson = findPerson(users, username); // bulunamazsa -1
      if (returnFindPerson != -1) {
        //Kullanıcı bulundu
        Navigator.pushNamed(context, '/categories',
            arguments: CategoriesScreen(
              user: returnFindPerson,
            ));
      }
    } else {
      print('giriş başarısız!');
    }
  }
}
