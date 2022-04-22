import 'package:flutter/material.dart';
import 'package:survey/utils/colors.dart';
import 'package:survey/utils/constants.dart';

class KTextInput extends StatefulWidget {
  final String label;
  final TextInputAction? textInputAction;
  final TextInputType? textInputType;
  final bool? isPassword;
  final TextEditingController? controller;

  const KTextInput(
      {Key? key,
      this.textInputAction,
      this.textInputType,
      this.isPassword = false,
      required this.label, this.controller})
      : super(key: key);

  @override
  State<KTextInput> createState() => _KTextInputState();
}

class _KTextInputState extends State<KTextInput> {
  bool filled = true;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    super.dispose();
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
  }

  void _onFocusChange() {
    setState(() => filled = !_focusNode.hasFocus);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: widget.controller,
        onTap: () => setState(() => filled = false),
        focusNode: _focusNode,
        style: Theme.of(context).textTheme.subtitle2,
        textInputAction: widget.textInputAction ?? TextInputAction.next,
        keyboardType: widget.textInputType ?? TextInputType.text,
        obscureText: widget.isPassword!,
        decoration: InputDecoration(
            floatingLabelBehavior: filled
                ? FloatingLabelBehavior.never
                : FloatingLabelBehavior.auto,
            label: Text(widget.label),
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
      ),
    );
  }
}
