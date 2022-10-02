import 'package:flutter/cupertino.dart';
import 'package:flutter_ecommerce/viewmodel/Provider.dart';
import 'package:flutter_ecommerce/router.dart';
import 'package:provider/provider.dart';

void main() => runApp(ChangeNotifierProvider<GlobalStateData>(
      child: const Routerer(),
      create: (BuildContext context) {
        return GlobalStateData();
      },
    ));
