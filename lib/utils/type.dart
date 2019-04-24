class Task {
  String name;
  String timing;
  String catorgary;
  String desctiption;
  TaskType taskType;
  bool isEssential;

  Task({
    this.name,
    this.timing,
    this.catorgary,
    this.taskType= TaskType.TODO,
    this.desctiption,
    this.isEssential = false,
  });
}

enum TaskType {
  TODO,
  DONE,
  ALL,
}

final List<String> taskTiming = ['Before Jan 2019', 'Before Feb 2019', 'Before Mar 2019'];
final List<String> taskCatorgary = ['wedding', 'testing', 'deploying'];
