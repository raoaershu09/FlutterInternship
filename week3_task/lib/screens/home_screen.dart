import 'package:flutter/material.dart';
import 'package:week3_task/models/task.dart';
import 'package:week3_task/services/shared_preferences_service.dart';
import 'add_task_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Task> _tasks = [];

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  // Load tasks from SharedPreferences
  Future<void> _loadTasks() async {
    final tasks = await SharedPreferencesService.loadTasks();
    setState(() {
      _tasks = tasks;
    });
  }

  // Save tasks to SharedPreferences
  Future<void> _saveTasks() async {
    await SharedPreferencesService.saveTasks(_tasks);
  }

  // Add new task
  void _addTask(Task newTask) {
    setState(() {
      _tasks.add(newTask);
    });
    _saveTasks();
  }

  // Delete task
  void _deleteTask(String taskId) {
    setState(() {
      _tasks.removeWhere((task) => task.id == taskId);
    });
    _saveTasks();
  }

  // Toggle task completion
  void _toggleTaskCompletion(String taskId) {
    setState(() {
      final taskIndex = _tasks.indexWhere((task) => task.id == taskId);
      if (taskIndex != -1) {
        _tasks[taskIndex].isCompleted = !_tasks[taskIndex].isCompleted;
      }
    });
    _saveTasks();
  }

  // Navigate to Add Task Screen
  void _navigateToAddTaskScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddTaskScreen(onTaskAdded: _addTask),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Custom App Bar with Action Button
      appBar: AppBar(
        title: Text(
          'My Tasks',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        backgroundColor:const Color.fromARGB(123, 98, 198, 237),
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.add, color: Colors.black),
            onPressed: _navigateToAddTaskScreen,
            tooltip: 'Add New Task',
          ),
        ],
      ),

      body:
       _tasks.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.checklist,
                    size: 80,
                    color: Colors.black,
                  ),
                  SizedBox(height: 20),
                  Text(
                    'No Tasks Yet!',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Tap the + button to add your first task',
                    style: TextStyle(
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            )
            
          : ListView.builder(
              itemCount: _tasks.length,
              itemBuilder: (context, index) {
                final task = _tasks[index];
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  elevation: 2,
                  child: ListTile(
                    leading: Checkbox(
                      value: task.isCompleted,
                      onChanged: (_) => _toggleTaskCompletion(task.id),
                      activeColor: Colors.black,
                      checkColor: Colors.white,
                    ),
                    title: Text(
                      task.title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        decoration: task.isCompleted
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                        color: task.isCompleted
                            ? Colors.grey
                            : Colors.black,
                      ),
                    ),
                    subtitle: task.description.isNotEmpty
                        ? Text(
                            task.description,
                            style: TextStyle(
                              decoration: task.isCompleted
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none,
                              color: task.isCompleted
                                  ? Colors.grey
                                  : Colors.black54,
                            ),
                          )
                        : null,
                    trailing: IconButton(
                      icon: Icon(
                        Icons.delete,
                        color: Colors.red[500],
                      ),
                      onPressed: () => _deleteTask(task.id),
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToAddTaskScreen,
        child: Icon(Icons.add, color: Colors.black),
        backgroundColor: const Color.fromARGB(123, 98, 198, 237),
        tooltip: 'Add New Task',
      ),
    );
  }
}