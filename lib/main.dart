import 'package:flutter/material.dart';

void main() => runApp(
      const MaterialApp(
        home: Home(),
        debugShowCheckedModeBanner: false,
      ),
    );

enum Genders { masculino, feminino }

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);



  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Genders? _character = Genders.masculino;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  late Text _result;

  Pessoa p = Pessoa();

  @override
  void initState() {
    super.initState();
    resetFields();
  }

  void resetFields() {
    _weightController.text = '';
    _heightController.text = '';
    setState(() {
      _result = const Text(
        "Informe seus dados"
      );
    });
  }


  /* antigo calculo
  void calculateImc() {
    double weight = double.parse(_weightController.text);
    double height = double.parse(_heightController.text) / 100;
    double imc = weight / (height* height);

    setState(() {
      _result  = "IMC = ${imc.toStringAsPrecision(2)}\n";
      if(imc<18.6) {
        _result += "Abaixo do peso";
      } else if(imc <25.0) {
        _result += "Peso ideal";
      } else if(imc <30.0) {
        _result += "Levemente acima do peso";
      } else if(imc <35.0) {
        _result += "Obesidade Grau I";
      } else if(imc <25.0) {
        _result += "Obesidade Grau II";
      } else {
        _result += "Obesidade Grau IV";
      }
    });
  }*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            padding: const EdgeInsets.all(20.0), child: buildForm()));
  }

  AppBar buildAppBar() {
    return AppBar(
      title: const Text('Calculadora de IMC'),
      backgroundColor: Colors.blue,
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.refresh),
          onPressed: () {
            resetFields();
          },
        )
      ],
    );
  }

  Form buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          buildTextFormField(
              label: "Peso(kg)",
              error: "Insira seu peso!",
              controller: _weightController),
          buildTextFormField(
              label: "Altura (cm)",
              error: "Insira uma altura!",
              controller: _heightController),
          ListTile(
            title: const Text('Masculino'),
            leading: Radio<Genders>(
              value: Genders.masculino,
              groupValue: _character,
              onChanged: (Genders? value) {
                setState(() {
                  _character = value;
                });
              },
            ),
          ),
          ListTile(
            title: const Text('Feminino'),
            leading: Radio<Genders>(
              value: Genders.feminino,
              groupValue: _character,
              onChanged: (Genders? value) {
                setState(() {
                  _character = value;
                });
              },
            ),
          ),
          buildTextResult(),
          buildCalculateButton(),
        ],
      ),
    );
  }

  Padding buildCalculateButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 36.0),
      child: ElevatedButton(
        onPressed: () {
          p.info(_weightController, _heightController);
          if (_formKey.currentState!.validate()) {
            setState(() {
              p.verificarImc(_character);
            });
          }
        },
        child: const Text('CALCULAR', style: TextStyle(color: Colors.white)),
      ),
    );
  }

  Padding buildTextResult() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 36.0),
      child: _result);
  }

  TextFormField buildTextFormField(
      {required TextEditingController controller,
      required String error,
      required String label}) {
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(labelText: label),
      controller: controller,
      validator: (text) {
        return text!.isEmpty ? error : null;
      },
    );
  }
}

class Pessoa {
//Criar um classe Pessoa com os atributos (peso, altura e gênero), criar métodos
//para calcular IMC e classificar;
Pessoa();

  late Text _result;
  late double altura;
  late double peso;

  void info(TextEditingController weight, TextEditingController height){
  altura = double.parse(weight.text);
  peso = double.parse(weight.text);
  }

  Text abaixo(var imc) {
    return Text(
    "IMC = $imc \nAbaixo do peso",
    textAlign: TextAlign.center,
    overflow: TextOverflow.ellipsis,
    style: TextStyle(fontWeight: FontWeight.bold),
  );}
  Text ideal(var imc) {
    return Text(
    "IMC = $imc \nPeso ideal",
    textAlign: TextAlign.center,
    overflow: TextOverflow.ellipsis,
    style: TextStyle(fontWeight: FontWeight.bold),
  );}
  Text acima(var imc) {
    return Text(
    "IMC = $imc \nLevemente acima do peso",
    textAlign: TextAlign.center,
    overflow: TextOverflow.ellipsis,
    style: TextStyle(fontWeight: FontWeight.bold),
  );}
  Text grau1(var imc) {
    return Text(
    "IMC = $imc \nObesidade Grau I",
    textAlign: TextAlign.center,
    overflow: TextOverflow.ellipsis,
    style: TextStyle(fontWeight: FontWeight.bold),
  );}
  Text grau2(var imc) {
    return Text(
    "IMC = $imc \nObesidade Grau II",
    textAlign: TextAlign.center,
    overflow: TextOverflow.ellipsis,
    style: TextStyle(fontWeight: FontWeight.bold),
  );}
  Text grau3(var imc) {
    return Text(
    "IMC = $imc \nObesidade Grau III",
    textAlign: TextAlign.center,
    overflow: TextOverflow.ellipsis,
    style: TextStyle(fontWeight: FontWeight.bold),
  );}

  double calcular() {
    double weight = peso;
    double height = altura / 100;
    return weight / (height * height);
  }

  Text imcFeminino() {
    var imc = calcular();

    if (imc < 19.2) {
      _result = abaixo(imc);
    } else if (imc < 25.9) {
      _result = ideal(imc);
    } else if (imc < 27.4) {
      _result = acima(imc);
    } else if (imc < 32.4) {
      _result = grau1(imc);
    } else if (imc < 39.9) {
      _result = grau2(imc);
    } else {
      _result = grau3(imc);
    }
    return _result;
  }

  Text imcMasculino() {
    var imc = calcular();

    if (imc < 20.7) {
      _result = abaixo(imc);
    } else if (imc < 26.5) {
      _result = abaixo(imc);
    } else if (imc < 27.9) {
      _result = abaixo(imc);
    } else if (imc < 31.2) {
      _result = abaixo(imc);
    } else if (imc < 39.9) {
      _result = abaixo(imc);
    } else {
      _result = abaixo(imc);
    }
    return _result;
  }

  Text verificarImc(_character) {
    if (_character == Genders.masculino) {
      return imcMasculino();
    } else {
      return imcFeminino();
    }
  }
}
