import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../common/helpers/helpers.dart' as helpers;
import '../../models/category/category.dart';
import '../../models/reminder/reminder.dart';
import '../../models/todo_list/todo_list.dart';

class ViewListByCategoryScreen extends StatelessWidget {
  final Category category;

  const ViewListByCategoryScreen({Key? key, required this.category})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final allReminders = Provider.of<List<Reminder>>(context);
    final remindersForCategory = allReminders
        .where((reminder) =>
            reminder.categoryId == category.id || category.id == 'all')
        .toList();
    return Scaffold(
      appBar: AppBar(
        title: Text(category.id),
      ),
      body: ListView.builder(
          itemCount: remindersForCategory.length,
          itemBuilder: (context, index) {
            final reminder = remindersForCategory[index];
            return Dismissible(
              key: UniqueKey(),
              direction: DismissDirection.endToStart,
              onDismissed: (direction) async {
                final user = Provider.of<User?>(context, listen: false);
                final todoLists =
                    Provider.of<List<TodoList>>(context, listen: false);
                final todoListForReminder = todoLists.firstWhere(
                    (todoList) => todoList.id == reminder.list['id']);

                WriteBatch batch = FirebaseFirestore.instance.batch();

                final remindersref = FirebaseFirestore.instance
                    .collection('users')
                    .doc(user?.uid)
                    .collection('reminders')
                    .doc(reminder.id);

                final listRef = FirebaseFirestore.instance
                    .collection('users')
                    .doc(user?.uid)
                    .collection('todo_lists')
                    .doc(reminder.list['id']);

                batch.delete(remindersref);
                batch.update(listRef,
                    {'reminder_count': todoListForReminder.reminderCount - 1});

                try {
                  await batch.commit();
                } catch (e) {
                  print(e);
                }
              },
              child: Card(
                child: ListTile(
                  title: Text(reminder.title),
                  subtitle:
                      reminder.notes != null ? Text(reminder.notes!) : null,
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        helpers.formatDate(reminder.dueDate),
                      ),
                      Text(
                        helpers.formatTime(
                          context,
                          reminder.dueTime['hour'],
                          reminder.dueTime['minute'],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
