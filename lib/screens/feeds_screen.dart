import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_api/models/products_model.dart';
import 'package:store_api/services/api_handler.dart';
import 'package:store_api/widgets/feeds_widget.dart';

class FeedsScreen extends StatefulWidget {
  const FeedsScreen({Key? key}) : super(key: key);

  @override
  State<FeedsScreen> createState() => _FeedsScreenState();
}

class _FeedsScreenState extends State<FeedsScreen> {
  final ScrollController _scrollController = ScrollController();
  List<ProductsModel> productsList = [];
  int limit = 10;
  // bool _isLoading = false;
  bool _isLimit = false;
  @override
  void initState() {
    // TODO: implement initState
    getProducts();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // getProducts();
    _scrollController.addListener(() async {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        // _isLoading = true;
        // print("_isLoading $_isLoading");
        limit += 10;
        print("limit $limit");
        if (limit == 30) {
          _isLimit = true;
          setState(() {});
          return;
        }
        await getProducts();
        // _isLoading = false;
      }
    });
    super.didChangeDependencies();
  }

  Future<void> getProducts() async {
    productsList = await APIHandler.getAllProducts(limit: limit.toString());
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("All Products"),
      ),
      body: productsList.isEmpty
          ? const Center(child: CircularProgressIndicator())
          :
          // FeedsGridWidget(productsList: productsList)
          SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                children: [
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: productsList.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 0,
                            mainAxisSpacing: 0,
                            childAspectRatio: 0.6),
                    itemBuilder: (context, index) {
                      return ChangeNotifierProvider.value(
                        value: productsList[index],
                        child: const FeedsWidget(),
                      );
                    },
                  ),
                  if (!_isLimit)
                    Center(
                      child: CircularProgressIndicator(),
                    )
                ],
              ),
            ),
    );
  }
}
