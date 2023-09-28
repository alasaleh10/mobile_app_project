// import 'package:dropdown_search/dropdown_search.dart';
// import 'package:flutter/material.dart';

// class test extends StatefulWidget {
//   const test({super.key});

//   @override
//   State<test> createState() => _testState();
// }

// class _testState extends State<test> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: Column(
//         children: [
//           DropdownSearch<String>(
//             popupProps: PopupProps.menu(
//               showSelectedItems: true,
//               disabledItemFn: (String s) => s.startsWith('I'),
//             ),
//             items: ["Brazil", "Italia (Disabled)", "Tunisia", 'Canada'],
//             dropdownDecoratorProps: DropDownDecoratorProps(
//               dropdownSearchDecoration: InputDecoration(
//                 labelText: "Menu mode",
//                 hintText: "country in menu mode",
//               ),
//             ),
//             onChanged: print,
//             selectedItem: "Brazil",
//           )
//         ],
//       ),
//     );
//   }
// }
