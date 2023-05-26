import 'package:flutter/material.dart';
import 'package:flutter_challenge/models/dropdown_model.dart';
import 'package:flutter_challenge/utils/global_data.dart';

class AppDropdown extends StatefulWidget {
  const AppDropdown({super.key});

  @override
  State<AppDropdown> createState() => _AppDropdownState();
}

class _AppDropdownState extends State<AppDropdown> {
  final List<String> defaultData = ['5', '10', '20', '30'];
  late String dropdownValue = defaultData[0];
  var ref = GlobalData();

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      value: DropDownModel.get_last_selected_value(),
      icon: const Icon(
        Icons.arrow_downward,
        color: Colors.blueGrey,
      ),
      elevation: 16,
      style: TextStyle(color: Colors.white),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      items: defaultData.map((item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(
            '${item}',
            style: TextStyle(color: Colors.blueGrey, fontSize: 20),
          ),
        );
      }).toList(),
      onChanged: (val) {
        setState(() {
          int numberVal = int.parse(val.toString());
          ref.refreshEvery = numberVal;
          DropDownModel.last_selected_value = val;
          print('ref refresh');
          print(ref.refreshEvery);
          print('ini number val');
          print(numberVal);
          dropdownValue = val.toString();
        });
      },
    );
  }
}
