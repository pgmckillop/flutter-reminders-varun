import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:reminders/models/todo_list/todo_list_collection.dart';
import 'package:reminders/screens/add_list/add_list_screen.dart';
import 'package:reminders/screens/home/home_screen.dart';
import 'package:reminders/screens/add_reminder/add_reminder_screen.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    const App(),
  );
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  bool _initialized = false;
  bool _error = false;

  initializeFirebase() async {
    try {
      await Firebase.initializeApp();
      setState(() {
        _initialized = true;
        print('Firebase initialized');
      });
    } catch (e) {
      setState(() {
        _error = true;
      });
    }

    // Firebase.initializeApp().then(
    //   (value) {
    //     setState(() {
    //       _initialized = true;
    //       //print('Initialized');
    //     });
    //   },
    // ).catchError((e) {
    //   setState(() {
    //     _error = true;
    //   });
    // });
  }

  @override
  void initState() {
    super.initState();
    initializeFirebase();
  }

  @override
  Widget build(BuildContext context) {
    if (_error) {
      return Center(
        child: Text('There was an error'),
      );
    }

    if (!_initialized) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    return ChangeNotifierProvider<TodoListCollection>(
      create: (BuildContext context) => TodoListCollection(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => HomeScreen(),
          '/addList': (context) => const AddListScreen(),
          '/addReminder': (context) => const AddReminderScreen(),
        },
        theme: ThemeData(
          brightness: Brightness.dark,
          scaffoldBackgroundColor: Colors.black,
          appBarTheme: const AppBarTheme(
            color: Colors.black,
            toolbarTextStyle: TextStyle(
              color: Colors.white,
            ),
            titleTextStyle: TextStyle(
              color: Colors.white,
            ),
            iconTheme: IconThemeData(
              color: Colors.white,
            ),
          ),
          iconTheme: const IconThemeData(color: Colors.white),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              primary: Colors.blueAccent,
              textStyle: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          dividerColor: Colors.grey[600],
          colorScheme: ColorScheme.fromSwatch().copyWith(
            brightness: Brightness.dark,
            secondary: Colors.white,
          ),
        ),
      ),
    );
  }
}
