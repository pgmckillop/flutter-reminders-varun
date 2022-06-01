import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:reminders/screens/home/widgets/TodoLists.dart';
import 'package:reminders/screens/home/widgets/footer.dart';
import 'package:reminders/screens/home/widgets/grid_view_items.dart';
import 'package:reminders/screens/home/widgets/list_view_items.dart';
import '../../models/category/category_collection.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  CategoryCollection categoryCollection = CategoryCollection();

  String layoutType = 'grid';

  @override
  Widget build(BuildContext context) {
    //var todoLists = Provider.of<TodoListCollection>(context).todoLists;
    // return StreamBuilder<User?>(
    //     stream: FirebaseAuth.instance.authStateChanges(),
    //     builder: (context, snapshot) {
    //       if (snapshot.hasData) {
    return Scaffold(
      appBar: AppBar(actions: [
        IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
            icon: const Icon(Icons.logout)),
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
            const Expanded(
              child: TodoLists(),
            ),
            const Footer()
          ],
        ),
      ),
    );
  }
}
