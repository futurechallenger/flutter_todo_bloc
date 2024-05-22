import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo_bloc/models/todo_model.dart';

final class TodoDetailState extends Equatable {
  const TodoDetailState({this.todoItem});

  final TodoItem? todoItem;

  @override
  List<Object?> get props => [todoItem];
}

class TodoDetailCubit extends Cubit<TodoDetailState> {
  TodoDetailCubit({required TodoItem todo})
      : super(TodoDetailState(todoItem: todo));

  void setTodo(TodoItem todo) => emit(TodoDetailState(todoItem: todo));
}
