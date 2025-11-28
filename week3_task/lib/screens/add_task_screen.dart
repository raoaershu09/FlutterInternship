import 'package:flutter/material.dart';
import 'package:week3_task/models/task.dart';

class AddTaskScreen extends StatefulWidget {
  final Function(Task) onTaskAdded;

  const AddTaskScreen({Key? key, required this.onTaskAdded}) : super(key: key);

  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  void _saveTask() {
    final String title = _titleController.text.trim();
    final String description = _descriptionController.text.trim();

    if (title.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please enter a task title'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final newTask = Task(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      description: description,
      isCompleted: false,
      createdAt: DateTime.now(),
    );

    widget.onTaskAdded(newTask);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add New Task',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        backgroundColor: const Color.fromARGB(123, 98, 198, 237),
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.save, color: Colors.black87),
            onPressed: _saveTask,
            tooltip: 'Save Task',
          ),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Task Title *',
                labelStyle: TextStyle(color: Colors.black),
                hintText: 'Enter task title...',
                focusedBorder: OutlineInputBorder(
                   borderSide: BorderSide(color: Colors.black, width: 2),borderRadius: BorderRadius.circular(12),
                ),
                prefixIcon: Icon(
                Icons.title,
                color: Colors.black87,
                ),
              ),
              maxLines: 1,
            ),
            SizedBox(height: 20),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(
                labelText: 'Description',
                labelStyle: TextStyle(color: Colors.black),
                hintText: 'Enter task description (optional)...',
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 2),borderRadius: BorderRadius.circular(12),
                ),
                prefixIcon: Icon(
                  Icons.description,
                  color: Colors.black87,
                  ),
                alignLabelWithHint: true,
              ),
              maxLines: 3,
            ),
            SizedBox(height: 30),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _saveTask,
                child: Text(
                  'Save Task',
                  style: TextStyle(fontSize: 16),
                ),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  backgroundColor: const Color.fromARGB(123, 98, 198, 237),
                  foregroundColor: Colors.black,
                  textStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                  )
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}