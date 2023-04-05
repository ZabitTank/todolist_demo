import 'package:bloc/bloc.dart';
import 'package:todolist_demo/constants/constants.dart';

part 'categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  CategoriesCubit()
      : super(CategoriesState(
          categories: TodoDataProvider.categories,
        ));

  void addCategory(String category) {
    emit(CategoriesState(categories: [...state.categories, category]));
  }

  void removeCategory(String category) {
    emit(CategoriesState(categories: state.categories..remove(category)));
  }
}
