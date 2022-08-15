import 'package:flutter/material.dart';
import 'package:kukbuk/widgets/drawer.dart';
import 'package:kukbuk/widgets/gas_mark_converter..dart';
import 'package:kukbuk/widgets/mass_converter.dart';
import 'package:kukbuk/widgets/volume_converter.dart';
import 'package:mdi/mdi.dart';

class CalculatorView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Unit converters"),
          bottom: TabBar(
            labelColor: Colors.blue[50],
            indicatorColor: Colors.white,
            tabs: [
              Tab(
                icon: Icon(Mdi.bottleSoda),
                text: "Volume",
              ),
              Tab(
                icon: Icon(Mdi.weightKilogram),
                text: "Mass",
              ),
              Tab(
                icon: Icon(Mdi.fire),
                text: "Gas mark",
              ),
            ],
          ),
        ),
        drawer: MyAppDrawer(),
        body: TabBarView(
          children: [
            VolumeConverter(),
            MassConverter(),
            GasMarkConverter(),
          ],
        ),
      ),
    );
  }
}
