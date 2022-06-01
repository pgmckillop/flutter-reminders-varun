import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/reminder/reminder.dart';
import '../models/todo_list/todo_list.dart';
import '../models/todo_list/todo_list_collection.dart';
import 'add_list/add_list_screen.dart';
import 'add_reminder/add_reminder_screen.dart';
import 'auth/authenticate_screen.dart';
import 'home/home_screen.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    final todoListStream = FirebaseFirestore.instance
        .collection('users')
        .doc(user?.uid)
        .collection('todo_lists')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map(
              (todoListSnapshot) => TodoList.fromJson(
                todoListSnapshot.data(),
              ),
            )
            .toList());

    final remindersStream = FirebaseFirestore.instance
        .collection('users')
        .doc(user?.uid)
        .collection('reminders')
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map(
                (reminderSnapshot) => Reminder.fromJson(
                  reminderSnapshot.data(),
                ),
              )
              .toList(),
        );

    return MultiProvider(
      providers: [
        StreamProvider<List<TodoList>>.value(
            initialData: [], value: todoListStream),
        StreamProvider<List<Reminder>>.value(
            value: remindersStream, initialData: [])
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        // initialRoute: '/',
        routes: {
          // '/': (context) => AuthenticateScreen(),
          'home': (context) => HomeScreen(),
          'addList': (context) => AddListScreen(),
          'addReminder': (context) => AddReminderScreen()
        },
        home: user != null ? HomeScreen() : AuthenticateScreen(),
        theme: ThemeData(
            brightness: Brightness.dark,
            scaffoldBackgroundColor: Colors.black,
            appBarTheme: AppBarTheme(backgroundColor: Colors.black),
            iconTheme: IconThemeData(color: Colors.white),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                primary: Colors.blueAccent,
                textStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                shape: StadiumBorder(),
              ),
            ),
            dividerColor: Colors.grey[600]),
      ),
    );
  }
}
