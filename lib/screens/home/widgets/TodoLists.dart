import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reminders/models/todo_list/todo_list.dart';
import '../../../common/widgets/category_icon.dart';
import '../../../common/widgets/dismissible_background.dart';
import '../../../models/common/custom_color_collection.dart';
import '../../../models/common/custom_icon_collection.dart';
import '../../view_list/view_list_screen.dart';
import '../../../services/database_service.dart';
import '../../../common/helpers/helpers.dart' as helpers;

class TodoLists extends StatelessWidget {
  const TodoLists({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final todoLists = Provider.of<List<TodoList>>(context);
    final user = Provider.of<User?>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.all(10),
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
          const SizedBox(height: 10),
          Container(
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: todoLists.length,
                itemBuilder: (context, index) {
                  return Dismissible(
                    onDismissed: (direction) async {
                      //delete the todo
                      // deleteTodoList(todoLists[index]);
                      // Provider.of<TodoListCollection>(context, listen: false)
                      //     .removeTodoList(todoLists[index]);

                      try {
                        await DatabaseService(uid: user!.uid)
                            .deleteTodoList(todoLists[index]);
                        helpers.showSnackBar(context, 'List deleted');
                      } catch (e) {
                        //show the error.
                        helpers.showSnackBar(context, 'Unable to delete List');
                      }
                    },
                    direction: DismissDirection.endToStart,
                    key: UniqueKey(),
                    background: DismissibleBackground(),
                    child: Card(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                      elevation: 0,
                      margin: EdgeInsets.zero,
                      child: ListTile(
                        onTap: todoLists[index].reminderCount > 0
                            ? () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ViewListScreen(
                                        todoList: todoLists[index]),
                                  ),
                                );
                              }
                            : null,
                        leading: CategoryIcon(
                            bgColor: (CustomColorCollection()
                                .findColorById(todoLists[index].icon['color'])
                                .color),
                            iconData: (CustomIconCollection()
                                .findIconById(todoLists[index].icon['id'])
                                .icon)),
                        title: Text(todoLists[index].title),
                        trailing: Text(
                            todoLists[index].reminderCount.toString(),
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2!
                                .copyWith(fontWeight: FontWeight.bold)),
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
