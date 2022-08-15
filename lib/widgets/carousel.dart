// This widget return a Row of Icon circle
// to use as a guide for a PageView.
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Carousel extends StatelessWidget {
  final int? position;
  final int? carouselSize;
  late List<Widget> _circles;

  Carousel({this.carouselSize, this.position}) {
    _circles = <Widget>[];
    for (int i = 0; i < carouselSize!; i++) {
      if (i == position) {
        _circles.add(
          Wrap(
            children: [
              Icon(
                Icons.circle,
                //      color: Theme.of(context).colorScheme.secondary;,
                size: 10.0,
              ),
              Padding(
                padding: EdgeInsets.only(right: 4.0),
              ),
            ],
          ),
        );
      } else {
        _circles.add(Wrap(
          children: [
            Icon(
              Icons.circle,
              color: Colors.grey[400],
              size: 10.0,
            ),
            Padding(
              padding: EdgeInsets.only(right: 4.0),
            ),
          ],
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    /*  if (carouselSize == 0) {
      return null;
    } */
    return Container(
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width,
      child: Wrap(
        direction: Axis.horizontal,
        alignment: WrapAlignment.center,
        runAlignment: WrapAlignment.center,
        //  mainAxisAlignment: MainAxisAlignment.center,
        //  crossAxisAlignment: CrossAxisAlignment.center,
        children: _circles,
      ),
    );
  }
}
