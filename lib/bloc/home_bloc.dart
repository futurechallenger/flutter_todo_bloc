// List events
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo_bloc/models/todo_model.dart';
import 'package:flutter_todo_bloc/repositories/todo_list.dart';

sealed class TodoListEvent extends Equatable {}

class TodoListRequested extends TodoListEvent {
  @override
  List<Object?> get props => [];
}

class TodoItemUpdated extends TodoListEvent {
  TodoItemUpdated({required this.todo});

  final TodoItem todo;

  @override
  List<Object?> get props => [todo];
}

// List state
@immutable
sealed class TodoListState extends Equatable {
  const TodoListState({required this.todoList});

  final List<TodoItem> todoList;
  @override
  List<Object?> get props => [todoList];
}

class TodoListInitialState extends TodoListState {
  const TodoListInitialState() : super(todoList: const <TodoItem>[]);
}

class TodoListLoadedState extends TodoListState {
  const TodoListLoadedState({required super.todoList});
}

class TodoListErrorState extends TodoListState {
  const TodoListErrorState() : super(todoList: const <TodoItem>[]);

  @override
  List<Object?> get props => [];
}

class TodoListBloc extends Bloc<TodoListEvent, TodoListState> {
  TodoListBloc() : super(const TodoListInitialState()) {
    on<TodoListRequested>(_onFetchTodoList);
    on<TodoItemUpdated>(_onTodoItemUpdated);
  }

  Future<void> _onFetchTodoList(
      TodoListEvent event, Emitter<TodoListState> emit) async {
    emit(const TodoListInitialState());
    try {
      final repository = TodoListRepository();
      final result = await repository.fetchTodoList(all: true);
      emit(TodoListLoadedState(todoList: result ?? []));
    } catch (error) {
      emit(const TodoListErrorState());
    }
  }

  void _onTodoItemUpdated(TodoItemUpdated event, Emitter<TodoListState> emit) {
    final todo = event.todo;
    final todoList = state.todoList.map((TodoItem el) {
      if (el.id == todo.id) {
        return todo;
      } else {
        return el;
      }
    });

    emit(TodoListLoadedState(todoList: todoList.toList()));
  }
}
