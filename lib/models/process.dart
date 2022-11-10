

class RunningProcess {
  final String id;
  final String name;

  RunningProcess({
    required this.id,
    required this.name,
  });

  static List<RunningProcess> processList() {
    return [
      RunningProcess(id: '01', name: 'P1'),
      RunningProcess(id: '02', name: 'P2'),
      RunningProcess(id: '03', name: 'P3'),
      RunningProcess(id: '04', name: 'P4'),
      RunningProcess(id: '05', name: 'P5'),
    ];
  }
}
