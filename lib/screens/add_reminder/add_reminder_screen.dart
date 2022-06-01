import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reminders/common/widgets/category_icon.dart';
import 'package:reminders/models/todo_list/todo_list.dart';
import 'package:reminders/screens/add_reminder/select_reminder_list_screen.dart';

class AddReminderScreen extends StatefulWidget {
  const AddReminderScreen({Key? key}) : super(key: key);

  @override
  _AddReminderScreenState createState() => _AddReminderScreenState();
}

class _AddReminderScreenState extends State<AddReminderScreen> {
  final TextEditingController _titleTextController = TextEditingController();
  final TextEditingController _notesTextController = TextEditingController();

  String _title = '';
  //selected list will be the first list
  //TODO: SELECTED LIST
  // PULL IN ALL THE LISTS FROM THE PROVIDER
  // PASS DATA DOWN TO SEELCT LIST SCREEN
  TodoList? _selectedList;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _titleTextController.addListener(() {
      // print(textController.text);
      setState(() {
        _title = _titleTextController.text;
      });
    });
  }

  _updateSelectedList(TodoList todoList) {
    setState(() {
      _selectedList = todoList;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _titleTextController.dispose();
    _notesTextController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _todoLists = Provider.of<List<TodoList>>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('New Reminder'),
        actions: [
          TextButton(
            onPressed: _title.isEmpty
                ? null
                : () {
                    print('add to database');
                    _selectedList ??= _todoLists.first;
                    print(_selectedList!.title);
                  },
            child: const Text(
              'Add',
              style: TextStyle(
                  // color: _listName.isNotEmpty ? null : Colors.grey,
                  ),
            ),
          )
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Theme.of(context).cardColor),
              child: Column(
                children: [
                  TextField(
                    textCapitalization: TextCapitalization.sentences,
                    controller: _titleTextController,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Title',
                    ),
                  ),
                  const Divider(
                    height: 1,
                  ),
                  SizedBox(
                    height: 100,
                    child: TextField(
                      textCapitalization: TextCapitalization.sentences,
                      controller: _notesTextController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Notes',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Card(
                elevation: 0,
                margin: EdgeInsets.zero,
                child: ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SelectReminderListScreen(
                                selectedList: _selectedList != null
                                    ? _selectedList!
                                    : _todoLists.first,
                                todoLists: _todoLists,
                                selectListCallback: _updateSelectedList,
                              ),
                          fullscreenDialog: true),
                    );
                  },
                  leading: Text(
                    'List',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const CategoryIcon(
                          bgColor: Colors.blueAccent,
                          iconData: Icons.calendar_today),
                      const SizedBox(width: 10),
                      Text(_selectedList != null
                          ? _selectedList!.title
                          : _todoLists.first.title),
                      const Icon(Icons.arrow_forward_ios)
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Card(
                elevation: 0,
                margin: EdgeInsets.zero,
                child: ListTile(
                  onTap: () {},
                  leading: Text(
                    'Category',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      CategoryIcon(
                          bgColor: Colors.blueAccent,
                          iconData: Icons.calendar_today),
                      SizedBox(width: 10),
                      Text('Scheduled'),
                      Icon(Icons.arrow_forward_ios)
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
