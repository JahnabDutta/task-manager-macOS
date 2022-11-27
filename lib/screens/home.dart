import 'package:flutter/material.dart';
import '../models/process.dart';
import '../widgets/process_item.dart';
import 'dart:io';
import 'dart:convert';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  // var processList;
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  var processList;
  void initState() {
    super.initState();
  }

  @override
  void updoot() async {
    var tempProcessList = await RunningProcess.processList();
    setState(() {
      processList = tempProcessList;
    });
    print(processList);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buidAppBar(),
      body: Stack(children: [
        Expanded(
            child: ListView(
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 15,
              ),
              margin: EdgeInsets.only(
                top: 50,
                bottom: 20,
              ),
              child: Text(
                'All Processes',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            if (processList != null)
              for (var process in processList)
                ProcessItem(
                  process: process,
                  onDeleteItem: _deleteItem,
                ),
          ],
        ))
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: updoot,
        child: Icon(Icons.refresh),
      ),
    );
  }

  void _deleteItem(String id) {
    //kill process with id
    Process.killPid(int.parse(id));
    setState(() {
      // processList.removeWhere((process) => process.id == id);
      updoot();
    });
  }

  AppBar _buidAppBar() {
    return AppBar(
      title: const Text('Task Manager'),
      centerTitle: true,
    );
  }
}
