import 'package:flutter_api_intgrate/model/todo.dart';
import 'package:flutter_api_intgrate/repository/repository.dart';

class TodoController {
  final Repository _repository;

  TodoController(this._repository);

  //get
  Future<List<Todo>> fetchTodoList() async {
    return _repository.getTodoList();
  }

  //patch
  Future<String> updataPatchComlpeted(Todo todo) {
    return _repository.patchCompleted(todo);
  }

  //put
  Future<String> updatePutcompleated(Todo todo) async {
    return _repository.putComponent(todo);
  }

  //delete
  Future<String> deleteCompleted(Todo todo) {
    return _repository.deleteComponent(todo);
  }

  //push
  Future<String> postTodo(Todo todo) async {
    return _repository.pushComponent(todo);
  }
}
