import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ModulePage(),
    );
  }
}

class ModulePage extends StatefulWidget {
  @override
  _ModulePageState createState() => _ModulePageState();
}

class _ModulePageState extends State<ModulePage> {
  final List<String> doneModuleList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Memulai Pemrograman Dart"),
        actions: [
          IconButton(
              icon: Icon(Icons.done),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          DoneModuleList(doneModuleList: doneModuleList),
                    ));
              })
        ],
      ),
      body: ModuleList(doneModuleList: doneModuleList),
    );
  }
}

class ModuleList extends StatefulWidget {
  final List<String> doneModuleList;

  const ModuleList({Key key, this.doneModuleList}) : super(key: key);

  @override
  _ModuleListState createState() => _ModuleListState();
}

class _ModuleListState extends State<ModuleList> {
  final List<String> _moduleList = [
    'Modul 1 - Pengenalan Dart',
    'Modul 2 - Memulai Pemrograman dengan Dart',
    'Modul 3 - Dart Fundamental',
    'Modul 4 - Control Flow',
    'Modul 5 - Collections',
    'Modul 6 - Object Oriented Programming',
    'Modul 7 - Functional Styles',
    'Modul 8 - Dart Type System',
    'Modul 9 - Dart Futures',
    'Modul 10 - Effective Dart',
  ];
  final List<String> doneModuleList = [];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: _moduleList.length,
        itemBuilder: (context, index) {
          return ModuleTile(
            moduleName: _moduleList[index],
            isDone: widget.doneModuleList.contains(_moduleList[index]),
            onClick: () {
              setState(() {
                widget.doneModuleList.add(_moduleList[index]);
              });
            },
          );
        });
  }
}

class ModuleTile extends StatelessWidget {
  final String moduleName;
  final bool isDone;
  final Function onClick;

  const ModuleTile({Key key, this.moduleName, this.isDone, this.onClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(moduleName),
      trailing: isDone
          ? Icon(Icons.done)
          : RaisedButton(
              child: Text('Done'),
              onPressed: onClick,
            ),
    );
  }
}

class DoneModuleList extends StatelessWidget {
  final List<String> doneModuleList;

  const DoneModuleList({Key key, this.doneModuleList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Done Module List'),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(doneModuleList[index]),
          );
        },
        itemCount: doneModuleList.length,
      ),
    );
  }
}
