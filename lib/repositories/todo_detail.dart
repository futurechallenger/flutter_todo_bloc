import 'package:flutter_todo_bloc/models/todo_model.dart';
import 'package:flutter_todo_bloc/repositories/http_request.dart';

class TodoDetailRepository {
  Future<TodoItem?> toggleTodoStatus({required TodoItem todo}) async {
    HttpRequest request = HttpRequest();
    try {
      request.updateTodo(todo.id!, status: todo.status);
      return todo;
    } catch (err) {
      return null;
    }
  }
}
