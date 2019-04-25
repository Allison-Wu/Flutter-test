import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_app/utils/picker.dart';
import 'package:test_app/utils/type.dart';

class AddTaskPage extends StatefulWidget {
  @override
  _addTaskPageState createState() => _addTaskPageState();
}

class _addTaskPageState extends State<AddTaskPage> {
  Task task = new Task();
  final _componentPadding = EdgeInsets.only(top: 20, left: 20, right: 20);

  Widget _buildComponent(List<Widget> children) {
    return Container(
      padding: _componentPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }

  Widget _buildTextField(String hintText, ValueChanged<String> onChanged, {int line}) {
    return TextField(
      keyboardType: TextInputType.multiline,
      maxLines: line,
      style: TextStyle(fontSize: 20),
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black, width: 0.0)),
        border: OutlineInputBorder(borderSide: BorderSide(color: Colors.black, width: 0.0)),
        hintText: hintText,
        hintStyle: TextStyle(fontSize: 20),
      ),
      onChanged: onChanged,
    );
  }

  static Widget _buildTitle(String title) {
  return Container(
    padding: EdgeInsets.only(bottom: 10),
    child: Text(
      title,
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
    ),
  );
}

  Widget _taskName() {
    ValueChanged<String> onChanged = (String text) => task.name = text;
    return _buildComponent([
      _buildTitle('TASK'),
      _buildTextField('Name of the task', onChanged),
    ]);
  }

  Widget _taskTiming() {
    Function(dynamic) onSelected = (dynamic selectedTiming) { task.timing = selectedTiming; };
    return _buildComponent([
      _buildTitle('TIMING'),
      Picker(taskTiming, onSelected, selectedIndex: taskTiming.indexOf(task.timing)),
    ]);
  }

  Widget _taskCategory() {
    Function(dynamic) onSelected = (dynamic selectedCatorgary) { task.catorgary = selectedCatorgary; };
    return _buildComponent([
      _buildTitle('CATEGORY'),
      Picker(taskCatorgary, onSelected, selectedIndex: taskCatorgary.indexOf(task.catorgary)),
    ]);
  }

  Widget _taskDescription() {
    ValueChanged<String> onChanged = (String text) => task.desctiption = text;
    return _buildComponent([
      _buildTitle('DESCRIPTION'),
      _buildTextField('Description of the task', onChanged, line: 6),
    ]);
  }

  Widget _saveButton() {
    return _buildComponent([
      SizedBox(
        width: double.infinity,
        child: MaterialButton(
          padding: EdgeInsets.all(10),
          child: Text('Save changes', style: TextStyle(fontSize: 20),),
          color: Colors.blue[200],
          splashColor: Colors.green[200],
          onPressed: () => {
            Navigator.of(context).pop(task)
          },
        ),
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('NEW TASK'),
      ),
      body: ListView(
        children: <Widget>[
          _taskName(),
          _taskTiming(),
          _taskCategory(),
          _taskDescription(),
          _saveButton(),
        ],
      ),
    );
  }

}
