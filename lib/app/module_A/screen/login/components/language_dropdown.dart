import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../bloc/theme/theme_bloc.dart';
import '../../../../../localization/LocaleService.dart';
import '../../../model/language_data.dart';
import '../../../../../localization/language/languages.dart';

class LanguageDropDown extends StatefulWidget {
  LanguageDropDown({Key? key}) : super(key: key);

  @override
  _LanguageDropDownState createState() => _LanguageDropDownState();
}

class _LanguageDropDownState extends State<LanguageDropDown> {
  // List of items in our dropdown menu
  var items = LanguageData.languageList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.red,
            blurRadius: 4,
            offset: Offset(4, 8),
          ),
        ],
        color: Colors.amber,
        border: Border.all(
          color: Colors.black,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(12),
        // shape: BoxShape.circle,
      ),
          child: DropdownButton<LanguageData>(
            hint: Text(Languages.of(context).labelSelectLanguage),
            onChanged: (LanguageData? language) {
              changeLanguage(context, language!.languageCode, language!.countryCode! );
            },
            items: items
                .map<DropdownMenuItem<LanguageData>>(
                  (item) => DropdownMenuItem<LanguageData>(
                    value: item,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Text(
                          item.flag,
                          style: TextStyle(fontSize: 20),
                        ),
                        Text(item.name)
                      ],
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}
