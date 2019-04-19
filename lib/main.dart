import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:test_app/new-task.dart';
import 'package:test_app/utils/type.dart';

void main() => {
  // debugPaintSizeEnabled = true,
  runApp(MyApp()),
};

enum TaskType {
  TODO,
  DONE,
  ALL,
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CHECKLIST',
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      home: CheckList(),
    );
  }
}

class CheckList extends StatefulWidget {
  @override
  _checkListState createState() => _checkListState();
}

class _checkListState extends State<CheckList>{
  int _finishedCount = 0;
  List<Map> _taskList = [{
    'name': 'Plan an engagement',
    'isEssential': true,
    'taskType': TaskType.TODO,
    'listTitle': taskTiming[0],
  }];
  TaskType _currentTask = TaskType.TODO;

  static Color dividerColor = Colors.grey;
  static Color _counterFinishedColor = Colors.green;
  Task task;

  Widget _counterTitle() {
    return Container(
      padding: EdgeInsets.only(bottom: 13),
      child: RichText(
        text: TextSpan(
          text: 'You have completed',
          style: TextStyle(color: Colors.black, fontSize: 17),
          children: [
            TextSpan(text:' $_finishedCount ', style: TextStyle(color: _counterFinishedColor, fontWeight: FontWeight.bold, fontSize: 20)),
            TextSpan(text:'out of'),
            TextSpan(text:' ${_taskList.length} ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            TextSpan(text:'tasks'),
          ],
        ),
      ),
    );
  }

  Widget _counterProgress() {
    return Container(
      height: 30,
      child: ClipRRect(
        borderRadius: BorderRadius.horizontal(left: Radius.circular(150), right: Radius.circular(150)),
        child: LinearProgressIndicator(
          value: _finishedCount/ _taskList.length,
          backgroundColor: Colors.grey[300],
          valueColor: new AlwaysStoppedAnimation<Color>(_counterFinishedColor),
        ),
      ),
    );
  }

  Widget _buildTaskCounter() {
    _finishedCount = _taskList.where((i) => i['taskType'] == TaskType.DONE).toList().length;
    return Container(
      padding: EdgeInsets.all(15),
      alignment: Alignment.center,
      child: Column(
        children: <Widget>[
          _counterTitle(),
          _counterProgress(),
        ],
      ),
    );
  }

  void _toggleTypeChange(TaskType type) {
    setState(() {
      _currentTask = type;
    });
  }

  Widget _buildTitleItem(IconData icon, TaskType type) {
    String label = 'ERROR';
    switch(type) {
      case TaskType.TODO: {
        label = 'TO DO';
        break;
      }
      case TaskType.DONE: {
        label = 'DONE';
        break;
      }
      case TaskType.ALL: {
        label = 'ALL';
        break;
      }
    }
    return GestureDetector(
      onTap: () => _toggleTypeChange(type),
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: (_currentTask == type ? Colors.blue : Colors.grey),
              width: 3,
            ),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(icon, size: 40,),
            Text(label, style: TextStyle(fontSize: 20)),
          ],
        ),
      ),
    );
  }

  Widget _buildTypeTitle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Expanded(child: _buildTitleItem(Icons.access_time, TaskType.TODO)),
        Expanded(child: _buildTitleItem(Icons.check_circle_outline, TaskType.DONE)),
        Expanded(child: _buildTitleItem(Icons.more_horiz, TaskType.ALL)),
      ],
    );
  }

  void _toggleEssential(Map task) {
    setState(() {
      task['isEssential'] = !task['isEssential'];
    });
  }

  void _toggleFinish(Map task) {
    setState(() {
      task['taskType'] = (task['taskType'] == TaskType.TODO ? TaskType.DONE : TaskType.TODO);
    });
  }

  Widget _buildListHeader(String listTitle, String listSubtitile) {
    return Column(
      children: <Widget>[
        ListTile(
          title: Text(listTitle),
          subtitle: Text(listSubtitile),
        ),
        Divider(),
      ],
    );
  }

  Widget _buildListItem(Map task) {
    return ListTile(
      leading: IconButton(
        onPressed: () => _toggleFinish(task),
        icon: Icon(Icons.check_circle_outline, size: 40),
        color: task['taskType'] ==  TaskType.TODO ? Colors.grey : Colors.green,
      ),
      title: Text(
        task['name'],
        softWrap: true,
        style: TextStyle(
          wordSpacing: 3,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
      subtitle: Container (
        padding: EdgeInsets.only(top: 5),
        child: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: task['isEssential'] ? 'Essential*' : null,
                style: TextStyle(
                  color: Colors.orange,
                ),
              ),
              TextSpan(
                text: task['taskType'] ==  TaskType.TODO ? 'Planning' : 'Done',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ),
      ),
      trailing: IconButton(
        onPressed: () => _toggleEssential(task),
        icon: Icon(Icons.assistant_photo),
        color: task['isEssential'] ? Colors.orange : Colors.grey,
      ),
    );
  }

  List<Widget> _buildTaskListContent() {
    List<Widget> _componentList = [];
    _taskList.sort((a, b) => a['listTitle'].compareTo(b['listTitle']));
    String insertedTitle;
    for(final task in _taskList){
      if (_currentTask == TaskType.ALL || task['taskType'] == _currentTask) {
        if (task['listTitle'] != insertedTitle) {
          _componentList.add(_buildListHeader(task['listTitle'], '(form 10 to 12 month)'));
        }
        _componentList.addAll([
          _buildListItem(task),
          Divider(),
        ]);
        insertedTitle = task['listTitle'];
      }
    }
    return _componentList;
  }

  Widget _buildTypeList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: _buildTaskListContent(),
    );
  }

  void _toggleAddTaskNavigation(BuildContext originContext) async {
    task = await Navigator.of(originContext).push(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return newTaskPage;
        }
      )
    );

    if (task != null) {
      _taskList.add({
        'name': task.name,
        'isEssential': false,
        'taskType': TaskType.TODO,
        'listTitle': task.timing,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.white,
        title: Text('CHECKLIST'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            color: Colors.blue,
            iconSize: 30,
            onPressed: () => _toggleAddTaskNavigation(context),
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          _buildTaskCounter(),
          Divider(color: dividerColor),
          _buildTypeTitle(),
          Divider(color: dividerColor, height: 10),
          _buildTypeList(),
        ],
      ),
    );
  }
}
