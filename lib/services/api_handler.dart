import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:store_api/consts/api_consts.dart';
import 'package:store_api/models/category_model.dart';
import 'package:store_api/models/products_model.dart';
import 'package:store_api/models/users_model.dart';

class APIHandler {
  static Future<List<ProductsModel>> getAllProducts() async {
    var uri = Uri.https(BASE_URL, "/api/v1/products");
    var response = await http.get(uri);
    // ignore: avoid_print
    print("response ${jsonDecode(response.body)}");
    var data = jsonDecode(response.body);
    List tempList = [];
    for (var v in data) {
      tempList.add(v);
      // print("v $v \n\n");
    }
    return ProductsModel.productsFromSnapshot(tempList);
  }

  static Future<List<CategoriesModel>> getAllCategories() async {
    var uri = Uri.https(BASE_URL, "/api/v1/categories");
    var response = await http.get(uri);
    // ignore: avoid_print
    print("response ${jsonDecode(response.body)}");
    var data = jsonDecode(response.body);
    List tempList = [];
    for (var v in data) {
      tempList.add(v);
      // print("v $v \n\n");
    }
    return CategoriesModel.categoriesFromSnapshot(tempList);
  }

  // for getting users
  static Future<List<UsersModel>> getAllUsers() async {
    var uri = Uri.https(BASE_URL, "/api/v1/users");
    var response = await http.get(uri);
    // ignore: avoid_print
    print("response ${jsonDecode(response.body)}");
    var data = jsonDecode(response.body);
    List tempList = [];
    for (var v in data) {
      tempList.add(v);
      // print("v $v \n\n");
    }
    return UsersModel.usersFromSnapshot(tempList);
  }
}
