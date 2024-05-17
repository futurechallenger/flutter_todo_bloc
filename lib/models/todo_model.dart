import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:json_annotation/json_annotation.dart';

part 'todo_model.g.dart';

@immutable
@JsonSerializable()
class TodoItem extends Equatable {
  const TodoItem({
    this.id,
    required this.content,
    this.note,
    this.deleted,
    this.status,
  });

  final int? id;
  final String? content;
  final String? note;
  final int? deleted;
  final int? status;

  static fromJson(Map<String, dynamic> json) => _$TodoItemFromJson(json);
  Map<String, dynamic> toJson() => _$TodoItemToJson(this);

  @override
  List<Object?> get props => [id, content, note, deleted, status];
}
