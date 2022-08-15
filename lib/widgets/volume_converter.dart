import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kukbuk/blocs/settings_provider.dart';
import 'package:kukbuk/blocs/volume_unit_converter_provider.dart';
import 'package:kukbuk/kukbukAppTheme.dart';
import 'package:kukbuk/widgets/my_card_container.dart';
import 'package:provider/provider.dart';

class VolumeConverter extends StatefulWidget {
  @override
  _VolumeConverterState createState() => _VolumeConverterState();
}

class _VolumeConverterState extends State<VolumeConverter> {
  /* BannerAd? banner;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final adState = Provider.of<AdState>(context);
    adState.initialization.then((status) {
      setState(() {
        banner = BannerAd(
          adUnitId: adState.bannerAdUnitThree,
          size: AdSize.banner,
          request: AdRequest(),
          listener: adState.adListener,
        )..load();
      });
    });
  }*/

  @override
  Widget build(BuildContext context) {
    var settingsProvider = Provider.of<SettingsProvider>(context);
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // ============
          // TEXTFIELD
          //===========
          MyCardContainer(
            //   preferedElevation: 8.0,
            child: Consumer<VolumeUnitConverterProvider>(
              builder: (context, bloc, child) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      //         SectionHeadingText(title: "Volume"),
                      /*         SectionHeadingText(
                        title: "Volume converter",
                        alignment: Alignment.center,
                      ), */
                      SizedBox(
                        height: 16.0,
                      ),
                      TextField(
                        style: KukbukAppTheme.textFieldTextStyle,
                        controller: bloc.textEditingControllerTextFieldOne,

                        onChanged: (value) {
                          print("On changed: $value");

                          bloc.getEquivalenceResult();
                        },

                        maxLength: 12,
                        showCursor: false,
                        enableInteractiveSelection: true,
                        // autofocus: true,
                        decoration: settingsProvider.themeMode == true
                            ? KukbukAppTheme.getTextFieldDarkDecoration(context)
                            : KukbukAppTheme.getTextFieldLightDecoration(
                                context),
                        //  cursorHeight: 100.0,

                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true,
                          signed: false,
                        ),

                        textDirection: TextDirection.rtl,
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 16.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            DropdownButton<String>(
                                underline: Container(
                                  height: 2,
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                ),
                                items: bloc.volumeUnitsList
                                    .map((String unitOfVolume) {
                                  return new DropdownMenuItem<String>(
                                    value: unitOfVolume,
                                    child: new Text(
                                      unitOfVolume,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  );
                                }).toList(),
                                value: bloc.selectedUnitA,
                                icon: Icon(
                                  Icons.arrow_drop_down,
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                ),
                                onChanged: (String? value) {
                                  bloc.selectedUnitA = value;
                                  bloc.getEquivalenceResult();
                                }),

                            Icon(
                              Icons.arrow_forward,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                            /*     Text(
                              "To:",
                              style: TextStyle(
                                fontWeight: FontWeight.w800,
                              ),
                            ),
 */
                            // ==============================
                            // SECOND DROPDOWN LIST
                            //===============================

                            DropdownButton<String>(
                                underline: Container(
                                  height: 2,
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                ),
                                items: bloc.volumeUnitsList
                                    .map((String unitOfVolume) {
                                  return new DropdownMenuItem<String>(
                                    value: unitOfVolume,
                                    child: new Text(
                                      unitOfVolume,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  );
                                }).toList(),
                                value: bloc.selectedUnitB,
                                icon: Icon(
                                  Icons.arrow_drop_down,
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                ),
                                onChanged: (String? value) {
                                  bloc.selectedUnitB = value;
                                  bloc.getEquivalenceResult();
                                }),
                          ],
                        ),
                      ),
                      TextField(
                        controller: bloc.textEditingControllerTextFieldTwo,
                        style: KukbukAppTheme.textFieldTextStyle,
                        maxLength: 12,

                        readOnly: true,
                        decoration: settingsProvider.themeMode == true
                            ? KukbukAppTheme.getTextFieldDarkDecoration(context)
                            : KukbukAppTheme.getTextFieldLightDecoration(
                                context),
                        //  cursorHeight: 100.0,
                        keyboardType: TextInputType.numberWithOptions(
                          decimal: true,
                          signed: false,
                        ),
                        textDirection: TextDirection.rtl,
                      ),
                    ],
                  ),
                );
              }, // end Consumer builder
            ),
          ),
        ],
      ),
    );
  }
}
