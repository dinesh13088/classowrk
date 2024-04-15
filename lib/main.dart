import 'package:classwork/dashboard.dart';
import 'package:classwork/listview_page.dart';
import 'package:classwork/login.dart';
import 'package:classwork/offers.dart';
import 'package:classwork/profile/profile.dart';
import 'package:classwork/profile/update_profile.dart';
import 'package:classwork/profile/userlist.dart';
import 'package:classwork/register.dart';
import 'package:classwork/utils/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
void main()async {
 WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options:DefaultFirebaseOptions.currentPlatform );
  runApp(MaterialApp(
    title: 'Flutter App!!',
    theme: ThemeData(
      colorSchemeSeed: Colors.indigo,
      useMaterial3: true,
      brightness: Brightness.light,
    ),
    darkTheme: ThemeData(
      colorSchemeSeed: Color.fromARGB(255, 37, 112, 173),
      useMaterial3: true,
      brightness: Brightness.dark,
    ),
    routes: {
      '/': (context) => Login(),
      '/register': (context) => Register(),
      '/login': (context) => Login(),
      '/dashboard': (context) => Dashboard(),
      '/myapp': (context) => MyApp(),
      '/update-profile': (context) => UpdateProfile(),
      '/users-list': (context) => UsersList(),
    },
    initialRoute: '/',
    debugShowCheckedModeBanner: false,
  ));
}



class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final pages = [
    Dashboard(),
    ListViewPage(),
    Offers(),
    Profile(),
  ];

  profile() => Profile();

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'ListView',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_offer),
            label: 'Offers',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        onTap: (index) {
          print('Selected Index $index');
          setState(() {
            _currentIndex = index;
          });
        },
        currentIndex: _currentIndex,
      ),
      body: pages.elementAt(_currentIndex),
    );
  }
}
