import 'package:flutter/material.dart';

import '../view/ui/home.dart';

final GlobalKey<ScaffoldMessengerState> notifKey = GlobalKey();
final GlobalKey<NavigatorState> navKey = GlobalKey();

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: notifKey,
      navigatorKey: navKey,
      title: 'Flutter News App',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const HomePage(),
    );
  }
}
