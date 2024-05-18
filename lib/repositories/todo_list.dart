import 'package:flutter_todo_bloc/models/todo_model.dart';
import 'package:flutter_todo_bloc/repositories/http_request.dart';

class TodoListRepository {
  Future<List<TodoItem>?> fetchTodoList({
    bool all = false,
    String completed = 'completed',
  }) async {
    HttpRequest request = HttpRequest();
    return request.fetchTodoList(all: all, completed: completed);
  }
}
