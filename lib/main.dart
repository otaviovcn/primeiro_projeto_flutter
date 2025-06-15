import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final String picture1 =
      "https://img-new.cgtrader.com/items/3579119/b0c7a67e96/large/flutter-dash-3d-model-b0c7a67e96.jpg";

  final String picture2 =
      "https://storage.googleapis.com/cms-storage-bucket/780e0e64d323aad2cdd5.png";

  final String picture3 =
      "https://baixardesign.com.br/fileupload/box/1571457380577/FOTO%20POL%C3%8DTICO%20SEM%20FUNDO%202.jpg";

  bool isVisible = true;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
      home: Scaffold(
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
              Task('Primeiro teste', Colors.white, picture1, 3),
              Task('Segundo teste', Colors.white, picture2, 4),
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
      ),
    );
  }
}

class Task extends StatefulWidget {
  final String name;
  final Color color;
  final String picture;
  final int difficulte;

  const Task(this.name, this.color, this.picture, this.difficulte, {super.key});

  @override
  State<Task> createState() => _TaskState();
}

int level = 0;

class _TaskState extends State<Task> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.lightBlue,
              borderRadius: BorderRadius.circular(4),
            ),
            height: 140,
            alignment: Alignment.bottomCenter,
            padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 200,
                  child: LinearProgressIndicator(
                    value:
                    widget.difficulte == 0
                        ? 1
                        : level / widget.difficulte / 10,
                  ),
                ),
                Text(
                  "Nível $level",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(4),
                topLeft: Radius.circular(4),
              ),
              color: widget.color,
            ),
            height: 100,
            padding: const EdgeInsets.only(right: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(4),
                    ),
                    color: Colors.black26,
                  ),
                  height: 100,
                  width: 72,
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(4),
                    ),
                    child: Image.network(widget.picture, fit: BoxFit.cover),
                  ),
                ),
                // O Container é apenas para delimitar o campo de escrita do texto.
                Container(
                  width: 200,
                  // O TextOverflow.ellipsis coloca '...' se o texto tentar passar da delimitação do widget
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.name,
                        style: TextStyle(fontSize: 24),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            size: 15,
                            color:
                            widget.difficulte >= 1
                                ? Colors.blue
                                : Colors.blue[100],
                          ),
                          Icon(
                            Icons.star,
                            size: 15,
                            color:
                            widget.difficulte >= 2
                                ? Colors.blue
                                : Colors.blue[100],
                          ),
                          Icon(
                            Icons.star,
                            size: 15,
                            color:
                            widget.difficulte >= 3
                                ? Colors.blue
                                : Colors.blue[100],
                          ),
                          Icon(
                            Icons.star,
                            size: 15,
                            color:
                            widget.difficulte >= 4
                                ? Colors.blue
                                : Colors.blue[100],
                          ),
                          Icon(
                            Icons.star,
                            size: 15,
                            color:
                            widget.difficulte >= 5
                                ? Colors.blue
                                : Colors.blue[100],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    ElevatedButton(
                      style: ButtonStyle(
                        minimumSize: WidgetStateProperty.all(
                          const Size(
                            30,
                            30,
                          ), // Defina a largura e a altura desejadas
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          if (level < 100) {
                            level++;
                          }
                        });
                      },
                      child: Icon(Icons.add),
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        minimumSize: WidgetStateProperty.all(
                          const Size(
                            30,
                            30,
                          ), // Defina a largura e a altura desejadas
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          if (level > 0) {
                            level--;
                          }
                        });
                      },
                      child: Icon(Icons.remove),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});
//
//   final String title;
//
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;
//
//   void _incrementCounter() {
//     setState(() {
//       _counter++;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.deepPurple,
//         title: Text(widget.title),
//       ),
//       body: ListView(
//         children: [
//           Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment:  CrossAxisAlignment.center,
//             children: <Widget>[
//               const Text('You have pushed the button this many times:'),
//               Text(
//                 '$_counter',
//                 style: Theme.of(context).textTheme.headlineMedium,
//               ),
//             ],
//           ),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _incrementCounter,
//         tooltip: 'Increment',
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }
