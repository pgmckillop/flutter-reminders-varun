import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:reminders/common/widgets/category_icon.dart';
import 'package:reminders/models/common/custom_color_collection.dart';
import 'package:reminders/models/common/custom_icon_collection.dart';
import 'package:reminders/models/todo_list/todo_list.dart';
//import 'package:reminders/common/widgets/category_icon.dart';
//import 'package:reminders/models/category.dart';
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

  addNewList(TodoList list) {
    print('add list from homescreen');
    print(list.title);
    Provider.of<TodoListCollection>(context, listen: false).addTodoList(list);
    // setState(() {
    //   todoLists.add(list);
    // });
  }

  @override
  Widget build(BuildContext context) {
    var todoLists = Provider.of<TodoListCollection>(context).todoLists;
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
            style: TextStyle(color: Colors.white),
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
                duration: Duration(milliseconds: 300),
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
                child: Padding(
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
                              return Card(
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.zero),
                                  elevation: 0,
                                  margin: EdgeInsets.zero,
                                  child: ListTile(
                                    leading: CategoryIcon(
                                      bgColor: (CustomColorCollection()
                                          .findColorById(
                                              todoLists[index].icon['color'])
                                          .color),
                                      iconData: (CustomIconCollection()
                                          .findIconById(
                                              todoLists[index].icon['id'])
                                          .icon),
                                    ),
                                    title: Text(todoLists[index].title),
                                    trailing: Text(
                                      '0',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText2!
                                          .copyWith(
                                              fontWeight: FontWeight.bold),
                                    ),
                                  ));
                            }),
                      ),
                    ],
                  ),
                ),
              ),
              Footer(addNewListCallback: addNewList)
            ],
          )),
    );
  }
}
