import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo_bloc/bloc/todo_detail_cubit.dart';
import 'package:flutter_todo_bloc/bloc/todo_toggle_bloc.dart';
import 'package:flutter_todo_bloc/models/todo_model.dart';

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
          TextButton(onPressed: () {
            context
                .read<TodoToggleBloc>()
                .add(TodoToggleEvent(id: todo!.id!, status: todo.status!));
          }, child: BlocBuilder<TodoToggleBloc, TodoToggleState>(
            builder: (context, state) {
              switch (state.progress) {
                case ActionProgress.initial:
                  return Text(state.status == 0 ? "Complete" : "In progress");
                case ActionProgress.loading:
                  return const CircularProgressIndicator();
                case ActionProgress.success:
                  context.read<TodoDetailCubit>().setTodo(TodoItem(
                      id: todo!.id,
                      status: state.status,
                      content: todo.content!));
                  return Text(state.status == 0 ? "Complete" : "In progress");
                case ActionProgress.failure:
                  return const Text('Error');
              }
            },
          ))
        ],
      ),
      body: Center(
        child: Text(todo?.content ?? ""),
      ),
    );
  }
}
