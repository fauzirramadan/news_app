import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:news_app/core/cubit/all_news_cubit/all_news_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/utils/date_utils.dart';
import 'package:news_app/view/widgets/loading_circular.dart';

import '../widgets/custom_field.dart';
import '../widgets/tile.dart';

class ListAllNews extends StatefulWidget {
  const ListAllNews({
    super.key,
  });

  @override
  State<ListAllNews> createState() => _ListAllNewsState();
}

class _ListAllNewsState extends State<ListAllNews> {
  DateTime? selectedDate;
  AllNewsCubit? cubit;
  AllNewsState? currentState;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AllNewsCubit(),
      child: Expanded(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Discover",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                  ),
                  const Spacer(),
                  Text(DateFormatUtils.toSimpleTime(
                      selectedDate ?? DateTime.now())),
                  IconButton(
                    onPressed: () => selectDate(context, cubit),
                    icon: Icon(
                      Icons.filter_alt_rounded,
                      size: 28,
                      color: Colors.grey[700],
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 10),
              child: CustomField(
                controller: cubit?.searchC,
                onEditingComplete: () {
                  if (cubit?.searchC.text.length != 0) {
                    cubit?.getAllNews(
                        fromDate: DateFormatUtils.toSimpleTime(
                            selectedDate ?? DateTime.now()),
                        toDate: DateFormatUtils.toSimpleTime(
                            selectedDate ?? DateTime.now()));
                    setState(() {});
                  } else {
                    null;
                  }
                },
                onChanged: (val) {
                  setState(() {});
                  if (val.isEmpty) {
                    cubit?.getAllNews(
                        fromDate: DateFormatUtils.toSimpleTime(
                            selectedDate ?? DateTime.now()),
                        toDate: DateFormatUtils.toSimpleTime(
                            selectedDate ?? DateTime.now()));
                  }
                },
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            BlocBuilder<AllNewsCubit, AllNewsState>(
              builder: (context, state) {
                cubit = context.read<AllNewsCubit>();
                currentState = state;
                if (currentState is AllNewsInitial) {
                  cubit?.searchC.clear();
                  cubit?.getAllNews(
                      fromDate: DateFormatUtils.toSimpleTime(DateTime.now()),
                      toDate: DateFormatUtils.toSimpleTime(DateTime.now()));
                }

                if (currentState is AllNewsError) {
                  return const Text("SOMETHING WENT WRONG");
                }

                if (currentState is AllNewsSuccess) {
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
                }
                return const Padding(
                  padding: EdgeInsets.only(top: 30.0),
                  child: LoadingCircular(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> selectDate(BuildContext context, AllNewsCubit? cubit) {
    return showDatePicker(
      helpText: "Filter News by DateTime",
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(DateTime.now().year - 1, 5),
      lastDate: DateTime(DateTime.now().year + 1, 9),
    ).then((date) {
      if (date != null) {
        selectedDate = date;
        log(DateFormatUtils.toSimpleTime(selectedDate ?? DateTime.now()));
        setState(() {});
        cubit?.getAllNews(
            fromDate:
                DateFormatUtils.toSimpleTime(selectedDate ?? DateTime.now()),
            toDate:
                DateFormatUtils.toSimpleTime(selectedDate ?? DateTime.now()));
      }
    });
  }
}
