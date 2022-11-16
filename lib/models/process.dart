import 'dart:io';
import 'dart:convert';

class RunningProcess {
  final String id;
  final String name;

  RunningProcess({
    required this.id,
    required this.name,
  });

  static Future<List<RunningProcess>> processList() async {
    var res = List<RunningProcess>.empty(growable: true);
    var temp = await addProcess();
    for (var i = 0; i < temp.length; i++) {
      if (temp[i].length < 2 ||
          temp[i][0].length == 0 ||
          temp[i][1].length == 0) continue;
      res.add(RunningProcess(
        id: temp[i][0],
        name: f(temp[i][1]),
      ));
    }
    for (var i = 0; i < res.length; i++) {
      print(res[i].id);
      print(res[i].name);
    }
    // return temp;
    // return [
    //   RunningProcess(id: '01', name: 'P1'),
    //   RunningProcess(id: '02', name: 'P2'),
    //   RunningProcess(id: '03', name: 'P3'),
    //   RunningProcess(id: '04', name: 'P4'),
    //   RunningProcess(id: '05', name: 'P5'),
    // ];
    return res;
  }
}

Future<List<List<String>>> addProcess() async {
  var processes = await Process.run('ps', ['-eo', 'pid,comm']);
  var str = processes.stdout;
  var lines = LineSplitter().convert(str);
  var res = List<List<String>>.empty(growable: true);
  lines.removeAt(0);
  for (var line in lines) {
    var split = line.split(' ');
    var pid = split[0];
    var name = split[1];
    var temp = List<String>.empty(growable: true);
    temp.add(pid);
    temp.add(name);
    res.add(temp);
  }
  return res;
}

String f(String a) {
  if (a[0] != '/') {
    return a;
  }
  String res = '';
  for (int i = a.length - 1; a[i] != '/'; i--) {
    res = a[i] + res;
  }
  print("res is " + res);
  return res;
}
