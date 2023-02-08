part of 'all_news_cubit.dart';

@immutable
abstract class AllNewsState {}

class AllNewsInitial extends AllNewsState {}

class AllNewsLoading extends AllNewsState {}

class AllNewsLoadMore extends AllNewsState {}

class AllNewsError extends AllNewsState {
  final String message;
  AllNewsError(this.message);
}

class AllNewsSuccess extends AllNewsState {
  final List<Article> listNews;
  AllNewsSuccess(this.listNews);
}
