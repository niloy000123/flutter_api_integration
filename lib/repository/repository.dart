//https://jsonplaceholder.typicode.com/todos

import 'package:flutter_api_intgrate/model/todo.dart';

abstract class Repository {
  Future<List<Todo>> getTodoList();
  Future<String> patchCompleted(Todo todo);
  Future<String> putComponent(Todo todo);
  Future<String> deleteComponent(Todo todo);
  Future<String> pushComponent(Todo todo);
}
