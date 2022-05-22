import 'package:flutter/material.dart';
import 'package:reminders/models/todo_list/todo_list_collection.dart';
import 'package:reminders/screens/add_list/add_list_screen.dart';
import 'package:reminders/screens/home/home_screen.dart';
import 'package:reminders/screens/add_reminder/add_reminder_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    const App(),
  );
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TodoListCollection>(
      create: (BuildContext context) => TodoListCollection(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => HomeScreen(),
          '/addList': (context) => const AddListScreen(),
          '/addReminder': (context) => const AddReminderScreen(),
        },
        theme: ThemeData(
          brightness: Brightness.dark,
          scaffoldBackgroundColor: Colors.black,
          appBarTheme: const AppBarTheme(
            color: Colors.black,
            toolbarTextStyle: TextStyle(
              color: Colors.white,
            ),
            titleTextStyle: TextStyle(
              color: Colors.white,
            ),
            iconTheme: IconThemeData(
              color: Colors.white,
            ),
          ),
          iconTheme: const IconThemeData(color: Colors.white),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              primary: Colors.blueAccent,
              textStyle: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          dividerColor: Colors.grey[600],
          colorScheme: ColorScheme.fromSwatch().copyWith(
            brightness: Brightness.dark,
            secondary: Colors.white,
          ),
        ),
      ),
    );
  }
}
