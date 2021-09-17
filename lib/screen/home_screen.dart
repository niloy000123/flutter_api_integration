import 'package:flutter/material.dart';
import 'package:flutter_api_intgrate/controller/todo_controller.dart';
import 'package:flutter_api_intgrate/model/todo.dart';
import 'package:flutter_api_intgrate/repository/todo_repositort.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var todoController = TodoController(TodoRepository());

    return Scaffold(
      appBar: AppBar(
        title: const Text("Rest Api"),
      ),
      body: FutureBuilder<List<Todo>>(
        future: todoController.fetchTodoList(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text('Error'),
            );
          }
          return buildBodyContent(snapshot, todoController);
        },
      ),
      floatingActionButton: FloatingActionButton(
        hoverColor: Colors.orange,
        onPressed: () {
          Todo todo = new Todo(userId: 3, title: 'new_post', completed: false);
          todoController.postTodo(todo);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  ListView buildBodyContent(
      AsyncSnapshot<List<Todo>> snapshot, TodoController todoController) {
    return ListView.separated(
        itemBuilder: (context, index) {
          var todo = snapshot.data?[index];
          return Container(
            height: 100,
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Expanded(flex: 1, child: Text('${todo?.id}')),
                Expanded(flex: 3, child: Text('${todo?.title}')),
                Expanded(
                    flex: 3,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        //patch updateing
                        InkWell(
                            onTap: () {
                              todoController
                                  .updataPatchComlpeted(todo!)
                                  .then((value) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('$value')));
                              });
                            },
                            child:
                                cellContainer('Patch', Colors.orange.shade100)),

                        //put updateing
                        InkWell(
                            onTap: () {
                              todoController.updatePutcompleated(todo!);
                            },
                            child:
                                cellContainer('put', Colors.purple.shade100)),
                        //delete
                        InkWell(
                            onTap: () {
                              todoController.deleteCompleted(todo!);
                            },
                            child: cellContainer('Del', Colors.red.shade100))
                      ],
                    ))
              ],
            ),
          );
        },
        separatorBuilder: (context, index) {
          // ignore: prefer_const_constructors
          return Divider(
            thickness: .5,
            height: .5,
          );
        },
        itemCount: snapshot.data?.length ?? 0);
  }

  Container cellContainer(String title, Color color) {
    return Container(
      width: 40,
      height: 40,
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(10)),
      child: Center(child: Text(title)),
    );
  }
}
