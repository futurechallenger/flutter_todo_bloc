import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo_bloc/models/todo_model.dart';
import 'package:flutter_todo_bloc/repositories/todo_detail.dart';

enum ActionProgress { initial, loading, success, failure }

extension ActionProgressExt on ActionProgress {
  get isLoadingOrSuccess =>
      [ActionProgress.loading, ActionProgress.success].contains(this);
}

sealed class _TodoToggleEvent extends Equatable {
  const _TodoToggleEvent();

  @override
  List<Object?> get props => [];
}

final class TodoToggleEvent extends _TodoToggleEvent {
  const TodoToggleEvent({required this.id, required this.status});

  final int id;
  final int status;

  @override
  List<Object?> get props => [id, status];
}

final class TodoToggleState extends Equatable {
  const TodoToggleState(
      {required this.id,
      required this.status,
      this.progress = ActionProgress.initial});

  final int id;
  final int status;
  final ActionProgress progress;

  @override
  List<Object?> get props => [id, status, progress];

  TodoToggleState copyWith({
    int? status,
    ActionProgress progress = ActionProgress.initial,
  }) {
    return TodoToggleState(
        id: id, status: status ?? this.status, progress: progress);
  }
}

class TodoToggleBloc extends Bloc<_TodoToggleEvent, TodoToggleState> {
  TodoToggleBloc({
    required TodoDetailRepository todoDetailRepository,
    required TodoItem todo,
  })  : _todoDetailRepository = todoDetailRepository,
        super(TodoToggleState(id: todo.id!, status: todo.status ?? 0)) {
    on<TodoToggleEvent>(_toggleTodoStatus);
  }

  final TodoDetailRepository _todoDetailRepository;

  Future<void> _toggleTodoStatus(
      TodoToggleEvent event, Emitter<TodoToggleState> emit) async {
    try {
      emit(state.copyWith(progress: ActionProgress.loading));

      final targetStatus = event.status == 0 ? 1 : 0;
      await _todoDetailRepository.toggleTodoStatus(
          todo: TodoItem(id: event.id, status: targetStatus, content: ''));
      emit(state.copyWith(
          status: targetStatus, progress: ActionProgress.success));
    } catch (err) {
      emit(state.copyWith(
          status: state.status, progress: ActionProgress.failure));
    }
  }
}
