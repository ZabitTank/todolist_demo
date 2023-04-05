import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:todolist_demo/cubit/categories/categories_cubit.dart';
import 'package:todolist_demo/ui/components/add_category_modal_bottom_sheet.dart';
import 'package:todolist_demo/ui/components/delete_button.dart';

class CategoryBox extends StatefulWidget {
  const CategoryBox({super.key});

  @override
  State<CategoryBox> createState() => _CategoryBoxState();
}

class _CategoryBoxState extends State<CategoryBox> {
  @override
  Widget build(BuildContext context) {
    String selectedCategory = "";
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context, selectedCategory),
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        title: const Text(
          "Categories",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30,
            color: Colors.black,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) => Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: Wrap(
                children: const [
                  AddCategoryModalBottomSheet(),
                ],
              ),
            ),
          ).then((value) => context.read<CategoriesCubit>().addCategory(value));
        },
        backgroundColor: Theme.of(context).primaryColor,
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(children: [
          Expanded(
            child: BlocBuilder<CategoriesCubit, CategoriesState>(
              builder: (context, state) {
                return ListView.builder(
                  itemCount: state.categories.length,
                  itemBuilder: (context, index) => Row(
                    children: [
                      Text(
                        state.categories[index],
                        style: const TextStyle(fontSize: 13),
                      ),
                      const Spacer(),
                      IconButton(
                          onPressed: () {
                            selectedCategory = state.categories[index];
                            Navigator.pop(context, selectedCategory);
                          },
                          icon: const Icon(Icons.check, size: 20)),
                      DeleteButton(
                          onTap: () => context
                              .read<CategoriesCubit>()
                              .removeCategory(state.categories[index]))
                    ],
                  ),
                );
              },
            ),
          ),
        ]),
      ),
    );
  }
}
