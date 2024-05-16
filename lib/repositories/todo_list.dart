import 'package:flutter_todo_bloc/models/todo_model.dart';
import 'package:flutter_todo_bloc/repositories/http_request.dart';

class TodoListRepository {
  /*
  Future<List<TodoItem>?> fetchTodoList({
    bool all = false,
    String completed = 'completed',
  }) async {
    final host = all == true ? "$hostUrl/list/all" : "$hostUrl/list/$completed";
    final response = await _client.get(Uri.parse(host));

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body) as Map<String, dynamic>;
      if (body['message'] != 'ok') {
        return null;
      }

      final data = body['data'] as List<dynamic>;
      final List<TodoItem> todoItemList = [];
      for (var e in data) {
        todoItemList.add(TodoItem.fromJson(e));
      }

      return todoItemList;
    } else {
      return null;
    }
  }
  */
  Future<List<TodoItem>?> fetchTodoList({
    bool all = false,
    String completed = 'completed',
  }) async {
    HttpRequest request = HttpRequest();
    return request.fetchTodoList(all: all, completed: completed);
  }
}
