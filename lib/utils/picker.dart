import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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

  Widget _pickerContent(){
    _locatedIndex = _locatedIndex?? 0;
    return Container(
      child: DefaultTextStyle(
        style: const TextStyle(
          color: CupertinoColors.black,
          fontSize: 22.0,
        ),
        child: GestureDetector(
          child: SafeArea(
            top: false,
            child: CupertinoPicker(
              scrollController: FixedExtentScrollController(initialItem: _locatedIndex),
              itemExtent: 32.0,
              backgroundColor: CupertinoColors.extraLightBackgroundGray,
              onSelectedItemChanged: (int index) {
                setState(() => _locatedIndex = index);
              },
              children: List<Widget>.generate(widget._itemList.length, (int index) {
                return Center(child: Text(widget._itemList[index].toString()));
              }),
            ),
          ),
        ),
      ),
    );
  }

  Widget _pickerButton(String text, VoidCallback onPressed) {
    return CupertinoButton(
      child: Text(
        text,
        style: TextStyle(
          fontSize: 20,
        ),
      ),
      onPressed: onPressed,
    );
  }

  Widget _pickerOptionRow() {
    VoidCallback _toggleCancel = () => { Navigator.of(context).pop() };
    VoidCallback _toggleChoose = () => {
      setState(() => {
        widget.selectedIndex = _locatedIndex,
        widget._setSelectedValue(widget._itemList[widget.selectedIndex]),
        Navigator.of(context).pop(),
      })
    };
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        _pickerButton('Cancel', _toggleCancel),
        _pickerButton('Choose', _toggleChoose),
      ],
    );
  }

  Widget _buildBottomPicker(Widget pickerContent) {
    return Container(
      height: 300.0,
      color: CupertinoColors.extraLightBackgroundGray,
      child: Column(
        children: <Widget>[
          _pickerOptionRow(),
          Expanded(
            child: _pickerContent(),
          ),
        ],
      ),
    );
  }

  void _toggleBottomPicker() async {
    await showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) {
        return _buildBottomPicker(_pickerContent());
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isSeleted = widget.selectedIndex != -1;
    return GestureDetector(
      onTap: () => _toggleBottomPicker(),
      child: Container(
      decoration: BoxDecoration(
        color: CupertinoTheme.of(context).scaffoldBackgroundColor,
        border: Border.all(color: (isSeleted? Colors.black : Colors.grey), width: 0.0),
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
                  isSeleted ? widget._itemList[widget.selectedIndex].toString() : _defaultValue,
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
