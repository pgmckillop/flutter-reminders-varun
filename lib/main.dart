import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:reminders/models/todo_list/todo_list_collection.dart';
import 'package:reminders/screens/add_list/add_list_screen.dart';
import 'package:reminders/screens/auth/authenticate_screen.dart';
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
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(
            child: Text("There was an error"),
          );
        }

        if (snapshot.connectionState == ConnectionState.done) {
          return ChangeNotifierProvider<TodoListCollection>(
            create: (BuildContext context) => TodoListCollection(),
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              initialRoute: '/',
              routes: {
                '/': (context) => AuthenticateScreen(),
                '/home': (context) => HomeScreen(),
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
                elevatedButtonTheme: ElevatedButtonThemeData(
                  style: ElevatedButton.styleFrom(
                    shape: const StadiumBorder(),
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

        return CircularProgressIndicator();
      },
    );
  }
}
