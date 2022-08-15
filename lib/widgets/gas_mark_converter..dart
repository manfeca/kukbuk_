import 'package:flutter/material.dart';
import 'package:kukbuk/blocs/gas_mark_provider.dart';
import 'package:kukbuk/blocs/settings_provider.dart';
import 'package:kukbuk/kukbukAppTheme.dart';
import 'package:kukbuk/widgets/my_card_container.dart';
import 'package:kukbuk/widgets/section_heading_text.dart';
import 'package:provider/provider.dart';

class GasMarkConverter extends StatefulWidget {
  @override
  _GasMarkConverter createState() => _GasMarkConverter();
}

class _GasMarkConverter extends State<GasMarkConverter> {
  /*BannerAd? banner;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final adState = Provider.of<AdState>(context);
    adState.initialization.then((status) {
      setState(() {
        banner = BannerAd(
          adUnitId: adState.bannerAdUnitFive,
          size: AdSize.banner,
          request: AdRequest(),
          listener: adState.adListener,
        )..load();
      });
    });
  }
*/
  @override
  Widget build(BuildContext context) {
    final settingsProvider = Provider.of<SettingsProvider>(context);

    return SingleChildScrollView(
      child: Column(
        children: [
          Consumer<GasMarkProvider>(builder: (context, bloc, child) {
            return MyCardContainer(
              //    preferedElevation: 8.0,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    //      SectionHeadingText(title: "Gas Mark"),

                    /*       SectionHeadingText(title: "Gas mark"), */
                    Container(
                      //   width: MediaQuery.of(context).size.width / 3.0,
                      //    margin: EdgeInsets.symmetric(vertical: 4.0),

                      child: DropdownButton<String>(
                          underline: Container(
                            height: 2,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                          elevation: 6,
                          //  isExpanded: true,
                          items: bloc.gasMarkList.map((String gasMarkUnit) {
                            return new DropdownMenuItem<String>(
                              value: gasMarkUnit,
                              child: Container(
                                alignment: Alignment.center,
                                child: new Text(
                                  gasMarkUnit,
                                  textAlign: TextAlign.center,
                                  style: KukbukAppTheme.textFieldTextStyle,
                                ),
                              ),
                            );
                          }).toList(),
                          value: bloc.selectedGasMark,
                          icon: Icon(
                            Icons.arrow_drop_down,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                          onChanged: (String? value) {
                            bloc.selectedGasMark = value;
                          }),
                    ),
                    /*     SizedBox(
                      height: 16.0,
                    ), */
                    SectionHeadingText(title: "Fahrenheit/Celsius"),
                    Container(
                      margin:
                          EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.symmetric(
                          vertical: 16.0, horizontal: 16.0),
                      decoration: settingsProvider.themeMode == true
                          ? KukbukAppTheme.getTextFieldLikeDecorationDark(
                              context)
                          : KukbukAppTheme.getTextFieldLikeDecorationLight(
                              context),
                      alignment: Alignment.center,
                      child: Text(
                        "${bloc.fahrenheit}\u2109 / ${bloc.celsius}\u2103",
                        style: KukbukAppTheme.textFieldTextStyle,
                      ),
                    ),
                    /*     SizedBox(
                      height: 16.0,
                    ), */
                    SectionHeadingText(title: "Descriptive"),
                    Container(
                      margin:
                          EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.symmetric(
                          vertical: 16.0, horizontal: 16.0),
                      alignment: Alignment.center,
                      decoration: settingsProvider.themeMode == true
                          ? KukbukAppTheme.getTextFieldLikeDecorationDark(
                              context)
                          : KukbukAppTheme.getTextFieldLikeDecorationLight(
                              context),
                      child: Text(
                        "${bloc.descriptive}",
                        style: KukbukAppTheme.textFieldTextStyle,
                      ),
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
