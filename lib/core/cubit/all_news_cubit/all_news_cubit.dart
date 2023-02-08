import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'all_news_state.dart';

class AllNewsCubit extends Cubit<AllNewsState> {
  AllNewsCubit() : super(AllNewsInitial());
}
