// List events
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo_bloc/models/todo_model.dart';
import 'package:flutter_todo_bloc/repositories/todo_list.dart';

abstract class TodoListEvent {}

class LoadTodoListEvent extends TodoListEvent {}

// List state
@immutable
sealed class TodoListState extends Equatable {}

class TodoListInitialState extends TodoListState {
  final todoList = [];

  @override
  List<Object?> get props => [];
}

class TodoListLoadedState extends TodoListState {
  TodoListLoadedState({this.todoList = const <TodoItem>[]});

  final List<TodoItem> todoList;

  @override
  List<Object?> get props => [todoList];
}

class TodoListErrorState extends TodoListState {
  TodoListErrorState({this.error});

  final Error? error;

  @override
  List<Object?> get props => [];
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
