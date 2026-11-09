import 'package:flutter/material.dart';
import 'package:algorithm_engine/algorithm_engine.dart' as algorithm_engine;
import 'package:go_router/go_router.dart';

const List<String> list = <String>['+', '-', '*', '/'];

final GoRouter _router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => const HomeScreen()),
    GoRoute(path: 'path'),
  ],
);

void main() {
  runApp(const MyApp());
}

class HomeScreen extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(routerConfig: _router);
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('C++ FFI Test')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Flutter + C++ FFI', style: TextStyle(fontSize: 24)),
              const SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: Calculator(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Calculator extends StatefulWidget {
  const new({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  final myController1 = TextEditingController();
  final myController2 = TextEditingController();

  String selectedValue = list.first;
  int a = 0;
  int b = 0;
  bool hasCalculated = false;
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed
    myController1.dispose();
    myController2.dispose();
    super.dispose();
  }

  void _calculate() {
    setState(() {
      a = int.tryParse(myController1.text) ?? 0;
      b = int.tryParse(myController2.text) ?? 0;
      hasCalculated = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 50,
          child: TextField(
            controller: myController1,
            decoration: InputDecoration(border: OutlineInputBorder()),
          ),
        ),
        SizedBox(width: 20),
        DropdownButton<String>(
          value: selectedValue,
          items: list.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value, style: const TextStyle(fontSize: 20)),
            );
          }).toList(),
          onChanged: (String? newValue) {
            if (newValue != null) {
              setState(() {
                selectedValue = newValue;
              });
            }
          },
        ),
        SizedBox(width: 20),
        SizedBox(
          width: 50,
          child: TextField(
            controller: myController2,
            decoration: InputDecoration(border: OutlineInputBorder()),
          ),
        ),
        SizedBox(width: 20),
        ElevatedButton(
          onPressed: () {
            _calculate();
          },
          child: Text("="),
        ),
        SizedBox(width: 20),
        if (hasCalculated && selectedValue == "+")
          Text(
            '${algorithm_engine.algorithmAdd(a, b)}',
            style: const TextStyle(fontSize: 28),
          )
        else if (hasCalculated && selectedValue == "-")
          Text(
            '${algorithm_engine.algorithmSubtraction(a, b)}',
            style: const TextStyle(fontSize: 28),
          )
        else if (hasCalculated && selectedValue == "*")
          Text(
            '${algorithm_engine.algorithmMultiplication(a, b)}',
            style: const TextStyle(fontSize: 28),
          )
        else if (hasCalculated && selectedValue == "/")
          Text(
            '${algorithm_engine.algorithmDivision(a, b)}',
            style: const TextStyle(fontSize: 28),
          ),
      ],
    );
  }
}
