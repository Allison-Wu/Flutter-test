// Widget _buildMenu(List<Widget> children) {
//     return Container(
//       decoration: BoxDecoration(
//         color: CupertinoTheme.of(context).scaffoldBackgroundColor,
//         border: const Border(
//           top: BorderSide(color: Color(0xFFBCBBC1), width: 0.0),
//           bottom: BorderSide(color: Color(0xFFBCBBC1), width: 0.0),
//         ),
//       ),
//       height: 44.0,
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 16.0),
//         child: SafeArea(
//           top: false,
//           bottom: false,
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: children,
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildBottomPicker(Widget picker) {
//     return Container(
//       height: _kPickerSheetHeight,
//       padding: const EdgeInsets.only(top: 6.0),
//       color: CupertinoColors.white,
//       child: DefaultTextStyle(
//         style: const TextStyle(
//           color: CupertinoColors.black,
//           fontSize: 22.0,
//         ),
//         child: GestureDetector(
//           // Blocks taps from propagating to the modal sheet and popping.
//           onTap: () { },
//           child: SafeArea(
//             top: false,
//             child: picker,
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildColorPicker(BuildContext context) {
//     final FixedExtentScrollController scrollController =
//         FixedExtentScrollController(initialItem: _selectedColorIndex);

//     return GestureDetector(
//       onTap: () async {
//         await showCupertinoModalPopup<void>(
//           context: context,
//           builder: (BuildContext context) {
//             return _buildBottomPicker(
//               CupertinoPicker(
//                 scrollController: scrollController,
//                 itemExtent: _kPickerItemHeight,
//                 backgroundColor: CupertinoColors.white,
//                 onSelectedItemChanged: (int index) {
//                   setState(() => _selectedColorIndex = index);
//                 },
//                 children: List<Widget>.generate(coolColorNames.length, (int index) {
//                   return Center(child:
//                   Text(coolColorNames[index]),
//                   );
//                 }),
//               ),
//             );
//           },
//         );
//       },
//       child: _buildMenu(
//         <Widget>[
//           const Text('Favorite Color'),
//           Text(
//             coolColorNames[_selectedColorIndex],
//             style: const TextStyle(
//                 color: CupertinoColors.inactiveGray
//             ),
//           ),
//         ],
//       ),
//     );
//   }
