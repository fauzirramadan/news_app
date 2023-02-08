import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../../utils/notif_utils.dart';
import '../../helper/either.dart';
import '../../helper/failure.dart';
import '../../models/article.dart';
import '../../repository/general_repo.dart';
import '../../response/res_get_news.dart';

part 'per_category_news_state.dart';

class PerCategoryNewsCubit extends Cubit<PerCategoryNewsState> {
  PerCategoryNewsCubit() : super(PerCategoryNewsInitial());

  final GeneralRepo _repo = GeneralRepo();
  List<Article> listNews = [];
  int page = 1;

  Future<void> getNewsPerCat(String category,
      {String? fromDate, String? toDate}) async {
    emit(PerCategoryNewsLoading());
    Either<Failure, ResGetNews> res = await _repo.fetchNewsPerCategory(
        fromDate: fromDate, toDate: toDate, category: category);
    res.when(error: (e) {
      log(e.toString());
      NotifUtils.showSnackbar(e.message, backgroundColor: Colors.red);
      emit(PerCategoryNewsError(e.message));
    }, success: (data) {
      if (data.status == "ok") {
        listNews = data.articles ?? [];
        emit(PerCategoryNewsSuccess(listNews));
      } else if (data.status == "error") {
        NotifUtils.showSnackbar("Too many request",
            backgroundColor: Colors.red);
        emit(PerCategoryNewsError("Something went wrong"));
      } else {
        NotifUtils.showSnackbar("Something went wrong",
            backgroundColor: Colors.red);
        emit(PerCategoryNewsError("Something went wrong"));
      }
    });
  }
}
