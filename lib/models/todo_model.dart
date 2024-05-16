import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'todo_model.freezed.dart';
part 'todo_model.g.dart';

@immutable
@freezed
class TodoItem extends Equatable with _$TodoItem {
  const factory TodoItem({
    int? id,
    required String content,
    String? note,
    int? deleted,
    int? status,
  }) = _TodoItem;

  factory TodoItem.fromJson(Map<String, dynamic> json) =>
      _$TodoItemFromJson(json);

  @override
  List<Object?> get props => [id, content, note, deleted, status];
}
