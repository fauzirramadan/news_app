part of 'per_category_news_cubit.dart';

@immutable
abstract class PerCategoryNewsState {}

class PerCategoryNewsInitial extends PerCategoryNewsState {}

class PerCategoryNewsLoading extends PerCategoryNewsState {}

class PerCategoryNewsLoadMore extends PerCategoryNewsState {}

class PerCategoryNewsError extends PerCategoryNewsState {
  final String message;
  PerCategoryNewsError(this.message);
}

class PerCategoryNewsSuccess extends PerCategoryNewsState {
  final List<Article> listNews;
  PerCategoryNewsSuccess(this.listNews);
}
