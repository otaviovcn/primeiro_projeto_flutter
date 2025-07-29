import 'package:flutter/material.dart';

class EmptyList extends StatelessWidget {
  const EmptyList({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        children: [
          Icon(Icons.error_outline, size: 80),
          Text('Não há nenhuma tarefa'),
        ],
      ),
    );
  }
}
