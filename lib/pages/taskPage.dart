import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:todo/dbServices/task_service.dart';
import 'package:todo/models/tasks.dart';

class TaskPage extends HookWidget {
  final TaskService _taskService = TaskService.instance;

  TaskPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          GoRouter.of(context).goNamed('addTasks');
        },
        child: Icon(Icons.add),
      ),
      body: FutureBuilder(
        future: _taskService.getNotDoneTasks(),
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
                      color: Color.fromARGB(255, 6, 153, 25),
                      child: const Padding(
                        padding: EdgeInsets.all(20),
                        child: Icon(
                          Icons.done_all_rounded,
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
                        _taskService.updateTask(task.id, 1);
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content:
                              Text("${task.title} yapıldı olarak işaretlendi"),
                        ));
                      } else {
                        _taskService.deleteTask(task.id);
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("${task.title} silindi"),
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
