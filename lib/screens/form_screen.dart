import 'package:flutter/material.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({super.key});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController difficultyController = TextEditingController();
  TextEditingController imageController = TextEditingController();


  final _formKey = GlobalKey<FormState>();
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
                      validator: (validate) {
                        if(validate!=null && validate.isEmpty) {
                          return "O campo tarefa não pode estar vazio";
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
                      validator: (validate) {
                        if(validate!.isEmpty) {
                          return "O campo dificuldade não pode estar vazio";
                        } else if ( int.parse(validate) <= 0  || int.parse(validate) > 5) {
                          return "A dificuldade deve estar entre '1' e '5'";
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
                      validator: (validate) {
                        if(validate!.isEmpty) {
                          return "O campo url não pode estar vazio";
                        }
                        return null;
                      },
                      keyboardType: TextInputType.url,
                      onChanged: (text) { setState(() {}); },
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
                      child: Image.network(
                          imageController.text,
                          errorBuilder: (BuildContext context,  Object exception, StackTrace? stackTrace) {
                            return Image.asset('assets/images/nophoto.png');
                          },
                          fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if(_formKey.currentState!.validate()) {
                        print(
                          "Nome: ${nameController
                              .text} \nDificuldade: ${difficultyController
                              .text}\nLink:  ${imageController.text}  ",
                        );
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Formulário enviado com sucesso'),
                          )
                        );
                      }
                    },
                    child: Text("Adicionar"),
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
