import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo/pages/addTasks.dart';
import 'package:todo/pages/homePage.dart';
import 'package:todo/pages/login.dart';
import 'package:todo/pages/profilepage.dart';


final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();

final GoRouter router = GoRouter(
  initialLocation: '/login',
  navigatorKey: _rootNavigatorKey,
  routes: [
    GoRoute(
      path: '/login',
      name: 'login',
      builder: (context, state) => const LoginPage(title: "loginpage",),
    ),
   GoRoute(
      path: '/addTasks',
      name: 'addTasks',
      builder: (context, state) => AddTasks(title: "addtask",),
    ),
    ShellRoute(
      navigatorKey:GlobalKey<NavigatorState>(),
      builder: (context, state, child) {
        return ScaffoldWithNavBar(child: child);
      },
      routes: [
        GoRoute(
          path: '/',
          name: 'home',
          builder: (context, state) => const MyHomePage(title: 'Home Page'),
        ),
        GoRoute(
          path: '/profile',
          name: 'profile',
          builder: (context, state) => ProfilePage(title: 'Profile Page'),
        ),
      ],
    ),
  ],
);





class ScaffoldWithNavBar extends StatelessWidget {
  final Widget child;
  const ScaffoldWithNavBar({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _calculateSelectedIndex(context),
        onTap: (index) {
          switch (index) {
            case 0:
              context.go('/');
              break;
            case 1:
              context.go('/profile');
              break;
            case 2:
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  int _calculateSelectedIndex(BuildContext context) {
  
    final location = router.routerDelegate.currentConfiguration.uri.toString();
  
    if (location.startsWith('/profile')) {
      return 1;
    }
    return 0;
  }
}

