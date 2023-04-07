import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolist_demo/data/constants.dart';
import 'package:todolist_demo/cubit/categories/categories_cubit.dart';

part 'categories_event.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  CategoriesBloc()
      : super(CategoriesState(
          categories: OldDataProvider.categories,
        )) {
    on<AddCategoriesEvent>(_addCategories);
    on<DeleteCategoryEvent>(_deleteCategory);
  }

  void _addCategories(AddCategoriesEvent event, Emitter<CategoriesState> emit) {
    emit(CategoriesState(categories: [...state.categories, event.newCategory]));
  }

  void _deleteCategory(
      DeleteCategoryEvent event, Emitter<CategoriesState> emit) {
    final newCategories = state.categories..remove(event.category);
    emit(CategoriesState(categories: newCategories));
  }

  @override
  void onTransition(Transition<CategoriesEvent, CategoriesState> transition) {
    super.onTransition(transition);
  }
}
