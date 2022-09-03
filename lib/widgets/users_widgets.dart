import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:store_api/consts/global_colours.dart';

class UsersWidgets extends StatelessWidget {
  const UsersWidgets({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ListTile(
      leading: FancyShimmerImage(
        height: size.width * 0.15,
        width: size.width * 0.15,
        errorWidget: const Icon(
          IconlyBold.danger,
          color: Colors.red,
          size: 28,
        ),
        imageUrl: 'https://i.ibb.co/vwB46Yq/shoes.png',

        // imageUrl: usersModelProvider.avatar.toString(),
        boxFit: BoxFit.fill,
      ),
      title: const Text("name"),
      //  Text(usersModelProvider.name.toString()),
      subtitle: const Text("data"),
      // Text(usersModelProvider.email.toString()),
      trailing: Text(
        "",
        // usersModelProvider.role.toString(),
        style: TextStyle(
          color: lightIconsColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
