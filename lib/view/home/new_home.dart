import 'package:flutter/material.dart';
import 'package:movie_app/view/profile/profile_main.dart';

import '../TV/tv_main_screen.dart';
import 'movies_screen.dart';

class NewHome extends StatefulWidget {
  const NewHome({Key? key}) : super(key: key);

  @override
  _NewHomeState createState() => _NewHomeState();
}

class _NewHomeState extends State<NewHome> {
  int selectedIndex = 0;
  List widgetRoutes = [
    const MoviesPage(),
    const MainTVScreen(),
    const ProfileMain(),
  ];

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        elevation: 10,
        selectedItemColor: const Color(0xFFF96C00),
        currentIndex: selectedIndex, //New
        onTap: onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.movie,
              size: 30,
            ),
            label: 'MOVIES',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.tv,
              size: 30,
            ),
            label: 'TV',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.perm_identity,
              size: 30,
            ),
            label: 'PROFILE',
          ),
        ],
      ),
      body: widgetRoutes.elementAt(selectedIndex),
    );
  }
}
