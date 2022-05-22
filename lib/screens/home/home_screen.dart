import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:reminders/common/widgets/category_icon.dart';
import 'package:reminders/models/common/custom_color_collection.dart';
import 'package:reminders/models/common/custom_icon_collection.dart';
import 'package:reminders/models/todo_list/todo_list.dart';
import 'package:reminders/screens/home/widgets/TodoLists.dart';
import 'package:reminders/screens/home/widgets/footer.dart';
import 'package:reminders/screens/home/widgets/grid_view_items.dart';
import 'package:reminders/screens/home/widgets/list_view_items.dart';
import '../../models/category/category_collection.dart';
import '../../models/todo_list/todo_list_collection.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  CategoryCollection categoryCollection = CategoryCollection();

  String layoutType = 'grid';

  //List<TodoList> todoLists = [];

  // addNewList(TodoList list) {
  //   //print('add list from homescreen');
  //   //print(list.title);
  //   Provider.of<TodoListCollection>(context, listen: false).addTodoList(list);
  //   // setState(() {
  //   //   todoLists.add(list);
  //   // });
  // }

  // deleteTodoList(TodoList list) {
  //   Provider.of<TodoListCollection>(context, listen: false)
  //       .removeTodoList(list);
  // }

  @override
  Widget build(BuildContext context) {
    //var todoLists = Provider.of<TodoListCollection>(context).todoLists;
    return Scaffold(
      appBar: AppBar(actions: [
        TextButton(
          onPressed: () {
            if (layoutType == 'grid') {
              setState(() {
                layoutType = 'list';
              });
            } else {
              setState(() {
                layoutType = 'grid';
              });
            }
          },
          child: Text(
            layoutType == 'grid' ? 'Edit' : 'Done',
            style: const TextStyle(color: Colors.white),
          ),
        )
      ]),
      body: Container(
          color: Colors.black,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AnimatedCrossFade(
                duration: const Duration(milliseconds: 300),
                crossFadeState: layoutType == 'grid'
                    ? CrossFadeState.showFirst
                    : CrossFadeState.showSecond,
                firstChild: GridViewItems(
                  categories: categoryCollection.selectedCategories,
                ),
                secondChild:
                    ListViewItems(categoryCollection: categoryCollection),
              ),
              Expanded(
                child: TodoLists(),
              ),
              Footer()
            ],
          )),
    );
  }
}
