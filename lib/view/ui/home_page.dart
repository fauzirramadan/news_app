import 'package:flutter/material.dart';
import 'package:news_app/utils/constant.dart';

import '../components/category.dart';
import '../components/list_all_news.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Map<String, dynamic>> listCat = [
    {"title": "Entertainment", 'pic': Constants.imgEntertain},
    {"title": "Business", 'pic': Constants.imgBusiness},
    {"title": "Sports", 'pic': Constants.imgSport},
    {"title": "Health", 'pic': Constants.imgHealth},
    {"title": "Technology", 'pic': Constants.imgTech},
    {"title": "Science", 'pic': Constants.imgScience}
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[50],
      appBar: AppBar(
        title: const Text("BaguNewsID"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 10, bottom: 10, top: 10),
            child: Text(
              "Top Headline Category",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),
          ),
          CategoryWidget(listCat: listCat),
          const ListAllNews(),
        ],
      ),
    );
  }
}
