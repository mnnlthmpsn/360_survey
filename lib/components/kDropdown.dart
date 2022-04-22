import 'package:flutter/material.dart';
import 'package:survey/utils/colors.dart';
import 'package:survey/utils/constants.dart';

class KDropdown extends StatefulWidget {
  final String label;
  final List<Map<String, dynamic>> items;

  const KDropdown({Key? key, required this.label, required this.items})
      : super(key: key);

  @override
  State<KDropdown> createState() => _KDropdownState();
}

class _KDropdownState extends State<KDropdown> {

  bool filled = true;
  String _selectedValue = "";

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FormField(builder: (FormFieldState<String> state) {
        return InputDecorator(
          decoration: InputDecoration(
              floatingLabelBehavior: filled
                  ? FloatingLabelBehavior.never
                  : FloatingLabelBehavior.auto,
              label: Text(widget.label, style: Theme.of(context).textTheme.subtitle2),
              fillColor: AppColors.appLayoutBackground,
              filled: filled,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              errorBorder: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(AppConstants.spacing_standard),
                  borderSide: const BorderSide(color: Colors.red, width: .8)),
              enabledBorder: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(AppConstants.spacing_standard),
                  borderSide: BorderSide.none),
              focusedBorder: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(AppConstants.spacing_standard),
                  borderSide: const BorderSide(
                      color: AppColors.appColorPrimary, width: 1.4))),
          isEmpty: _selectedValue == "",
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: _selectedValue == "" ? null : _selectedValue,
              isDense: true,
              style: Theme.of(context).textTheme.subtitle2,
              onChanged: (String? newValue) {
                setState(() => _selectedValue = newValue!);
                state.didChange(newValue!);
              },
              items: widget.items.map((value) {
                return DropdownMenuItem<String>(
                    value: value['value'], child: Text(value['key']));
              }).toList(),
            ),
          ),
        );
      }),
    );
  }
}
