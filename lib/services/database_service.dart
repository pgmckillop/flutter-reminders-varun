import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reminders/models/todo_list/todo_list.dart';

import '../models/reminder/reminder.dart';

class DatabaseService {
  final String uid;
  final FirebaseFirestore _database;
  final DocumentReference _userRef;

  DatabaseService({required this.uid})
      : _database = FirebaseFirestore.instance,
        _userRef = FirebaseFirestore.instance.collection('users').doc(uid);

  Stream<List<TodoList>> todoListStream() {
    return _userRef
        .collection('todo_lists')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map(
              (todoListSnapshot) => TodoList.fromJson(
                todoListSnapshot.data(),
              ),
            )
            .toList());
  }

  Stream<List<Reminder>> remindersStream() {
    return _userRef.collection('reminders').snapshots().map(
          (snapshot) => snapshot.docs
              .map(
                (reminderSnapshot) => Reminder.fromJson(
                  reminderSnapshot.data(),
                ),
              )
              .toList(),
        );
  }

  addTodoList({required TodoList todoList}) async {
    //todoListRef
    //new todo
    //add the todoList
    //throw the error
    final todoListRef =
        _userRef.collection('todo_lists').doc(); //id of the list

    todoList.id = todoListRef.id;

    try {
      await todoListRef.set(
        todoList.toJson(),
      );
      print('list added');
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
