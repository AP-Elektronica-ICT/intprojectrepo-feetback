import 'package:flutter/material.dart';

import 'package:feetback/screens/jumpHistory/enums/sort_state.dart';

class JumpHistoryPopup extends StatefulWidget {

  final void Function(SortState) onSelected;

  JumpHistoryPopup({
    @required this.onSelected,
  });

  @override
  _JumpHistoryPopupState createState() => _JumpHistoryPopupState();
}

class _JumpHistoryPopupState extends State<JumpHistoryPopup> {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<SortState>(
              onSelected: widget.onSelected,
              itemBuilder: (BuildContext context) =>
                  <PopupMenuEntry<SortState>>[
                const PopupMenuItem<SortState>(
                  value: SortState.date,
                  child: Text('By date'),
                ),
                const PopupMenuItem<SortState>(
                  value: SortState.height,
                  child: Text('By height'),
                ),
                const PopupMenuItem<SortState>(
                  value: SortState.dayHeight,
                  child: Text('By day and height'),
                ),
              ], icon:  Icon(Icons.sort,)
            );  
  }
}