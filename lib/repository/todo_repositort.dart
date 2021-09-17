import 'dart:convert';

import 'package:flutter_api_intgrate/model/todo.dart';
import 'package:flutter_api_intgrate/repository/repository.dart';
import 'package:http/http.dart' as http;

class TodoRepository implements Repository {
  String dataUrl = "https://jsonplaceholder.typicode.com";

  @override
  Future<String> pushComponent(Todo todo) async {
    print('${todo.toJson()}');
    var url = Uri.parse('$dataUrl/todos/');
    var result = '';
    var responce = await http.post(url, body: todo.toJson());
    print(responce.statusCode);
    return 'true';
  }

  @override
  Future<String> deleteComponent(Todo todo) async {
    var url = Uri.parse('$dataUrl/todos/${todo.id}');
    var result = 'false';
    await http.delete(url).then((value) {
      print(value.body);
      return result = 'true';
    });
    return result;
  }

  @override
  Future<List<Todo>> getTodoList() async {
    List<Todo> todoList = [];
    var url = Uri.parse('$dataUrl/todos');
    var responses = await http.get(url);
    // ignore: avoid_print
    print(responses.statusCode);
    var body = json.decode(responses.body);
    for (var i = 0; i < body.length; i++) {
      todoList.add(Todo.fromJson(body[i]));
    }
    return todoList;
  }

  @override
  Future<String> patchCompleted(Todo todo) async {
    var url = Uri.parse('$dataUrl/todos/${todo.id}');
    String resData = '';
    await http.patch(url,
        body: {'completed': (!todo.completed!).toString()},
        headers: {'Authorization': 'your_token'}).then((response) {
      Map<String, dynamic> result = json.decode(response.body);

      return resData = result['completed'];
    });

    return resData;
  }

  @override
  Future<String> putComponent(Todo todo) async {
    var url = Uri.parse('$dataUrl/todos/${todo.id}');
    String resData = '';
    await http.put(url,
        body: {'completed': (!todo.completed!).toString()},
        headers: {'Authorization': 'your_token'}).then((value) {
      Map<String, dynamic> result = json.decode(value.body);
      print(result);
      return resData = result['completed'];
    });

    return resData;
  }
}
