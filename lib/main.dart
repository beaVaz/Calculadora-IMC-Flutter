import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
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
  String resultadoImc = "";
  String feedbackImc = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Calculadora de IMC:',
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
                height: 16,
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
