import 'package:flutter/Material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return welcomeWidget(context);
  }
}

Widget welcomeWidget(BuildContext context) {
  return Scaffold(
      body: Container(
    width: double.infinity,
    height: double.infinity,
    decoration: BoxDecoration(
        image: const DecorationImage(
            alignment: Alignment(0, -0.7),
            scale: 4.0,
            image: AssetImage('assets/images/logo.png')),
        color: Colors.blueGrey.shade900,
        border:
            Border.all(width: 1, color: const Color.fromRGBO(230, 81, 0, 1)),
        gradient: LinearGradient(colors: [
          Colors.blueGrey.shade900,
          Colors.blueGrey.shade800,
          Colors.blueGrey.shade700,
          Colors.blueGrey.shade800,
          Colors.blueGrey.shade900
        ])),
    child: Column(
      children: <Widget>[
        companyNameText(),
        loginButton(context),
        letsStartButton(context),
      ],
    ),
  ));
}

Widget letsStartButton(BuildContext context) {
  return Container(
      margin: const EdgeInsets.only(top: 10.0),
      child: OutlinedButton(
          onPressed: () {
            Navigator.pushNamed(context, '/letsStart');
          },
          style: ButtonStyle(
              fixedSize: MaterialStateProperty.all<Size>(const Size(300, 40)),
              foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
              backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
              side: MaterialStateProperty.all<BorderSide>(
                  const BorderSide(color: Colors.white))),
          child: const Text('Let\'s Start')));
}

Widget loginButton(BuildContext context) {
  return Container(
      margin: const EdgeInsets.only(top: 220.0),
      child: ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, '/login');
          },
          style: ButtonStyle(
              textStyle: MaterialStateProperty.all<TextStyle>(
                  const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              fixedSize: MaterialStateProperty.all<Size>(const Size(300, 40)),
              foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
              backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
              side: MaterialStateProperty.all<BorderSide>(
                  const BorderSide(color: Colors.white))),
          child: const Text('Log In')));
}

Widget companyNameText() {
  return Container(
    margin: const EdgeInsets.only(top: 230.0),
    child: const Text(
      'Company Name',
      style: TextStyle(
        color: Color.fromRGBO(230, 81, 0, 1),
        fontWeight: FontWeight.bold,
        fontSize: 30.0,
      ),
    ),
  );
}
