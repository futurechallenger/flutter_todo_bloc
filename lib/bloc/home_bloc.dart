// List events
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo_bloc/models/todo_model.dart';
import 'package:flutter_todo_bloc/repositories/todo_list.dart';

abstract class TodoListEvent {}

class LoadTodoListEvent extends TodoListEvent {}

// List state
abstract class TodoListState {}

class TodoListInitialState extends TodoListState {
  final todoList = [];
}

class TodoListLoadedState extends TodoListState {
  TodoListLoadedState({required this.todoList});

  var todoList = <TodoItem>[];
}

class TodoListErrorState extends TodoListState {
  TodoListErrorState({this.error});

  Error? error;
}

class TodoListBloc extends Bloc<TodoListEvent, TodoListState> {
  TodoListBloc() : super(TodoListInitialState()) {
    on<LoadTodoListEvent>(
      (event, emit) {
        final repository = TodoListRepository();
        repository
            .fetchTodoList()
            .then((value) => emit(TodoListLoadedState(todoList: value ?? [])))
            .catchError((error) => emit(TodoListErrorState(error: error)));
      },
    );
  }
}
