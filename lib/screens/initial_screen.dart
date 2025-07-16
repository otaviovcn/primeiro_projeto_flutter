import 'package:flutter/material.dart';
import 'package:nosso_primeiro_projeto/data/task_inherited.dart';
import 'package:nosso_primeiro_projeto/screens/form_screen.dart';

import '../components/task.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({super.key});

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

// bool isVisible = true;   // Variável que determina a visibilidade;

class _InitialScreenState extends State<InitialScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        backgroundColor: Colors.blue,
        title: Text('Tarefas', style: TextStyle(color: Colors.white),),
      ),
      body: AnimatedOpacity(
        duration: Duration(milliseconds: 400),
        // opacity: isVisible ? 1 : 0, //  Condição da visibilidade;
        opacity: 1,
        child: ListView(
          children: TaskInherited.of(context).taskList,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (newContext) => FormScreen(taskContext: context,)),
          );

          // Fenômeno de deixar invisível ou não a View
          // setState(() {
          //   isVisible = !isVisible;
          // });
        },
        child: Icon(Icons.add),
        // child: isVisible ? Icon(Icons.remove_red_eye_sharp) : Icon(Icons.remove_red_eye_outlined), // Alterna o ícone conforme a visibilidade;
      ),
      // floatingActionButton: FloatingButton(),
    );
  }
}
