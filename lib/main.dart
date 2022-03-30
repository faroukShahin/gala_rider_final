import 'package:flutter/material.dart';
import 'package:gala_rider/homeScreen/login_screen.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'homeScreen/homeScreenController.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initializeDateFormatting("ar_SA", null);
  Hive.init((await getApplicationDocumentsDirectory()).path);
  await Hive.openBox('main');
  runApp( MyApp());
}

Color mainColor = const Color(0xffff5a00);
var orderStatus = ValueNotifier<int>(0);

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final isLoggedIn = Hive.box('main').containsKey('token');

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gala rider',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: isLoggedIn ? HomeScreenController()  : LoginScreen(),
    );
  }
}
