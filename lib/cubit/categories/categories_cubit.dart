import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolist_demo/data/constants.dart';

part 'categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  CategoriesCubit()
      : super(CategoriesState(
          categories: OldDataProvider.categories,
        ));

  void addCategory(String category) {
    emit(CategoriesState(categories: [...state.categories, category]));
  }

  void removeCategory(String category) {
    emit(CategoriesState(categories: state.categories..remove(category)));
  }
}
