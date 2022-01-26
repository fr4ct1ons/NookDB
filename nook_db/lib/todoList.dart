import 'package:flutter/material.dart';

class TodoList extends StatefulWidget {
  const TodoList({Key? key}) : super(key: key);

  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  @override
  List<String> items = [];
  List<bool> itemStatus = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    items = [
      'Check turnip prices',
      'Water crops',
      'Dig money rock',
    ];

    itemStatus = List<bool>.filled(items.length, false);
  }

  Widget build(BuildContext context) {
    return Container(
      color: Colors.orange.shade50,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            const Text(
              "To-do",
              style: TextStyle(fontSize: 24.0),
            ),
            Container(
              height: 140,
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return _drawTodoItem(index);
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _drawTodoItem(int i) {
    return CheckboxListTile(
      controlAffinity: ListTileControlAffinity.leading,
      value: itemStatus[i],
      onChanged: (value) {
        setState(() {
          itemStatus[i] = value!;
        });
      },
      title: Text(items[i]),
    );
  }
}
