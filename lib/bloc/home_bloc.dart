// List events
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo_bloc/models/todo_model.dart';
import 'package:flutter_todo_bloc/repositories/todo_list.dart';

sealed class TodoListEvent extends Equatable {}

class TodoListLoaded extends TodoListEvent {
  @override
  List<Object?> get props => [];
}

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
  TodoListErrorState();

  @override
  List<Object?> get props => [];
}

class TodoListBloc extends Bloc<TodoListEvent, TodoListState> {
  TodoListBloc() : super(TodoListInitialState()) {
    on<TodoListLoaded>(_onFetchTodoList);
  }

  Future<void> _onFetchTodoList(
      TodoListEvent event, Emitter<TodoListState> emit) async {
    emit(TodoListInitialState());
    try {
      final repository = TodoListRepository();
      final result = await repository.fetchTodoList();
      emit(TodoListLoadedState(todoList: result ?? []));
    } catch (error) {
      emit(TodoListErrorState());
    }
  }
}
