part of 'categories_bloc.dart';

abstract class CategoriesEvent {}

class AddCategoriesEvent extends CategoriesEvent {
  String newCategory;
  AddCategoriesEvent({required this.newCategory});
}

class DeleteCategoryEvent extends CategoriesEvent {
  String category;
  DeleteCategoryEvent({required this.category});
}
