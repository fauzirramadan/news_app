// To parse this JSON data, do
//
//     final resGetNews = resGetNewsFromJson(jsonString);

import 'dart:convert';

import '../models/article.dart';

ResGetNews resGetNewsFromJson(String str) =>
    ResGetNews.fromJson(json.decode(str));

String resGetNewsToJson(ResGetNews data) => json.encode(data.toJson());

class ResGetNews {
  ResGetNews({
    this.status,
    this.totalResults,
    this.articles,
  });

  String? status;
  int? totalResults;
  List<Article>? articles;

  factory ResGetNews.fromJson(Map<String, dynamic> json) => ResGetNews(
        status: json["status"],
        totalResults: json["totalResults"],
        articles: json["articles"] == null
            ? []
            : List<Article>.from(
                json["articles"]!.map((x) => Article.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "totalResults": totalResults,
        "articles": articles == null
            ? []
            : List<dynamic>.from(articles!.map((x) => x.toJson())),
      };
}
