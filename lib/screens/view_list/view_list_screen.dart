import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../common/helpers/helpers.dart' as helpers;
import '../../models/reminder/reminder.dart';
import '../../models/todo_list/todo_list.dart';

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
            return Card(
              child: ListTile(
                title: Text(reminder.title),
                subtitle: reminder.notes != null ? Text(reminder.notes!) : null,
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
            );
          }),
    );
  }
}
