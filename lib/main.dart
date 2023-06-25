import 'package:flutter/material.dart';

void main() {
  runApp(TaskManagementApp());
}

class TaskManagementApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Task Management',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TaskListScreen(),
    );
  }
}

class TaskListScreen extends StatefulWidget {
  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  List<Task> tasks = [];

  void addTask(Task task) {
    setState(() {
      tasks.add(task);
    });
  }

  void deleteTask(Task task) {
    setState(() {
      tasks.remove(task);
    });
  }

  void showTaskDetails(Task task) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                task.title,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.0),
              Text(task.description),
              SizedBox(height: 8.0),
              Text(
                'Deadline: ${task.deadline}',
                style: TextStyle(fontStyle: FontStyle.italic, color: Colors.black),
              ),
              SizedBox(height: 18.0),
              ElevatedButton(
                onPressed: () {
                  deleteTask(task);
                  Navigator.pop(context);
                },
                child: Text('Delete', style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task List',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
          centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(tasks[index].title,style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
            subtitle: Text(tasks[index].deadline,style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
            onTap: () => showTaskDetails(tasks[index]),
            onLongPress: () => showTaskDetails(tasks[index]),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddTaskDialog(),
        child: Icon(Icons.add),
      ),
    );
  }

  void _showAddTaskDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String title = '';
        String description = '';
        String deadline = '';

        return AlertDialog(
          title: Text('Add Task', style: TextStyle(color: Colors.black, fontSize: 22, fontWeight: FontWeight.bold),),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Title',labelStyle: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold), ),
                onChanged: (value) => title = value,
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Description', labelStyle: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),),
                onChanged: (value) => description = value,
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Deadline', labelStyle: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),),
                onChanged: (value) => deadline = value,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                addTask(Task(title: title, description: description, deadline: deadline));
                Navigator.pop(context);
              },
              child: Text('Save', style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel', style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),),
            ),
          ],
        );
      },
    );
  }
}

class Task {
  final String title;
  final String description;
  final String deadline;

  Task({
    required this.title,
    required this.description,
    required this.deadline,
  });
}
