import 'package:second_project/screens/users_list_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Users list',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Список пользователей'),
        ),
        body: Center(
            child: UsersListScreen()
        ),
      ),
    );
  }
}
