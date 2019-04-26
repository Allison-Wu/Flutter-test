import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:test_app/Routes.dart';
import 'package:test_app/utils/type.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class CheckList extends StatefulWidget {
  List<Task> _taskList;
  CheckList(this._taskList);
  @override
  _checkListState createState() => _checkListState();
}

class _checkListState extends State<CheckList>{
  int _finishedCount = 0;
  TaskType _currentTask = TaskType.TODO;

  static Color dividerColor = Colors.grey;
  static Color _counterFinishedColor = Colors.green;

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
            TextSpan(text:' ${widget._taskList.length} ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
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
          value: widget._taskList.length > 0 ? _finishedCount/ widget._taskList.length : 0,
          backgroundColor: Colors.grey[300],
          valueColor: new AlwaysStoppedAnimation<Color>(_counterFinishedColor),
        ),
      ),
    );
  }

  Widget _buildTaskCounter() {
    _finishedCount = widget._taskList.where((task) => task.taskType == TaskType.DONE).toList().length;
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

  Widget _buildTitle(IconData icon, TaskType type) {
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
        Expanded(child: _buildTitle(Icons.access_time, TaskType.TODO)),
        Expanded(child: _buildTitle(Icons.check_circle_outline, TaskType.DONE)),
        Expanded(child: _buildTitle(Icons.more_horiz, TaskType.ALL)),
      ],
    );
  }

  Widget _listHeader(String listTitle, String listSubtitile) {
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

  void _toggleFinish(int taskIndex) {
    setState(() {
      widget._taskList[taskIndex].taskType =
        (widget._taskList[taskIndex].taskType == TaskType.TODO ? TaskType.DONE : TaskType.TODO);
    });
  }

  Widget _listFinishButton(int taskIndex) {
    return IconButton(
      onPressed: () => _toggleFinish(taskIndex),
      icon: Icon(Icons.check_circle_outline, size: 40),
      color: widget._taskList[taskIndex].taskType ==  TaskType.TODO ? Colors.grey : Colors.green,
    );
  }

  Widget _listTitle(int taskIndex) {
    return Text(
      widget._taskList[taskIndex].name,
      softWrap: true,
      style: TextStyle(
        wordSpacing: 3,
        fontWeight: FontWeight.bold,
        fontSize: 18,
      ),
    );
  }

  Widget _listSubtitle(int taskIndex) {
    return Container (
      padding: EdgeInsets.only(top: 5),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: widget._taskList[taskIndex].isEssential ? 'Essential*' : null,
              style: TextStyle(
                color: Colors.orange,
              ),
            ),
            TextSpan(
              text: widget._taskList[taskIndex].taskType ==  TaskType.TODO ? 'Planning' : 'Done',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _toggleEssential(int taskIndex) {
    setState(() {
      widget._taskList[taskIndex].isEssential = !widget._taskList[taskIndex].isEssential;
    });
  }

  Widget _listEssentialButton(int taskIndex) {
    return IconButton(
      onPressed: () => _toggleEssential(taskIndex),
      icon: Icon(Icons.assistant_photo),
      color: widget._taskList[taskIndex].isEssential ? Colors.orange : Colors.grey,
    );
  }

  Widget _listItem(int taskIndex) {
    return Slidable(
      delegate: new SlidableDrawerDelegate(),
      actionExtentRatio: 0.25,
      child: ListTile(
        leading: _listFinishButton(taskIndex),
        title: _listTitle(taskIndex),
        subtitle: _listSubtitle(taskIndex),
        trailing: _listEssentialButton(taskIndex),
      ),
      secondaryActions: <Widget>[
        IconSlideAction(
          caption: 'Delete',
          color: Colors.red,
          icon: Icons.delete,
          onTap: () => {
            setState(() {
              widget._taskList.removeAt(taskIndex);
            })
          },
        ),
      ],
    );
  }

  List<Widget> _taskListContent() { 
    List<Widget> _componentList = [];
    widget._taskList.sort((a, b) => a.timing.compareTo(b.timing));
    String insertedTitle;
    for( int index = 0 ; index < widget._taskList.length; index++ ) {
      Task task = widget._taskList[index];
      if (_currentTask == TaskType.ALL || task.taskType == _currentTask) {
        if (task.timing != insertedTitle) {
          _componentList.add(_listHeader(task.timing, '(form 10 to 12 month)'));
        }
        _componentList.addAll([
          _listItem(index),
          Divider(),
        ]);
        insertedTitle = task.timing;
      }
    }
    return _componentList;
  }

  Widget _buildTypeList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: _taskListContent(),
    );
  }

  void _toggleAddTaskNavigation(BuildContext originContext) {
    Navigator.of(context).pushNamed(Routes.newTaskRoute).then((value) {
      if (value != null) {
        widget._taskList.add(value);
      }
    });
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
