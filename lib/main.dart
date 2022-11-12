import 'package:flutter/material.dart';
import 'dart:async';
import 'digimon_model.dart';
import 'digimon_list.dart';
import 'new_digimon_form.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Marvel Characters',
      theme: ThemeData(brightness: Brightness.dark),
      home: MyHomePage(
        title: 'Marvel Characters',
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;
  MyHomePage({Key key, this.title}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Digimon> initialDigimons = []
    ..add(Digimon('Hulk'))
    ..add(Digimon('Spider-Man (Peter Parker)'))
    ..add(Digimon('Daredevil'))
    ..add(Digimon('Wolverine'))
    ..add(Digimon('Iron Man'))
    ..add(Digimon('Thanos'))
    ..add(Digimon('Galactus'))
    ..add(Digimon('Kang'));

  Future _showNewDigimonForm() async {
    Digimon newDigimon = await Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return AddDigimonFormPage();
    }));
    //print(newDigimon);
    if (newDigimon != null) {
      initialDigimons.add(newDigimon);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var key = new GlobalKey<ScaffoldState>();
    return new Scaffold(
      key: key,
      appBar: new AppBar(
        title: new Text(widget.title, style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 233, 41, 41),
        actions: <Widget>[
          new IconButton(
            icon: new Icon(Icons.add),
            onPressed: _showNewDigimonForm,
          ),
        ],
      ),
      body: new Container(
          color: Color.fromARGB(255, 247, 115, 115),
          child: new Center(
            child: new DigimonList(initialDigimons),
          )),
    );
  }
}
