import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo_bloc/bloc/todo_detail_cubit.dart';

class EditPage extends StatelessWidget {
  const EditPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final todo =
        context.select((TodoDetailCubit cubit) => cubit.state.todoItem);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editing'),
        actions: [
          TextButton(
              onPressed: () {},
              child: Text(todo?.status == 0 ? "Complete" : "In progress"))
        ],
      ),
      body: Center(
        child: Text(todo?.content ?? ""),
      ),
    );
  }
}
