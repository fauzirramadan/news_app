import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:news_app/utils/constant.dart';

import '../components/category.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Map<String, dynamic>> listCat = [
    {"title": "Entertainment", 'pic': Constants.imgEntertain},
    {"title": "Business", 'pic': Constants.imgBusiness},
    {"title": "Sport", 'pic': Constants.imgSport},
    {"title": "Health", 'pic': Constants.imgHealth},
    {"title": "Technology", 'pic': Constants.imgTech}
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[100],
      appBar: AppBar(
        title: const Text("BaguNews"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 10, bottom: 10, top: 10),
            child: Text(
              "Category",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),
          ),
          CategoryWidget(listCat: listCat),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Discover",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.filter_alt_rounded,
                    size: 28,
                    color: Colors.grey[700],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
