import 'package:calculator/controllers/calculator_controller.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';

class CalculatorPage extends StatefulWidget {
  @override
  _CalculatorPageState createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  final _controller = CalculatorController();
  String _operations = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      appBar: _buildAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildSecondDisplay(text: _operations),
          _buildDisplay(text: _controller.result),
          Divider(color: Colors.white),
          _buildKeyboard(),
        ],
      ),
    );
  }

  Widget _buildAppBar() {
    return AppBar(
      title: Text('Calculadora'),
      centerTitle: true,
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.share,
            color: Colors.white
          ),
          padding: EdgeInsets.symmetric(horizontal: 20),
          onPressed: () {
            Share.share('https://github.com/SP-Sam/calculadora_flutter.git');
          }
        )  
      ],
    );
  }

  Widget _buildDisplay({String text}) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        alignment: Alignment.bottomRight,
        child: Text(
          text ?? '0',
          textAlign: TextAlign.end,
          style: TextStyle(
            color: Colors.white, 
            fontSize: 52, 
            fontFamily: 'Calculator'
          ),
        ),
      ),
    );
  }

  Widget _buildSecondDisplay({String text}) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        alignment: Alignment.bottomRight,
        child: Text(
          text ?? '0',
          textAlign: TextAlign.end,
          style: TextStyle(
            color: Colors.grey, 
            fontSize: 40, 
            fontFamily: 'Calculator'
          ),
        ),
      ),
    );
  }

  Widget _buildKeyboard() {
    return Container(
      height: 500,
      color: Colors.white,
      child: Column(
        children: [
          _buildKeyboardLine1(),
          _buildKeyboardLine2(),
          _buildKeyboardLine3(),
          _buildKeyboardLine4(),
          _buildKeyboardLine5(),
        ],
      )
    );
  }

  Widget _buildKeyboardLine1() {
    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildButton(label: 'AC', color: Colors.amber),
          _buildButton(label: 'DEL', color: Colors.amber),
          _buildButton(label: '%', color: Colors.amber),
          _buildButton(label: '/', color: Colors.amber)
        ],
      ),
    );
  }

  Widget _buildKeyboardLine2() {
    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildButton(label: '7'),
          _buildButton(label: '8'),
          _buildButton(label: '9'),
          _buildButton(label: 'x', color: Colors.amber)
        ],
      ),
    );
  }

  Widget _buildKeyboardLine3() {
    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildButton(label: '4'),
          _buildButton(label: '5'),
          _buildButton(label: '6'),
          _buildButton(label: '-', color: Colors.amber)
        ],
      ),
    );
  }

  Widget _buildKeyboardLine4() {
    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildButton(label: '1'),
          _buildButton(label: '2'),
          _buildButton(label: '3'),
          _buildButton(label: '+', color: Colors.amber)
        ],
      ),
    );
  }

  Widget _buildKeyboardLine5() {
    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildButton(label: '0', flex: 2),
          _buildButton(label: ','),
          _buildButton(label: '=', color: Colors.amber),
        ],
      ),
    );
  }

  Widget _buildButton({String label, int flex = 1, Color color = Colors.white}) {
    return Expanded(
      flex: flex,
      child: ElevatedButton(
        child: Text(
          label, 
          style: TextStyle(
            fontSize: 24,
            color: color
          ),
        ),

        onPressed: () {
          setState(() {
            _calculatorLogic(label);
            _secondOperation(label);
          });
        } 
      ),
    );
  }

    _secondOperation(String label) {
    final length = _operations.length;
    
    if (label == 'AC') {
      _operations = '';
    } else if (label == 'DEL') {
      if (length > 1) {
        _operations = _operations.substring(0, length - 1);
      } else {
        _operations = '';
      }
    } else if (label == '=') {
      label = '';
      _operations += label;
    } else {
      _operations += label;
    }
  }

  _calculatorLogic(String label) {
      _controller.applyCommand(label);
  }
}