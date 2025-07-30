import 'package:flutter/material.dart';
import 'package:nosso_primeiro_projeto/data/task_dao.dart';

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
        widget.taskDifficulty == 0
            ? 1
            : widget.level / widget.taskDifficulty / 10;

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
                            ? Image.network(
                              widget.photoUrl,
                              fit: BoxFit.cover,
                              errorBuilder: (
                                BuildContext context,
                                Object exception,
                                StackTrace? stackTrace,
                              ) {
                                return Image.asset('assets/images/nophoto.png');
                              },
                            )
                            : Image.asset(
                              widget.photoUrl,
                              errorBuilder: (
                                BuildContext context,
                                Object exception,
                                StackTrace? stackTrace,
                              ) {
                                return Image.asset('assets/images/nophoto.png');
                              },
                            ),
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
                SizedBox(
                  width: 80,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SizedBox(
                              width: 30,
                              height: 30,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  backgroundColor: Colors.white,
                                  foregroundColor: Colors.black,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  elevation: 2,
                                ),
                                onPressed: () {
                                  setState(() {
                                    if (widget.level /
                                            widget.taskDifficulty /
                                            10 <=
                                        3) {
                                      widget.level++;
                                    }
                                    upgradeLevel();
                                  });
                                },
                                child: Icon(Icons.keyboard_arrow_up),
                              ),
                            ),
                            SizedBox(
                              width: 35,
                              height: 30,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  backgroundColor: Colors.white,
                                  foregroundColor: Colors.black,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  elevation: 2,
                                ),
                                onPressed: () {
                                  setState(() {
                                    if (widget.level > 0) {
                                      widget.level--;
                                      upgradeLevel();
                                    }
                                  });
                                },
                                child: Icon(Icons.keyboard_arrow_down),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 4, ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SizedBox(
                              width: 30,
                              height: 30,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  backgroundColor: Colors.yellow,
                                  foregroundColor: Colors.black26,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  elevation: 2,
                                ),
                                onPressed: () {
                                  setState(() {});
                                },
                                child: Icon(Icons.edit),
                              ),
                            ),
                            SizedBox(
                              width: 30,
                              height: 30,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  backgroundColor: Colors.red,
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  elevation: 2,
                                ),
                                onPressed: () {
                                  setState(() {
                                    TaskDao().delete(widget.taskName);
                                  });
                                },
                                child: Icon(Icons.delete),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
