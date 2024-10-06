import "package:flutter/material.dart";


class BlogCard extends StatelessWidget {
  String? title;

  BlogCard(
      {super.key,
      required this.title});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey.withOpacity(0.5),
      child:  Padding(
        padding: const EdgeInsets.all(7),
        child: Text(title!, style: const TextStyle(fontSize: 35),)
      ),
    );
  }
}
