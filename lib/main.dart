import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  Text returnText(String texto) {
    return Text(texto,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 162, 108, 255)),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Calculadora de IMC'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController controllerPeso = TextEditingController();
  TextEditingController controllerAltura = TextEditingController();
  var dataNascimentoController = TextEditingController(text: '');
  String resultadoImc = "";
  String feedbackImc = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title,
            style: GoogleFonts.dmSans(
                fontWeight: FontWeight.w600, color: Colors.deepPurple)),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Icon(
                Icons.health_and_safety_sharp,
                size: 30,
                color: Color.fromARGB(255, 107, 50, 206),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Calculadora de IMC:',
                style: TextStyle(
                    color: Color.fromARGB(255, 53, 53, 53),
                    fontWeight: FontWeight.w700),
              ),
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                keyboardType: const TextInputType.numberWithOptions(),
                controller: controllerPeso,
                decoration: const InputDecoration(
                    labelText: 'Peso',
                    hintText: 'Digite o seu peso',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)))),
              ),
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                keyboardType: const TextInputType.numberWithOptions(),
                controller: controllerAltura,
                decoration: const InputDecoration(
                    labelText: 'Altura',
                    hintText: 'Digite a sua altura',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)))),
              ),
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                keyboardType: const TextInputType.numberWithOptions(),
                controller: dataNascimentoController,
                decoration: const InputDecoration(
                    labelText: 'Data de nascimento',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)))),
                onTap: () async {
                  var data = await showDatePicker(
                    context: context,
                    initialDate: DateTime(1950, 01, 01),
                    firstDate: DateTime(1999, 01, 01),
                    lastDate: DateTime(2050, 12, 31),
                  );
                  if (data != null) {
                    dataNascimentoController.text = data.toString();
                  }
                },
              ),
              const SizedBox(
                height: 32,
              ),
              Text(
                resultadoImc,
                style:
                    const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                feedbackImc,
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple),
              ),
              const SizedBox(
                height: 8,
              ),
              SizedBox(
                  width: 200,
                  child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          num numAux = (num.parse(controllerPeso.text) /
                              (num.parse(controllerAltura.text) *
                                  num.parse(controllerAltura.text)));

                          resultadoImc = numAux.toStringAsFixed(2);
                          if (numAux < 16) {
                            feedbackImc = 'Magreza grave';
                          } else if (numAux >= 16 && numAux < 17) {
                            feedbackImc = 'Magreza moderada';
                          } else if (numAux >= 17 && numAux < 18.5) {
                            feedbackImc = 'Magreza leve';
                          } else if (numAux >= 18.5 && numAux < 25) {
                            feedbackImc = 'Saudável';
                          } else if (numAux >= 25 && numAux < 30) {
                            feedbackImc = 'Sobrepeso';
                          } else if (numAux >= 30 && numAux < 35) {
                            feedbackImc = 'Obesidade grau I';
                          } else if (numAux >= 35 && numAux < 40) {
                            feedbackImc = 'Obesidade grau II (severa)';
                          } else if (numAux >= 40) {
                            feedbackImc = 'Obesidade grau III (mórbida)';
                          } else {
                            feedbackImc = 'Ocorreu algum erro, tente novamente';
                          }
                        });
                      },
                      child: const Text('Calcular')))
            ],
          ),
        ),
      ),
      floatingActionButton: ElevatedButton(
        onPressed: () {
          setState(() {
            resultadoImc = "";
            feedbackImc = "";
          });
        },
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: Colors.deepPurple,
        ),
        child: const Text('Limpar Resultado'),
      ),
    );
  }
}
