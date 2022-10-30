import 'package:flutter/material.dart';

void main() => runApp(UnitConverter());

class UnitConverter extends StatefulWidget{

  @override
  UnitConverterState createState() => UnitConverterState();
}

class UnitConverterState extends State<UnitConverter>{

  String _resultMessage = "";
  double _numberFrom = 0;
  String _startMeasure = "meters";
  String _convertedMeasure = "meters";

  final List<String> _measures = [
    'meters',
    'kilometers',
    'grams',
    'kilograms',
    'feet',
    'miles',
    'pounds (lbs)',
    'ounces'
  ];

  final Map<String, int> _measuresMap = {
    'meters':0,
    'kilometers':1,
    'grams':2,
    'kilograms':3,
    'feets':4,
    'miles':5,
    'pounds (lbs)':6,
    'ounces':7
  };

  final dynamic _formulas = {
    '0':[1,0.001,0,0,3.28084,0.000621371,0,0],
    '1':[1000,1,0,0,3280.84,0.621371,0,0],
    '2':[0,0,1,0.0001,0,0,0.00220462,0.035274],
    '3':[0,0,1000,1,0,0,2.20462,35.274],
    '4':[0.3048,0.0003048,0,0,1,0.000189394,0,0],
    '5':[1609.34, 1.60934,0,0,5280,1,0,0],
    '6':[0,0,453.592,0.453592,0,0,1,16],
    '7':[0,0,28.3495,0.0283495,3.28084,0,0.0625, 1],
  };

  @override
  void initState(){
    _numberFrom = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context){

    final TextStyle inputStyle = TextStyle(
      fontSize: 20,
      color: Colors.red,
      fontWeight: FontWeight.bold,
    );

    final TextStyle labelStyle = TextStyle(
      fontSize: 24,
      color: Colors.deepOrangeAccent,
      fontWeight: FontWeight.bold,
    );
    return MaterialApp(
      title: "Measures App",
      home: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            backgroundColor: Colors.black,
            title: Text("Unit Conversion", style: labelStyle,
            ),
          ),
          body: Container(
            color: Colors.black,
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  SizedBox(
                    height: 30.0,
                  ),
                  Text(
                    'Enter the Value ',
                    style: labelStyle,
                  ),
                  Spacer(),
                  TextField(
                    keyboardType: TextInputType.number,
                    style: inputStyle,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white24,
                        hintText: "Insert the value to be converted",
                    ),
                    onChanged: (text){
                      var rv = double.tryParse(text);
                      if(rv != null){
                        setState(() {
                          _numberFrom = rv;
                        });
                      }
                    },
                  ),
                  SizedBox(
                    height: 50.0,
                  ),
                  Text(
                    'From',
                    style: labelStyle,
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  DropdownButton(
                    value: _startMeasure,
                    onChanged: (String? newValue){
                      setState(() {
                        _startMeasure = newValue!;
                      });
                    },
                    items: _measures.map<DropdownMenuItem<String>>((String value){
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: inputStyle,
                        ),
                      );
                    }).toList(),
                  ),
                  SizedBox(
                    height: 50.0,
                  ),
                  Text(
                    'To',
                    style: labelStyle,
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  DropdownButton(
                    value: _convertedMeasure,
                    onChanged: (String? newValue){
                      setState(() {
                        _convertedMeasure = newValue!;
                      });
                    },
                    items: _measures.map<DropdownMenuItem<String>>((String value){
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value,
                            style: inputStyle),
                      );
                    }).toList(),
                  ),
                  SizedBox(
                    height: 50.0,
                  ),
                  ElevatedButton(
                    child: Text('Convert', style: TextStyle(
                      color: Colors.black
                    ),),
                    onPressed: (){
                      if(_startMeasure.isEmpty || _convertedMeasure.isEmpty || _numberFrom == 0){
                        return;
                      }else{
                        convert(_numberFrom, _startMeasure, _convertedMeasure);
                      }
                    },
                    style: ButtonStyle(
                      backgroundColor:MaterialStateProperty.all(Colors.deepOrangeAccent),
                    ),
                  ),
                  Spacer(flex: 2,),
                  Text(
                    (_resultMessage == '') ? '' : _resultMessage,
                    style: labelStyle,
                  ),
                  Spacer(flex: 10,),
                ],
              )
          )
      ),
    );
  }

  void convert(double value, String from, String to){
    int? nFrom = _measuresMap[from];
    int? nTo = _measuresMap[to];
    var multiplier = _formulas[nFrom.toString()] [nTo];
    var result = value * multiplier;

    if(result == 0){
      _resultMessage = "This conversion cannot be performed";
    }else{
      _resultMessage = '${_numberFrom.toString()} ${_startMeasure} are '
          '${result.toString()} ${_convertedMeasure}';
    }
    setState(() {
      _resultMessage = _resultMessage;
    });
  }
}