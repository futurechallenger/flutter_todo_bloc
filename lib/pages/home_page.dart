import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Todo"),
        actions: [
          IconButton(
              onPressed: () {
                context.push("/settings");
              },
              icon: const Icon(Icons.settings))
        ],
      ),
      body: Center(
        child: ElevatedButton(
            onPressed: () {
              context.push("/edit");
            },
            child: const Text("Home")),
      ),
    );
  }
}
