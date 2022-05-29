import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/todo_list/todo_list_collection.dart';
import 'add_list/add_list_screen.dart';
import 'add_reminder/add_reminder_screen.dart';
import 'auth/authenticate_screen.dart';
import 'home/home_screen.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);

    return ChangeNotifierProvider<TodoListCollection>(
      create: (BuildContext context) => TodoListCollection(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        // initialRoute: '/',
        routes: {
          // '/': (context) => const AuthenticateScreen(),
          '/home': (context) => HomeScreen(),
          '/addList': (context) => const AddListScreen(),
          '/addReminder': (context) => const AddReminderScreen(),
        },
        home: user != null ? HomeScreen() : AuthenticateScreen(),
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
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              shape: const StadiumBorder(),
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
