import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:todo/dbServices/task_service.dart';

class AddTasks extends HookWidget {
  AddTasks({super.key, required this.title});

  final String title;
  final TaskService _taskService = TaskService.instance;

  @override
  Widget build(BuildContext context) {
    final titleController = useTextEditingController();
    final textController = useTextEditingController();
    DateTime? selectedDate;

    Future<void> _selectDate(BuildContext context) async {
      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime(2101),
      );
      if (picked != null && picked != selectedDate) {
        selectedDate = picked;
        print('Selected date: $selectedDate');
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            GoRouter.of(context).goNamed('home');
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Başlık'),
            ),
            TextField(
              controller: textController,
              decoration: const InputDecoration(labelText: 'Açıklama'),
            ),
            const SizedBox(height: 20.0),
            GestureDetector(
              onTap: () => _selectDate(context),
              child: AbsorbPointer(
                child: TextField(
                  decoration: const InputDecoration(
                    labelText: 'Date',
                    suffixIcon: Icon(Icons.calendar_today),
                  ),
                  controller: TextEditingController(
                    text: selectedDate != null
                        ? '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}'
                        : 'tarih şeçiniz',
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                final title = titleController.text;
                final text = textController.text;
                final Date ='${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}';
                // Seçili tarihi kullanarak işlemler yapabilirsiniz
                print('Name: $title, Açıklama: $text,  Date: $Date');
                if (title.isEmpty ||
                    title == null && text.isEmpty ||
                    text == null && Date.isEmpty ||
                    Date == null) return;
                _taskService.addTask(title, text, Date);
                GoRouter.of(context).goNamed('home');
              },
              child: Text('Kaydet'),
            ),
          ],
        ),
      ),
    );
  }
}
