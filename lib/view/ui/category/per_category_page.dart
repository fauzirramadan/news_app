import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/cubit/per_category_news_cubit/per_category_news_cubit.dart';
import 'package:news_app/view/widgets/custom_field.dart';
import 'package:news_app/view/widgets/tile.dart';

import '../../../core/models/article.dart';
import '../../widgets/loading_circular.dart';

class PerCategoryPage extends StatefulWidget {
  final String? category;
  const PerCategoryPage({super.key, this.category});

  @override
  State<PerCategoryPage> createState() => _PerCategoryPageState();
}

class _PerCategoryPageState extends State<PerCategoryPage> {
  PerCategoryNewsCubit? cubit;
  PerCategoryNewsState? currentState;
  DateTime? selectedDate;
  List<Article> foundNews = [];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PerCategoryNewsCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.category ?? ""),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 10.0, left: 10, right: 10),
          child: Column(
            children: [
              CustomField(
                controller: cubit?.searchC,
                onChanged: (val) {
                  foundNews = cubit?.listNews.where((element) {
                        if (element.author != null) {
                          return element.author?.toLowerCase().contains(val) ??
                              false;
                        }
                        if (element.title != null) {
                          return element.title?.toLowerCase().contains(val) ??
                              false;
                        }
                        if (element.source?.name != null) {
                          return element.source?.name
                                  ?.toLowerCase()
                                  .contains(val) ??
                              false;
                        }

                        if (element.content != null) {
                          return element.content?.toLowerCase().contains(val) ??
                              false;
                        }
                        return false;
                      }).toList() ??
                      [];
                  setState(() {});
                },
              ),
              const SizedBox(
                height: 10,
              ),
              BlocBuilder<PerCategoryNewsCubit, PerCategoryNewsState>(
                builder: (context, state) {
                  cubit = context.read<PerCategoryNewsCubit>();
                  currentState = state;
                  if (currentState is PerCategoryNewsInitial) {
                    cubit?.getNewsPerCat(widget.category ?? "");
                  }
                  if (currentState is PerCategoryNewsSuccess) {
                    return cubit!.listNews.isEmpty
                        ? const Text("NO DATA")
                        : foundNews.isNotEmpty
                            ? foundDataList()
                            : initialDataList();
                  }
                  if (currentState is PerCategoryNewsError) {
                    return const Text("SOMETHING WENT WRONG");
                  }
                  return const Padding(
                    padding: EdgeInsets.only(top: 30.0),
                    child: LoadingCircular(),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget initialDataList() {
    return Expanded(
      child: ListView.builder(
          itemCount: cubit?.listNews.length,
          itemBuilder: (context, index) {
            final data = cubit?.listNews[index];
            return NewsTile(data: data);
          }),
    );
  }

  Widget foundDataList() {
    return Expanded(
      child: ListView.builder(
          itemCount: foundNews.length,
          itemBuilder: (context, index) {
            final data = foundNews[index];
            return NewsTile(data: data);
          }),
    );
  }
}
