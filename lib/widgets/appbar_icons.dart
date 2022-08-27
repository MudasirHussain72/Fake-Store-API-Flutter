import 'package:flutter/material.dart';

class AppBarIcons extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const AppBarIcons({required this.function, required this.icon});
  final Function function;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: GestureDetector(
          onTap: () {
            function();
          },
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Theme.of(context).cardColor,
            ),
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: Icon(
                icon,
                size: 35,
              ),
            ),
          )),
    );
  }
}
