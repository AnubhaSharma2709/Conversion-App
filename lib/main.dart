import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Homepage(),
    );
  }
}

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List measureitem = [
    'Length',
    'Mass',
    'Temperature',
    'Volume',
    'Angles'
  ];
  int measurevalue = 0;
  String initout = '0';
  String targetout = '0';
  bool inputreversed = false;
  List<String> Length = ['Millimetres','Centimetres','Metres','Kilometres','Inches','Feet','Yards','Miles','Nautical Miles'];
  String? sellength = 'Centimetres';
  List<String> Length1 = ['Millimetres','Centimetres','Metres','Kilometres','Inches','Feet','Yards','Miles','Nautical Miles'];
  String? sellength1 = 'Inches';

  void cmtoin(){
    if (inputreversed){
      if (targetout!='') {
        initout = (double.parse(targetout) * 2.54).toString();
        if (initout.length > 7) {
          initout = double.parse(initout).toStringAsFixed(7);
          if (initout.substring(6,7)=='.'){
            initout = initout.substring(0,6);
          }
        }
        if (initout.length > 7) {
          initout = initout.substring(0,7);
        }
      }
    } else {
      if (initout!='') {
        targetout = (double.parse(initout) / 2.54).toString();
        if (targetout.length > 7) {
          targetout = double.parse(targetout).toStringAsFixed(7);
          if (targetout.substring(6,7)=='.'){
            targetout = targetout.substring(0,6);
          }
        }

        if (targetout.length > 7) {
          targetout = targetout.substring(0,7);
        }
      }
    }
  }
  void numtap(String a){
    if (inputreversed){
      if (targetout=='0'){
        targetout=a;
      } else if (targetout.length==7){
        null;
      } else {
        targetout+=a;
      }
    } else {
      if (initout=='0'){
        initout=a;
      } else if (initout.length==7){
        null;
      } else {
        initout+=a;
      }
    }
    cmtoin();
    setState((){});
  }

  void backtap(){
    if (inputreversed){
      if (targetout==''){
        null;
      } else if (targetout.length==1){
        targetout='';
      } else {
        targetout=targetout.substring(0,targetout.length-1);
      }
    } else {
      if (initout==''){
        null;
      } else if (initout.length==1){
        initout='';
      } else {
        initout=initout.substring(0,initout.length-1);
      }
    }
    if (initout=='' || targetout==''){
      cleartap();
    }
    cmtoin();
    setState((){});
  }

  void cleartap(){
    targetout='';
    initout='';
    setState((){});
  }

  void decimaltap(){
    if (inputreversed){
      if (targetout==''){
        targetout='0.';
      } else if (targetout.contains('.')) {
        null;
      } else {
        targetout+='.';
      }
    } else {
      if (initout==''){
        initout='0.';
      } else if (initout.contains('.')) {
        null;
      } else {
        initout+='.';
      }
    }
    cmtoin();
    setState((){});
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //This is the code for building App Bar
      //Scaffold Implements the basic Material Design visual layout structure.
      //here we have returned scaffold only to build our app
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Text('Unit Conversion App'),
          backgroundColor: Colors.black,
        ),
        body: SafeArea(
          child: Column(
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [ SizedBox(width: 15),
                    Row(
                      children: List.generate(
                          5, (int index) {
                        return Container(
                          margin: EdgeInsets.all(2),
                          child: ChoiceChip(
                            label: Text('${measureitem[index]}',
                              style: TextStyle(color: Colors.purpleAccent),),
                            selected: measurevalue == index,
                            onSelected: ((bool selected) {
                              setState(() {
                                if (selected) {
                                  measurevalue = index;
                                }
                              });
                            }),
                            selectedColor: Colors.grey[50],
                            tooltip: '${measureitem[index]}',
                            backgroundColor: Colors.black,
                          ),
                        );
                      }
                      ).toList(),
                    ),
                  ],
                ),
              ),
              Row(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      width: 250,
                      margin: EdgeInsets.only(left: 10),
                      child: SelectableText(
                        initout,style: TextStyle(color: Colors.white, fontSize: 50), showCursor: true,),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 15),
                      child: DropdownButton(
                        dropdownColor: Colors.black,
                        value: sellength,
                        onChanged: (String? selected){
                          sellength = selected;
                          setState((){});
                        },
                        items: Length.map((String value){
                          return DropdownMenuItem<String>(child: Text('$value',style: TextStyle(color: Colors.white)),value: value,);
                        }).toList(),
                      ),
                    ),
                    Spacer(flex: 13,),
                  ]
              ),
              Row(
                  children: [
              Container(
                alignment: Alignment.centerLeft,
                width: 250,
                margin: EdgeInsets.only(left: 10),
                child: SelectableText(
                  targetout,style: TextStyle(color: Colors.white, fontSize: 50), showCursor: true,),
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                child: DropdownButton(
                  dropdownColor: Colors.black,
                  value: sellength1,
                  onChanged: (String? selected){
                    sellength1 = selected;
                    setState((){});
                  },
                  items: Length1.map((String value){
                    return DropdownMenuItem<String>(child: Text('$value',style: TextStyle(color: Colors.white)),value: value,);
                  }).toList(),
                ),
              ),

    ],
    ),
              SizedBox(
                height: 30.0,
              ),
              Table(
              defaultColumnWidth: FractionColumnWidth(.23),
          children: [
            TableRow(
                children: [
                  Container(
                    padding: EdgeInsets.only(bottom: 10),
                    child: RawMaterialButton(
                      onPressed: (){
                        numtap('7');
                      },
                      child: Text('7',style: TextStyle(color: Colors.purpleAccent[100], fontSize: 30),),
                      fillColor: Colors.grey[900],
                      shape: CircleBorder(),
                      padding: EdgeInsets.all(16.0),
                    ),
                  ),
                  RawMaterialButton(
                    onPressed: (){
                      numtap('8');
                    },
                    child: Text('8',style: TextStyle(color: Colors.purpleAccent[100], fontSize: 30),),
                    fillColor: Colors.grey[900],
                    shape: CircleBorder(),
                    padding: EdgeInsets.all(16.0),
                  ),
                  RawMaterialButton(
                    onPressed: (){
                      numtap('9');
                    },
                    child: Text('9',style: TextStyle(color: Colors.purpleAccent[100], fontSize: 30),),
                    fillColor: Colors.grey[900],
                    shape: CircleBorder(),
                    padding: EdgeInsets.all(16.0),
                  ),
                  RawMaterialButton(
                    onPressed: (){
                      backtap();
                    },
                    child: Icon(Icons.backspace_outlined, size: 25, color:  Colors.purpleAccent[100],),
                    fillColor: Colors.grey[900],
                    shape: CircleBorder(),
                    padding: EdgeInsets.all(21.0),
                  ),
                ]
            ),
            TableRow(
                children: [
                  Container(
                    padding: EdgeInsets.only(bottom: 10),
                    child: RawMaterialButton(
                      onPressed: (){
                        numtap('4');
                      },
                      child: Text('4',style: TextStyle(color: Colors.purpleAccent[100], fontSize: 30),),
                      fillColor: Colors.grey[900],
                      shape: CircleBorder(),
                      padding: EdgeInsets.all(16.0),
                    ),),
                  RawMaterialButton(
                    onPressed: (){
                      numtap('5');
                    },
                    child: Text('5',style: TextStyle(color: Colors.purpleAccent[100], fontSize: 30),),
                    fillColor: Colors.grey[900],
                    shape: CircleBorder(),
                    padding: EdgeInsets.all(16.0),
                  ),
                  RawMaterialButton(
                    onPressed: (){
                      numtap('6');
                    },
                    child: Text('6',style: TextStyle(color: Colors.purpleAccent[100], fontSize: 30),),
                    fillColor: Colors.grey[900],
                    shape: CircleBorder(),
                    padding: EdgeInsets.all(16.0),
                  ),
                  RawMaterialButton(
                    onPressed: (){
                      cleartap();
                    },
                    child: Text('C',style: TextStyle(color: Colors.red[500], fontSize: 30),),
                    fillColor: Colors.grey[900],
                    shape: CircleBorder(),
                    padding: EdgeInsets.all(16.0),
                  ),
                ]
            ),
            TableRow(
                children: [
                  Container(
                    padding: EdgeInsets.only(bottom: 10),
                    child: RawMaterialButton(
                      onPressed: (){
                        numtap('1');
                      },
                      child: Text('1',style: TextStyle(color: Colors.purpleAccent[100], fontSize: 30),),
                      fillColor: Colors.grey[900],
                      shape: CircleBorder(),
                      padding: EdgeInsets.all(16.0),
                    ),),
                  RawMaterialButton(
                    onPressed: (){
                      numtap('2');
                    },
                    child: Text('2',style: TextStyle(color: Colors.purpleAccent[100], fontSize: 30),),
                    fillColor: Colors.grey[900],
                    shape: CircleBorder(),
                    padding: EdgeInsets.all(16.0),
                  ),
                  RawMaterialButton(
                    onPressed: (){
                      numtap('3');
                    },
                    child: Text('3',style: TextStyle(color: Colors.purpleAccent[100], fontSize: 30),),
                    fillColor: Colors.grey[900],
                    shape: CircleBorder(),
                    padding: EdgeInsets.all(16.0),
                  ),
                  RawMaterialButton(
                    onPressed: (){
                      inputreversed = inputreversed ? false : true;
                    },
                    child: Icon(Icons.multiple_stop, size: 25, color:  Colors.purpleAccent[100],),
                    fillColor: Colors.grey[900],
                    shape: CircleBorder(),
                    padding: EdgeInsets.all(21.0),
                  ),
                ]
            ),
            TableRow(
                children: [
                  Container(
                      padding: EdgeInsets.only(bottom: 10),
                      child: RawMaterialButton(
                        onPressed: (){null;},
                        child: Text('+/-',style: TextStyle(color: Colors.purpleAccent[100], fontSize: 30),),
                        fillColor: Colors.grey[900],
                        shape: CircleBorder(),
                        padding: EdgeInsets.all(16.0),
                      )),
                  RawMaterialButton(
                    onPressed: (){
                      numtap('0');
                    },
                    child: Text('0',style: TextStyle(color: Colors.purpleAccent[100], fontSize: 30),),
                    fillColor: Colors.grey[900],
                    shape: CircleBorder(),
                    padding: EdgeInsets.all(16.0),
                  ),
                  RawMaterialButton(
                    onPressed: (){
                      decimaltap();
                    },
                    child: Text('.',style: TextStyle(color: Colors.purpleAccent[100], fontSize: 30),),
                    fillColor: Colors.grey[900],
                    shape: CircleBorder(),
                    padding: EdgeInsets.all(16.0),
                  ),
                  RawMaterialButton(
                    onPressed: (){
                      Navigator.pushNamed(context, '/settings');
                    },
                    child: Icon(Icons.settings, size: 25, color:  Colors.purpleAccent[100],),
                    fillColor: Colors.grey[900],
                    shape: CircleBorder(),
                    padding: EdgeInsets.all(21.0),
                  ),
                ]
            )
          ],
        )

    ]
    )
    )
    );
  }
}