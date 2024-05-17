import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo_bloc/bloc/home_bloc.dart';
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
      body: BlocBuilder<TodoListBloc, TodoListState>(builder: (context, state) {
        switch (state) {
          case TodoListInitialState():
            return const Center(
              child: CircularProgressIndicator(),
            );
          case TodoListLoadedState():
            // TODO: list for todo list
            return Center(
              child: ElevatedButton(
                  onPressed: () {
                    context.push("/edit");
                  },
                  child: const Text("Home")),
            );
          case TodoListErrorState():
            return const Center(
              child: Text("Error"),
            );
        }
      }),
    );
  }
}
