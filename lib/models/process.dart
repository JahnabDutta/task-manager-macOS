import 'dart:io';
import 'dart:convert';

class RunningProcess {
  final String id;
  final String name;
  final String cpu_usgae;
  final String time_elapsed;

  RunningProcess({
    required this.id,
    required this.name,
    required this.cpu_usgae,
    required this.time_elapsed,
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
        name: temp[i][1],
        cpu_usgae: temp[i][2],
        time_elapsed: temp[i][3],
      ));
    }
    res.sort((a, b) => b.cpu_usgae.compareTo(a.cpu_usgae));
    //return temp;
    //for (var i = 0; i < res.length; i++) {
    //  print(res[i].id);
    //  print(res[i].name);
    //}
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
  //linux command to get process list along with their id and cpu usage, time of activation
  var process = await Process.run('ps', ['-eo', 'pid,comm,%cpu,etime']);

  var str = process.stdout;
  var lines = LineSplitter().convert(str);
  var res = List<List<String>>.empty(growable: true);
  lines.removeAt(0);
  for (var line in lines) {
    var split = line.split(' ');
    //remove empty strings in split
    split.removeWhere((element) => element == '');
    if(split.length != 4)
            continue;
    var pid = split[0];
    var dump = await Process.run('ps', ['-p', pid, '-o', 'comm=']);
    var name = ff(dump.stdout);
    var cpu_usage = split[2];
    var time = split[3];
    var temp = List<String>.empty(growable: true);
    temp.add(pid);
    temp.add(name);
    temp.add(cpu_usage);
    temp.add(time);

    res.add(temp);
  }
  return res;
}

String ff(String a){
        //return longest suffix without slash
        var split = a.split('/');
        return split[split.length-1];
}
String f(String a) {
  if (a[0] != '/') {
    return a;
  }
  String res = '';
  for (int i = a.length - 1; a[i] != '/'; i--) {
    res = a[i] + res;
  }
  //print("res is " + res);
  return res;
}
