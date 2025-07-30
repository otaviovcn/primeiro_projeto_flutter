import 'package:flutter/material.dart';
import 'package:nosso_primeiro_projeto/components/empty_list.dart';
import 'package:nosso_primeiro_projeto/components/loading.dart';
import 'package:nosso_primeiro_projeto/data/task_dao.dart';
import 'package:nosso_primeiro_projeto/screens/form_screen.dart';

import '../components/task.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({super.key});

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        backgroundColor: Colors.blue,
        title: Text('Tarefas', style: TextStyle(color: Colors.white)),
        elevation: 20.0,
      ),
      body: FutureBuilder<List<Task>>(
          future: TaskDao().findAll(),
          builder: (context, snapshot) {
            List<Task>? items = snapshot.data;
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return Loading();
              case ConnectionState.waiting:
                return Loading();
              case ConnectionState.active:
                return Loading();
              case ConnectionState.done:
                if (snapshot.hasData && items != null) {
                  if (items.isNotEmpty) {
                    return ListView.builder(
                      itemCount: items.length,
                      itemBuilder: (BuildContext context, int index) {
                        final task = items[index];
                        return task;
                      },
                    );
                  } else {
                    return EmptyList();
                  }
                }
                return Text('Erro ao carregar tarefas.');
            }
          }),
      floatingActionButton: FloatingActionButton(
        onPressed:  () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (newContext) => FormScreen(taskContext: context),
            ),
          );
          setState(() {});
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
