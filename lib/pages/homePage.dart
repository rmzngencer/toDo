import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:todo/pages/donepage.dart';
import 'package:todo/pages/taskPage.dart';


class MyHomePage extends HookWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    final homeTabs = <Tab>[
      const Tab(
        child: Text('yapılacaklar'),
      ),
      const Tab(child: Text('yapıldı'))
    ];

    final tabController = useTabController(initialLength: homeTabs.length);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(title),
          bottom: TabBar(
            tabs: homeTabs,
            controller: tabController,
          ),
        ),
        body: TabBarView(
          controller: tabController,
          children: [
          TaskPage(title: 'task',),
          DonePage(title: 'done',),
          
        ],
        
      ),
     

    );
  }
}
