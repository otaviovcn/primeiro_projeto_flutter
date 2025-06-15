import 'package:flutter/material.dart';

import '../components/task.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({super.key});

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}
final String picture1 =
    "https://img-new.cgtrader.com/items/3579119/b0c7a67e96/large/flutter-dash-3d-model-b0c7a67e96.jpg";

final String picture2 =
    "https://storage.googleapis.com/cms-storage-bucket/780e0e64d323aad2cdd5.png";

final String picture3 =
    "https://baixardesign.com.br/fileupload/box/1571457380577/FOTO%20POL%C3%8DTICO%20SEM%20FUNDO%202.jpg";

bool isVisible = true;

class _InitialScreenState extends State<InitialScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        backgroundColor: Colors.amber,
        title: Text('Tarefas'),
      ),
      body: AnimatedOpacity(
        duration: Duration(milliseconds: 400),
        opacity: isVisible ? 1 : 0,
        child: ListView(
          children: [
            Task('Primeiro teste', Colors.white, picture1, 2),
            Task('Segundo teste', Colors.white, picture2, 0),
            Task('Terceiro  teste', Colors.deepPurple, picture3, 1),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            isVisible = !isVisible;
          });
        },
        child: isVisible ? Icon(Icons.remove_red_eye_sharp) : Icon(Icons.remove_red_eye_outlined),
      ),
      // floatingActionButton: FloatingButton(),
    );
  }
}
