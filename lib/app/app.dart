import 'package:flutter/material.dart';

import '../view/ui/home_page.dart';

final GlobalKey<ScaffoldMessengerState> notifKey = GlobalKey();
final GlobalKey<NavigatorState> navKey = GlobalKey();

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: notifKey,
      navigatorKey: navKey,
      debugShowCheckedModeBanner: false,
      title: 'Flutter News App',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const HomePage(),
    );
  }
}
