import 'package:flutter/material.dart';
import 'package:store_api/widgets/feeds_widget.dart';

class FeedsScreen extends StatelessWidget {
  const FeedsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("All Products"),
      ),
      body: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 3,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 0,
            mainAxisSpacing: 0,
            childAspectRatio: 0.6),
        itemBuilder: (context, index) {
          return const FeedsWidget();
        },
      ),
    );
  }
}
