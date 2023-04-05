import 'package:todolist_demo/data/provider/category_provider.dart';
import 'package:todolist_demo/data/provider/todo_provider.dart';

class Repository {
  final TodoDataProvider todoDataProvider = TodoDataProvider();
  final CategoryDataProvider categoryDataProvider = CategoryDataProvider();
}
