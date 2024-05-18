import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo_bloc/bloc/home_bloc.dart';
import 'package:flutter_todo_bloc/bloc/todo_detail_cubit.dart';
import 'package:flutter_todo_bloc/views/list_row.dart';
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
            return ListView.separated(
              restorationId: 'sampleItemListView',
              itemCount: state.todoList.length,
              itemBuilder: (BuildContext context, int index) {
                final item = state.todoList[index];

                return ListRow(
                    content: item.content ?? '',
                    navigateTo: () async {
                      context.read<TodoDetailCubit>().setTodo(item);
                      context.push("/edit");
                    });
              },
              separatorBuilder: (context, index) => const Divider(),
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
