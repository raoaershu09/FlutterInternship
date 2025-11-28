import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import '../models/task.dart';

class SharedPreferencesService {
  static const String _tasksKey = 'tasks';

  // Save tasks to SharedPreferences
  static Future<void> saveTasks(List<Task> tasks) async {
    final prefs = await SharedPreferences.getInstance();
    final tasksJson = tasks.map((task) => task.toJson()).toList();
    await prefs.setString(_tasksKey, json.encode(tasksJson));
  }

  // Load tasks from SharedPreferences
  static Future<List<Task>> loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final tasksJsonString = prefs.getString(_tasksKey);
    
    if (tasksJsonString != null) {
      try {
        final List<dynamic> tasksJson = json.decode(tasksJsonString);
        return tasksJson.map((json) => Task.fromJson(json)).toList();
      } catch (e) {
        print('Error loading tasks: $e');
      }
    }
    return [];
  }
}