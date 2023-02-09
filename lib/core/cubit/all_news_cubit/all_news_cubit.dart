import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:news_app/core/helper/failure.dart';
import 'package:news_app/core/models/article.dart';
import 'package:news_app/core/repository/general_repo.dart';
import 'package:news_app/core/response/res_get_news.dart';
import 'package:news_app/utils/notif_utils.dart';

import '../../helper/either.dart';

part 'all_news_state.dart';

class AllNewsCubit extends Cubit<AllNewsState> {
  AllNewsCubit() : super(AllNewsInitial());

  final GeneralRepo _repo = GeneralRepo();
  final TextEditingController searchC = TextEditingController();
  List<Article> listNews = [];

  Future<void> getAllNews({String? fromDate, String? toDate}) async {
    emit(AllNewsLoading());
    Either<Failure, ResGetNews> res = await _repo.fetchAllNews(
        fromDate: fromDate,
        toDate: toDate,
        query: searchC.text.isEmpty ? "indonesia" : searchC.text);
    res.when(error: (e) {
      log(e.toString());
      NotifUtils.showSnackbar(e.message, backgroundColor: Colors.red);
      emit(AllNewsError(e.message));
    }, success: (data) {
      if (data.status == "ok") {
        listNews = data.articles ?? [];
        emit(AllNewsSuccess(listNews));
      } else if (data.status == "error") {
        NotifUtils.showSnackbar("Too many request",
            backgroundColor: Colors.red);
        emit(AllNewsError("Something went wrong"));
      } else {
        NotifUtils.showSnackbar("Something went wrong",
            backgroundColor: Colors.red);
        emit(AllNewsError("Something went wrong"));
      }
    });
  }
}
