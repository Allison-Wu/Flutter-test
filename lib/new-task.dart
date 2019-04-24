import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_app/utils/type.dart';

final _borderSideSetting = BorderSide(color: Colors.grey, width: 0.0);

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
        border: OutlineInputBorder(borderSide: _borderSideSetting),
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

class Picker extends StatefulWidget {
  List _itemList;
  int selectedIndex;
  Function(dynamic) _setSelectedValue;
  Picker(this._itemList,  this._setSelectedValue, {this.selectedIndex = -1});
  @override
  _pickerState createState() => _pickerState();
}

class _pickerState extends State<Picker> {
  String _defaultValue = 'Unclassified';
  int _locatedIndex;

  Widget _buildPickerContent(){
    _locatedIndex = _locatedIndex?? 0;
    return CupertinoPicker(
      scrollController: FixedExtentScrollController(initialItem: _locatedIndex),
      itemExtent: 32.0,
      backgroundColor: CupertinoColors.extraLightBackgroundGray,
      onSelectedItemChanged: (int index) {
        setState(() => _locatedIndex = index);
      },
      children: List<Widget>.generate(widget._itemList.length, (int index) {
        return Center(child:
          Text(widget._itemList[index].toString()),
        );
      }),
    );
  }

  void _toggleBottomPicker() async {
    await showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) {
        return _buildBottomPicker(_buildPickerContent());
      },
    );
  }

  Widget _buildBottomPicker(Widget picker) {
    return Container(
      height: 300.0,
      color: CupertinoColors.extraLightBackgroundGray,
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              CupertinoButton(
                child: Text(
                  'Cancel',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                onPressed: () => {
                  Navigator.of(context).pop(),
                },
              ),
              CupertinoButton(
                child: Text(
                  'Choose',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                onPressed: () => {
                  setState(() => {
                    widget.selectedIndex = _locatedIndex,
                    widget._setSelectedValue(widget._itemList[widget.selectedIndex]),
                    Navigator.of(context).pop(),
                  })
                },

              ),
            ],
          ),
          Expanded(
            child: Container(
              child: DefaultTextStyle(
                style: const TextStyle(
                  color: CupertinoColors.black,
                  fontSize: 22.0,
                ),
                child: GestureDetector(
                  // Blocks taps from propagating to the modal sheet and popping.
                  onTap: () { },
                  child: SafeArea(
                    top: false,
                    child: picker,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _toggleBottomPicker(),
      child: Container(
      decoration: BoxDecoration(
        color: CupertinoTheme.of(context).scaffoldBackgroundColor,
        border: Border(
          top: _borderSideSetting,
          bottom: _borderSideSetting,
          left: _borderSideSetting,
          right: _borderSideSetting,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(15),
        child: SafeArea(
          top: false,
          bottom: false,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                  widget.selectedIndex == -1 ? _defaultValue : widget._itemList[widget.selectedIndex].toString(),
                  style: TextStyle(fontSize: 20),
              ),
              Icon(Icons.keyboard_arrow_down, size: 30),
            ],
          ),
        ),
      ),
      ),
    );
  }
}
