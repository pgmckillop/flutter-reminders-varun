import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reminders/models/todo_list/todo_list.dart';
import 'package:reminders/models/todo_list/todo_list_collection.dart';

import '../../../common/widgets/category_icon.dart';
import '../../../models/common/custom_color_collection.dart';
import '../../../models/common/custom_icon_collection.dart';

class TodoLists extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final todoLists = Provider.of<List<TodoList>>(context);
    final user = Provider.of<User?>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'My Lists',
            style: Theme.of(context)
                .textTheme
                .headline6!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 10.0,
          ),
          Container(
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: todoLists.length,
                itemBuilder: (context, index) {
                  return Dismissible(
                    onDismissed: (direction) async {
                      // Delete the todo
                      //deleteTodoList(todoLists[index]);
                      // Provider.of<TodoListCollection>(context, listen: false)
                      //     .removeTodoList(todoLists[index]);
                      final todoListRef = FirebaseFirestore.instance
                          .collection('users')
                          .doc(user?.uid)
                          .collection('todo_lists')
                          .doc(todoLists[index].id);
                      try {
                        await todoListRef.delete();
                        print('Deleted');
                      } catch (e) {
                        print(e);
                      }
                    },
                    direction: DismissDirection.endToStart,
                    key: UniqueKey(),
                    background: Container(
                      alignment: AlignmentDirectional.centerEnd,
                      color: Colors.red,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                        child: Icon(Icons.delete),
                      ),
                    ),
                    child: Card(
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero),
                        elevation: 0,
                        margin: EdgeInsets.zero,
                        child: ListTile(
                          leading: CategoryIcon(
                            bgColor: (CustomColorCollection()
                                .findColorById(todoLists[index].icon['color'])
                                .color),
                            iconData: (CustomIconCollection()
                                .findIconById(todoLists[index].icon['id'])
                                .icon),
                          ),
                          title: Text(todoLists[index].title),
                          trailing: Text(
                            '0',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                        )),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
