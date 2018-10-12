
import 'package:flutter/material.dart';

class TimePicker extends StatefulWidget {
  @override
  _TimePickerState createState() => new _TimePickerState();
}

class _TimePickerState extends State<TimePicker> {
  TimeOfDay _time;

  @override
  Widget build(BuildContext context) {
    return new FlatButton(
      child: new Text(
        _time == null ? 'PICK TIME' : _time.format(context),
      ),
      textColor: Theme.of(context).accentColor,
      onPressed: () async {
        var time = await showTimePicker(
          context: context,
          initialTime: new TimeOfDay.now(),
        );

        setState(() => _time = time);
      },
    );
  }
}