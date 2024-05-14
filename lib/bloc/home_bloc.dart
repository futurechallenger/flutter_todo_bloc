// List events
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class TodoListEvent {}

class LoadTodoListEvent extends TodoListEvent {}

// List state
abstract class TodoListState {}

class InitialState extends TodoListState {}

class TodoListLoadedState extends TodoListState {}

class TodoListBloc extends Bloc<TodoListEvent, TodoListState> {
  TodoListBloc() : super(InitialState()) {
    on<LoadTodoListEvent>(
      (event, emit) {},
    );
  }
}
