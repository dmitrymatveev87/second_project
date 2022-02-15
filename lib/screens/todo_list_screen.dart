import 'dart:async';
import 'dart:convert';

import 'package:second_project/model/todo.dart';
import 'package:second_project/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<List<Todo>> _fetchTodosList() async {
  final response = await http.get(Uri.parse(URL_GET_TODOS_LIST));

  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((todo) => Todo.fromJson(todo)).toList();
  } else {
    throw Exception('Failed to load todos from API');
  }
}

ListView _todosListView(data) {
  return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        return _todoListTile(data[index].name, data[index].email, Icons.work);
      });
}

ListTile _todoListTile(String title, String subtitle, IconData icon) => ListTile(
  title: Text(title,
      style: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 20,
      )),
  subtitle: Text(subtitle),
  leading: Icon(
    icon,
    color: Colors.blue[500],
  ),
);

class TodosListScreen extends StatefulWidget {
  const TodosListScreen({Key? key}) : super(key: key);

  @override
  _TodosListScreenState createState() => _TodosListScreenState();
}

class _TodosListScreenState extends State<TodosListScreen> {
  late Future<List<Todo>> futureTodosList;
  late List<Todo> todoListData;

  @override
  void initState() {
    super.initState();
    futureTodosList = _fetchTodosList();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: FutureBuilder<List<Todo>>(
            future: futureTodosList,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                todoListData = snapshot.data!;
                return _todosListView(todoListData);
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              return const CircularProgressIndicator();
            })
    );
  }
}