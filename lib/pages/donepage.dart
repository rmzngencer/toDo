
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:todo/dbServices/task_service.dart';
import 'package:todo/models/tasks.dart';

class DonePage  extends HookWidget {
  final TaskService _taskService = TaskService.instance;

  DonePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      
      body:  FutureBuilder(
        future: _taskService.getDoneTasks(),
        builder: (BuildContext context, AsyncSnapshot<List<Tasks>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("An error occurred: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("Your contact list is empty"));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, int index) {
                Tasks task = snapshot.data![index];
                return GestureDetector(
                  onTap: () {},
                  child: Dismissible(
                    key: UniqueKey(),
                    background: Container(
                      alignment: Alignment.centerLeft,
                      color: Color.fromARGB(255, 150, 150, 36),
                      child: const Padding(
                        padding: EdgeInsets.all(20),
                        child: Icon(
                          Icons.settings_backup_restore_sharp,
                          color: Color.fromARGB(255, 255, 255, 255),
                        ),
                      ),
                    ),
                    secondaryBackground: Container(
                      alignment: Alignment.centerRight,
                      color: Colors.red,
                      child: const Padding(
                        padding: EdgeInsets.all(20),
                        child: Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    onDismissed: (direction) async {
                      if (direction == DismissDirection.startToEnd) {
                        _taskService.updateTask(task.id, 0);
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content:
                              Text("${task.title} Tasklara eklendi"),
                        ));
                      } else {
                        _taskService.deleteTask(task.id);
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("${task.id} silindi"),
                        ));
                      }
                    },
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: ListTile(
                        leading: const CircleAvatar(
                          child: Text(
                            '>',
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                        ),
                        title: Text(task.title),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              task.text,
                            ),
                            Text("${task.data} - ${task.dueto}"),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}