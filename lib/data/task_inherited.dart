import 'package:flutter/material.dart';
import 'package:nosso_primeiro_projeto/components/task.dart';

class TaskInherited extends InheritedWidget {
  TaskInherited({super.key, required super.child});

  final String picture1 =
      "https://img-new.cgtrader.com/items/3579119/b0c7a67e96/large/flutter-dash-3d-model-b0c7a67e96.jpg";

  final String picture2 =
      "https://storage.googleapis.com/cms-storage-bucket/780e0e64d323aad2cdd5.png";

  final String picture3 =
      "https://baixardesign.com.br/fileupload/box/1571457380577/FOTO%20POL%C3%8DTICO%20SEM%20FUNDO%202.jpg";

  final List<Task> taskList = [
    Task(
      taskName: "Tarefa 1",
      photoUrl:
          "https://img-new.cgtrader.com/items/3579119/b0c7a67e96/large/flutter-dash-3d-model-b0c7a67e96.jpg",
      taskDifficulty: 1,
    ),
    Task(
      taskName: "Tarefa 2",
      photoUrl:
          "https://storage.googleapis.com/cms-storage-bucket/780e0e64d323aad2cdd5.png",
      taskDifficulty: 1,
    ),
  ];

  void newTask(String name, String photo, int difficulty) {
    taskList.add(
      Task(taskName: name, photoUrl: photo, taskDifficulty: difficulty),
    );
  }

  static TaskInherited of(BuildContext context) {
    final TaskInherited? result =
        context.dependOnInheritedWidgetOfExactType<TaskInherited>();
    assert(result != null, 'No TaskInherited found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(TaskInherited old) {
    return old.taskList.length != taskList.length;
  }
}
