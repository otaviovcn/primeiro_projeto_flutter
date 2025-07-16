import 'package:flutter/material.dart';
import 'package:nosso_primeiro_projeto/data/task_inherited.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({super.key, required this.taskContext});

  final BuildContext taskContext;

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController difficultyController = TextEditingController();
  TextEditingController imageController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  Map<String, String?> valueValidator({
    required String? value,
    required String nameField,
  }) {
    Map<String, String?> response = {"isItValid": "", "response": ""};
    if (value == null) {
      response["response"] =
          "O campo '$nameField' não pode receber uma informação nula";
    } else if (value.isEmpty) {
      response["response"] = "O campo '$nameField' não pode estar vazio";
    } else {
      response["isItValid"] = null;
    }
    return response;
  }

  Map<String, String?> difficultyValidator({required String value}) {
    Map<String, String?> response = {"isItValid": "", "response": ""};

    try {
      int intValue = int.parse(value);
      if (intValue <= 0 || intValue > 5) {
        response["response"] =
            "O grau de dificuldade deve estar entre '1' e '5'";
        return response;
      }
    } catch (e) {
      response["response"] =
          "O campo deve ser preenchido com um caractere numérico";
      return response;
    }
    response["isItValid"] = null;
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.amber,
          title: const Text('Nova Tarefa'),
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(8, 12, 8, 12),
          child: SingleChildScrollView(
            child: Container(
              height: 500,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(width: 3, color: Colors.grey),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    spreadRadius: 2,
                    blurRadius: 2,
                    offset: Offset(0, 2), // Deslocamento horizontal e vertical
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      validator: (value) {
                        var resultValueValidator = valueValidator(
                          value: value,
                          nameField: "Tarefa",
                        );
                        if (resultValueValidator["isItValid"] != null) {
                          return resultValueValidator["response"];
                        }
                        return null;
                      },
                      controller: nameController,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Digite a tarefa aqui",
                        fillColor: Colors.white60,
                        filled: true,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      validator: (value) {
                        var resultValueValidator = valueValidator(
                          value: value,
                          nameField: "Grau de dificuldade",
                        );
                        var resultDifficultyValidator = difficultyValidator(
                          value: value!,
                        );

                        if (resultValueValidator["isItValid"] != null) {
                          return resultValueValidator["response"];
                        } else if (resultDifficultyValidator["isItValid"] !=
                            null) {
                          return resultDifficultyValidator["response"];
                        }
                        return null;
                      },
                      keyboardType: TextInputType.number,
                      controller: difficultyController,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Grau de dificuldade(5,4,3,2 ou 1)",
                        fillColor: Colors.white60,
                        filled: true,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      validator: (value) {
                        var resultValueValidator = valueValidator(
                          value: value,
                          nameField: "Link da imagem",
                        );
                        if (resultValueValidator["isItValid"] != null) {
                          return resultValueValidator["response"];
                        }
                        return null;
                      },
                      keyboardType: TextInputType.url,
                      onChanged: (text) {
                        setState(() {});
                      },
                      controller: imageController,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Link da imagem",
                        fillColor: Colors.white60,
                        filled: true,
                      ),
                    ),
                  ),
                  Container(
                    height: 100,
                    width: 72,
                    decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(width: 2, color: Colors.blue),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child:
                          imageController.text.contains('http')
                              ? Image.network(
                                imageController.text,
                                errorBuilder: (
                                  BuildContext context,
                                  Object exception,
                                  StackTrace? stackTrace,
                                ) {
                                  return Image.asset(
                                    'assets/images/nophoto.png',
                                  );
                                },
                                fit: BoxFit.cover,
                              )
                              : Image.asset(
                                imageController.text,
                                errorBuilder: (
                                  BuildContext context,
                                  Object exception,
                                  StackTrace? stackTrace,
                                ) {
                                  return Image.asset(
                                    'assets/images/nophoto.png',
                                  );
                                },
                              ),
                    ),
                  ),
                  SizedBox(
                    width: 120,
                    height: 40,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              10.0,
                            ), // Define o raio de arredondamento
                          ),
                        ),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // print(
                          //   "Nome: ${nameController
                          //       .text} \nDificuldade: ${difficultyController
                          //       .text}\nLink:  ${imageController.text}  ",
                          // );

                          TaskInherited.of(widget.taskContext).newTask(
                            nameController.text,
                            imageController.text,
                            int.parse(difficultyController.text),
                          );

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Formulário enviado com sucesso'),
                            ),
                          );

                          Navigator.pop(context);
                        }
                      },
                      child: Text("Adicionar"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
