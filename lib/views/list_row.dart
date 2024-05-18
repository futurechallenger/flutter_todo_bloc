import 'package:flutter/material.dart';

class ListRow extends StatelessWidget {
  const ListRow({super.key, required this.content, required this.navigateTo});

  final String content;
  final VoidCallback navigateTo;

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Text(content),
        leading: const Icon(Icons.circle_outlined),
        onTap: () {
          navigateTo();
        });
  }
}
