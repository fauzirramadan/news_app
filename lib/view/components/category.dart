import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:news_app/utils/nav_utils.dart';
import 'package:news_app/view/ui/category/per_category_page.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({
    super.key,
    required this.listCat,
  });

  final List<Map<String, dynamic>> listCat;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: listCat.length,
      options: CarouselOptions(
          autoPlay: true,
          enlargeCenterPage: true,
          viewportFraction: 0.95,
          aspectRatio: 3.0),
      itemBuilder: (context, index, _) {
        var data = listCat[index];
        return GestureDetector(
          onTap: () => Nav.to(PerCategoryPage(
            category: data['title'],
          )),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                    fit: BoxFit.cover, image: AssetImage(data['pic']))),
            height: 180,
            child: Center(
              child: Text(
                data['title'],
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w700),
              ),
            ),
          ),
        );
      },
    );
  }
}
