import 'package:flutter/material.dart';

class Difficulty extends StatelessWidget {
  final int difficultyLevel;

  const Difficulty({
    super.key,
    required this.difficultyLevel,
    // Aqui seria para passar o objeto Task via parâmetro, e assim fossem usados os seus recursos internos(variáveis, métodos... );
    // required this.widget,
  });

  // final Task widget;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.star,
          size: 15,
          color:
          difficultyLevel >= 1
          // widget.difficulty >= 1
              ? Colors.blue
              : Colors.blue[100],
        ),
        Icon(
          Icons.star,
          size: 15,
          color:
          difficultyLevel >= 2
              ? Colors.blue
              : Colors.blue[100],
        ),
        Icon(
          Icons.star,
          size: 15,
          color:
          difficultyLevel >= 3
              ? Colors.blue
              : Colors.blue[100],
        ),
        Icon(
          Icons.star,
          size: 15,
          color:
          difficultyLevel >= 4
              ? Colors.blue
              : Colors.blue[100],
        ),
        Icon(
          Icons.star,
          size: 15,
          color:
          difficultyLevel >= 5
              ? Colors.blue
              : Colors.blue[100],
        ),
      ],
    );
  }
}