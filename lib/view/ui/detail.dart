import 'package:flutter/material.dart';
import 'package:news_app/view/widgets/loading_circular.dart';

import '../../core/models/article.dart';

class DetailNews extends StatelessWidget {
  final Article? data;
  const DetailNews({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail Content"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                child: Image.network(
              data?.urlToImage ?? "",
              height: 200,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress != null) {
                  return const LoadingCircular();
                } else {
                  return child;
                }
              },
              errorBuilder: (context, error, stackTrace) => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.error,
                      color: Colors.red,
                      size: 50,
                    ),
                    Text(
                      "ERROR",
                      style: TextStyle(color: Colors.red),
                    )
                  ],
                ),
              ),
            )),
            const SizedBox(
              height: 10,
            ),
            Text(
              data?.title ?? "",
              style: const TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              data?.content ?? "",
              style: const TextStyle(color: Colors.black87),
              textAlign: TextAlign.justify,
            ),
          ],
        ),
      ),
    );
  }
}
