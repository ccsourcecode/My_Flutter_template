// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../../bloc/theme/theme_bloc.dart';
// import '../../../../../localization/locale_constant.dart';
// import '../../../model/language_data.dart';
// import '../../../../../localization/language/languages.dart';

// class LanguageDropDown extends StatefulWidget {
//   LanguageDropDown({Key? key}) : super(key: key);

//   @override
//   _LanguageDropDownState createState() => _LanguageDropDownState();
// }

// class _LanguageDropDownState extends State<LanguageDropDown> {
//   // List of items in our dropdown menu
//   var items = LanguageData.languageList();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: DropdownButton<LanguageData>(
//         hint: Text(Languages.of(context).labelSelectLanguage),
//         onChanged: (LanguageData? language) {
//           changeLanguage(context, language!.languageCode);
//         },
//         items: items
//             .map<DropdownMenuItem<LanguageData>>(
//               (item) => DropdownMenuItem<LanguageData>(
//                 value: item,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: <Widget>[
//                     Text(
//                       item.flag,
//                       style: TextStyle(fontSize: 20),
//                     ),
//                     Text(item.name)
//                   ],
//                 ),
//               ),
//             )
//             .toList(),
//       ),
//     );
//   }
// }
