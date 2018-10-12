
import 'package:flutter/material.dart';

class DatePicker extends StatefulWidget {
  @override
  _DatePickerState createState() => new _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  DateTime _date;

  @override
  Widget build(BuildContext context) {
    return new FlatButton(
      child: new Text(
        _date == null ? 'PICK DATE' : _date.toString(),
      ),
      textColor: Theme.of(context).accentColor,
      onPressed: () async {
        var date = await showDatePicker(
          context: context,
          initialDate: new DateTime.now(),
          firstDate: new DateTime.now().add(new Duration(days: -20)),
          lastDate: new DateTime.now().add(new Duration(days: 300)),
        );

        setState(() => _date = date);
      },
    );
  }
}
