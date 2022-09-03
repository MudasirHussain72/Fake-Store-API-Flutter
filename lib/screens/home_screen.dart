import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:store_api/consts/global_colours.dart';
import 'package:store_api/models/products_model.dart';
import 'package:store_api/screens/category_screen.dart';
import 'package:store_api/screens/feeds_screen.dart';
import 'package:store_api/screens/users_screen.dart';
import 'package:store_api/services/api_handler.dart';
import 'package:store_api/widgets/feeds_grid.dart';
import 'package:store_api/widgets/sale_widget.dart';
import '../widgets/appbar_icons.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late TextEditingController searchController;
  // List<ProductsModel> productsList = [];
  @override
  void initState() {
    searchController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    // ignore: todo
    // TODO: implement dispose
    searchController.dispose();
    super.dispose();
  }

  // @override
  // void didChangeDependencies() {
  //   // ignore: todo
  //   // TODO: implement didChangeDependencies
  //   getProducts();
  //   super.didChangeDependencies();
  // }

  // Future<void> getProducts() async {
  //   productsList = await APIHandler.getAllProducts();
  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("HOME"),
        leading: InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  PageTransition(
                      child: const CategoryScreen(),
                      type: PageTransitionType.fade));
            },
            child: const Icon(Icons.menu)),
        actions: [
          InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    PageTransition(
                        child: const UsersScreen(),
                        type: PageTransitionType.fade));
              },
              child: const Icon(Icons.shopping_cart_outlined))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: searchController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  hintText: "Search",
                  filled: true,
                  fillColor: Theme.of(context).cardColor,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(color: Theme.of(context).cardColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                        width: 1,
                        color: Theme.of(context).colorScheme.secondary),
                  ),
                  suffixIcon: Icon(
                    Icons.search,
                    color: lightIconsColor,
                  )),
            ),
            const SizedBox(
              height: 18,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: size.height * 0.25,
                      child: Swiper(
                        autoplay: true,
                        // duration: 300,
                        autoplayDelay: 3000,
                        autoplayDisableOnInteraction: false,
                        itemCount: 3,
                        itemBuilder: (context, index) {
                          return const SaleWidget();
                        },
                        pagination: const SwiperPagination(
                          alignment: Alignment.bottomCenter,
                          builder: DotSwiperPaginationBuilder(
                              color: Colors.white, activeColor: Colors.red),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          const Text(
                            "Latest Products",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                            ),
                          ),
                          const Spacer(),
                          AppBarIcons(
                            function: () {
                              Navigator.push(
                                context,
                                PageTransition(
                                  type: PageTransitionType.fade,
                                  child: const FeedsScreen(),
                                ),
                              );
                            },
                            icon: Icons.arrow_right_rounded,
                          ),
                        ],
                      ),
                    ),
                    // GridView.builder(
                    //   shrinkWrap: true,
                    //   physics: const NeverScrollableScrollPhysics(),
                    //   itemCount: 3,
                    //   gridDelegate:
                    //       const SliverGridDelegateWithFixedCrossAxisCount(
                    //           crossAxisCount: 2,
                    //           crossAxisSpacing: 0,
                    //           mainAxisSpacing: 0,
                    //           childAspectRatio: 0.6),
                    //   itemBuilder: (context, index) {
                    //     return const FeedsWidget();
                    //   },
                    // )

                    //  // productsList.isEmpty
                    //     ? Container()
                    //     : FeedsGridWidget(productsList: productsList)
                    FutureBuilder<List<ProductsModel>>(
                        future: APIHandler.getAllProducts(),
                        builder: ((context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (snapshot.hasError) {
                            return Center(
                              child: Text("an error occured ${snapshot.error}"),
                            );
                          } else if (snapshot.data == null) {
                            return Center(
                              child: Text("no products has been added yet"),
                            );
                          }
                          return FeedsGridWidget(productsList: snapshot.data!);
                        }))
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
