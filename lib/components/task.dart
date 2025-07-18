import 'package:flutter/material.dart';

import 'difficulty.dart';

class Task extends StatefulWidget {
  final String taskName;
  final Color colorBackground;
  final String photoUrl;
  final int taskDifficulty;

  Task({
    super.key,
    required this.taskName,
    required this.photoUrl,
    required this.taskDifficulty,
    this.colorBackground = Colors.white,
  });
  int level = 0;

  @override
  State<Task> createState() => _TaskState();
}

class _TaskState extends State<Task> {
  double progressIndicator = 0.0;
  Color color = Colors.lightBlue;

  void upgradeLevel() {
    double evolution =
        widget.taskDifficulty == 0 ? 1 : widget.level / widget.taskDifficulty / 10;

    if (evolution <= 1.0) {
      color = Colors.lightBlue;
      progressIndicator = evolution;
    } else if (evolution <= 2.0) {
      color = Colors.green;
      progressIndicator = evolution - 1;
    } else if (evolution <= 3.0) {
      color = Colors.orange;
      progressIndicator = evolution - 2;
    } else {
      color = Colors.red; // cor final, você pode trocar
      progressIndicator = 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(4),
            ),
            height: 140,
            alignment: Alignment.bottomCenter,
            padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 200,
                  child: LinearProgressIndicator(value: progressIndicator),
                ),
                Text(
                  "Nível ${widget.level / widget.taskDifficulty / 10 > 3 ? 'Máximo' : widget.level}",
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
              color: widget.colorBackground,
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
                    child:
                        widget.photoUrl.contains("http")
                            ? Image.network(widget.photoUrl, fit: BoxFit.cover)
                            : Image.asset(widget.photoUrl),
                  ),
                ),
                // O Container é apenas para delimitar o campo de escrita do texto.
                SizedBox(
                  width: 200,
                  // O TextOverflow.ellipsis coloca '...' se o texto tentar passar da delimitação do widget
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.taskName,
                        style: TextStyle(fontSize: 24),
                        overflow: TextOverflow.ellipsis,
                      ),

                      Difficulty(difficultyLevel: widget.taskDifficulty),
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
                          if (widget.level / widget.taskDifficulty / 10 <= 3) {
                            widget.level++;
                          }
                          upgradeLevel();
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
                          if (widget.level > 0) {
                            widget.level--;
                            upgradeLevel();
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
