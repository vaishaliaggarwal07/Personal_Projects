import 'package:flutter/material.dart';

class TodoApp extends StatefulWidget {
  @override
  _TodoAppState createState() => _TodoAppState();
}

class _TodoAppState extends State<TodoApp> {
  List<String> todos = [];

  TextEditingController controller = TextEditingController();

  void addTodo() {
    setState(() {
      String newTodo = controller.text;
      if (newTodo.isNotEmpty) {
        todos.add(newTodo);
        controller.clear();
      }
    });
  }

  void removeTodoAtIndex(int index) {
    setState(() {
      todos.removeAt(index);
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(40),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top:50),
              child: Text('ADD TASK',style: TextStyle(fontFamily: 'Bebas',fontSize: 50,color: Colors.red,letterSpacing: 4),)),
            SizedBox(
              height: 100,
            ),
            TextField(
              controller: controller,
              decoration: InputDecoration(
                labelText: 'Add task',labelStyle: TextStyle(
                  fontFamily: 'Roboto',color: Colors.black
                )
              ),
              onSubmitted: (_) => addTodo(),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: todos.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(todos[index]),
                    trailing: IconButton(
                      icon: Icon(Icons.delete,
                      color: Colors.red,),
                      onPressed: () => removeTodoAtIndex(index),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
