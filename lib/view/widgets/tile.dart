import 'package:flutter/material.dart';
import 'package:news_app/utils/nav_utils.dart';
import 'package:news_app/view/ui/detail.dart';
import 'package:news_app/view/widgets/loading_circular.dart';

import '../../core/models/article.dart';
import '../../utils/date_utils.dart';

class NewsTile extends StatelessWidget {
  final Article? data;
  const NewsTile({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.deepPurple[100],
          borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
      child: ListTile(
        onTap: () => Nav.to(DetailNews(
          data: data,
        )),
        leading: Image.network(
          data?.urlToImage ?? "",
          fit: BoxFit.contain,
          width: 80,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress != null) {
              return const CircularProgressIndicator();
            } else {
              return child;
            }
          },
          errorBuilder: (context, error, stackTrace) => const Icon(
            Icons.error,
            color: Colors.red,
            size: 50,
          ),
        ),
        title: Text(
          data?.title ?? "",
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(data?.author ?? ""),
        trailing: Text(
            DateFormatUtils.toSimpleTime(data?.publishedAt ?? DateTime.now())),
      ),
    );
  }
}
