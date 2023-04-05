import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolist_demo/data/constants.dart';
import 'package:todolist_demo/cubit/categories/categories_cubit.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  CategoriesBloc()
      : super(CategoriesState(
          categories: OldDataProvider.categories,
        )) {
    on<AddCategoriesEvent>((event, emit) {
      emit(CategoriesState(
          categories: [...state.categories, event.newCategory]));
    });
    on<DeleteCategoryEvent>((event, emit) {
      final newCategories = state.categories..remove(event.category);
      emit(CategoriesState(categories: newCategories));
    });
  }

  @override
  void onTransition(Transition<CategoriesEvent, CategoriesState> transition) {
    super.onTransition(transition);
  }
}

abstract class CategoriesEvent {}

class AddCategoriesEvent extends CategoriesEvent {
  String newCategory;
  AddCategoriesEvent({required this.newCategory});
}

class DeleteCategoryEvent extends CategoriesEvent {
  String category;
  DeleteCategoryEvent({required this.category});
}
