import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_api/models/category_model.dart';
import 'package:store_api/services/api_handler.dart';
import 'package:store_api/widgets/category_widget.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("All Category"),
        ),
        body: FutureBuilder<List<CategoriesModel>>(
            future: APIHandler.getAllCategories(),
            builder: ((context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text("an error occured ${snapshot.error}"),
                );
              } else if (snapshot.data == null) {
                return const Center(
                  child: Text("no products has been added yet"),
                );
              }
              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 4,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 0,
                    mainAxisSpacing: 0,
                    childAspectRatio: 1),
                itemBuilder: (context, index) {
                  return ChangeNotifierProvider.value(
                      value: snapshot.data![index], child: const CategoryWidget());
                },
              );
            })));
  }
}
