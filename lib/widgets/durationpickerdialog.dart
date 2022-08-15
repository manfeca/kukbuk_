import 'dart:ui';

import 'package:flutter/material.dart';
import '../blocs/recipe_form_provider.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class DurationPickerWidget extends StatelessWidget {
  String? selectedDuration;

  final List _hoursList = [
    "0",
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
    "9",
    "10",
    "11",
    "12",
    "13",
    "14",
    "15",
    "16",
    "17",
    "18",
    "19",
    "20",
    "21",
    "22",
    "23"
  ];

  final List _minutesList = [
    "00",
    "05",
    "10",
    "15",
    "20",
    "25",
    "30",
    "35",
    "40",
    "45",
    "50",
    "55",
  ];

  String _currentHour = "0";
  String _currentMinute = "00";

  String? duration;

  _updateDuration() {
    if (_currentHour == "0") {
      duration = " " + _currentMinute + "'";
    } else {
      duration = _currentHour + ":" + _currentMinute + "'";
    }
    print(duration);
  }

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<RecipeFormProvider>(context);

    return AlertDialog(
      semanticLabel: "Duration picker",
      title: Text(
        "Set cooking time",
        textAlign: TextAlign.left,
      ),
      titlePadding: EdgeInsets.only(left: 16.0, top: 16.0),
      content: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(
          left: 4.0,
          right: 4.0,
        ),
        height: 100.0,
        width: MediaQuery.of(context).size.width,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            Expanded(
              child: Container(
                alignment: Alignment.centerRight,
                child: PageView.builder(
                  onPageChanged: (value) {
                    _currentHour = _hoursList[value];
                  },
                  itemCount: _hoursList.length,
                  scrollDirection: Axis.vertical,
                  controller: new PageController(
                    viewportFraction: 0.6,
                  ),
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Container(
                      height: 100.0,
                      alignment: Alignment.centerRight,
                      child: Text(
                        _hoursList[index],
                        style: TextStyle(
                          //  color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.w400,
                          fontSize: 40.0,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              child: Text(" : ",
                  style: TextStyle(
                    fontSize: 50.0,
                    fontWeight: FontWeight.w600,
                    //     color: Theme.of(context).primaryColor,
                  )),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.centerLeft,
                child: PageView.builder(
                  allowImplicitScrolling: true,
                  onPageChanged: (value) {
                    _currentMinute = _minutesList[value];
                  },
                  itemCount: _minutesList.length,
                  scrollDirection: Axis.vertical,
                  controller: new PageController(
                    viewportFraction: 0.6,
                  ),
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index2) {
                    // _currentMinute = _minutesList[index2];

                    return Container(
                      height: 100.0,
                      width: 40.0,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        _minutesList[index2],
                        style: TextStyle(
                          //    color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.w400,
                          fontSize: 40.0,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            Spacer(),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            "CANCEL",
          ),
        ),
        TextButton(
          onPressed: () {
            _updateDuration();
            bloc.selectedDuration = duration;
            Navigator.pop(context, duration);
          },
          child: Text(
            "SET",
          ),
        ),
      ],
    );
  }
}
