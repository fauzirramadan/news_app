import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/cubit/per_category_news_cubit/per_category_news_cubit.dart';
import 'package:news_app/view/widgets/custom_field.dart';
import 'package:news_app/view/widgets/tile.dart';

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
                hintText: "Search title, name, author",
                onChanged: (val) {},
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
                  if (currentState is PerCategoryNewsLoading) {
                    return const Padding(
                      padding: EdgeInsets.only(top: 30.0),
                      child: LoadingCircular(),
                    );
                  }
                  return cubit!.listNews.isEmpty
                      ? const Text("NO DATA")
                      : Expanded(
                          child: ListView.builder(
                              itemCount: cubit?.listNews.length,
                              itemBuilder: (context, index) {
                                final data = cubit?.listNews[index];
                                return NewsTile(data: data);
                              }),
                        );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
