import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../common/helpers/helpers.dart' as helpers;
import '../../models/reminder/reminder.dart';
import '../../models/todo_list/todo_list.dart';
import '../../../common/widgets/dismissible_background.dart';

class ViewListScreen extends StatelessWidget {
  final TodoList todoList;

  const ViewListScreen({Key? key, required this.todoList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final allReminders = Provider.of<List<Reminder>>(context);
    final remindersForList = allReminders
        .where((reminder) => reminder.list['id'] == todoList.id)
        .toList();
    return Scaffold(
      appBar: AppBar(
        title: Text(todoList.title),
      ),
      body: ListView.builder(
          itemCount: remindersForList.length,
          itemBuilder: (context, index) {
            final reminder = remindersForList[index];
            return Dismissible(
              key: UniqueKey(),
              direction: DismissDirection.endToStart,
              background: DismissibleBackground(),
              onDismissed: (direction) async {
                final user = Provider.of<User?>(context, listen: false);

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
                batch.update(
                    listRef, {'reminder_count': todoList.reminderCount - 1});

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
