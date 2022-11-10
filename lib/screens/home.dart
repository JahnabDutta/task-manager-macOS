import 'package:flutter/material.dart';
import '../models/process.dart';
import '../widgets/process_item.dart';
import 'dart:io';
import 'dart:convert';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final processList = RunningProcess.processList();

  @override
  void initState() {
    super.initState();
    print("hello");

    ; //call it over here
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
              for (RunningProcess process in processList)
                ProcessItem(
                  process: process,
                )
            ],
          ))
        ]));
  }

  AppBar _buidAppBar() {
    return AppBar(
      title: const Text('Task Manager'),
      centerTitle: true,
    );
  }
}

void addProcess() {
  var processes = Process.runSync('ls', ['-l']);
  print(processes.stdout);
}
