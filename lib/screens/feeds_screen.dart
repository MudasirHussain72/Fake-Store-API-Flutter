import 'package:flutter/material.dart';
import 'package:store_api/models/products_model.dart';
import 'package:store_api/services/api_handler.dart';
import 'package:store_api/widgets/feeds_widget.dart';

class FeedsScreen extends StatefulWidget {
  const FeedsScreen({Key? key}) : super(key: key);

  @override
  State<FeedsScreen> createState() => _FeedsScreenState();
}

class _FeedsScreenState extends State<FeedsScreen> {
  List<ProductsModel> productsList = [];

  @override
  void didChangeDependencies() {
    // ignore: todo
    // TODO: implement didChangeDependencies
    getProducts();
    super.didChangeDependencies();
  }

  Future<void> getProducts() async {
    productsList = await APIHandler.getAllProducts();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("All Products"),
      ),
      body: productsList.isEmpty
          ? Center(child: CircularProgressIndicator())
          :
          // FeedsGridWidget(productsList: productsList)
          GridView.builder(
              // shrinkWrap: true,
              // physics: const NeverScrollableScrollPhysics(),
              itemCount: productsList.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 0,
                  mainAxisSpacing: 0,
                  childAspectRatio: 0.6),
              itemBuilder: (context, index) {
                return FeedsWidget(
                  imageUrl: productsList[index].images![0],
                  title: productsList[index].title.toString(),
                );
              },
            ),
    );
  }
}
