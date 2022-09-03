import 'Category.dart';

class ProductsModel {
  ProductsModel({
      this.id, 
      this.title, 
      this.price, 
      this.description, 
      this.category, 
      this.images,});

  ProductsModel.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    price = json['price'];
    description = json['description'];
    category = json['category'] != null ? Category.fromJson(json['category']) : null;
    images = json['images'] != null ? json['images'].cast<String>() : [];
  }
  int id;
  String title;
  int price;
  String description;
  Category category;
  List<String> images;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['price'] = price;
    map['description'] = description;
    if (category != null) {
      map['category'] = category.toJson();
    }
    map['images'] = images;
    return map;
  }

}