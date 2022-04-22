import 'package:flutter/material.dart';
import 'package:survey/components/loader.dart';
import 'package:survey/utils/colors.dart';
import 'package:survey/utils/constants.dart';

class KButton extends StatelessWidget {
  final String label;
  final Color? backgroundColor;
  final Color? labelColor;
  final Color? outlineColor;
  final bool? isLoading;
  final VoidCallback onPressed;

  const KButton(
      {Key? key,
      required this.label,
      this.backgroundColor,
      this.labelColor,
      this.outlineColor,
      this.isLoading = false,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: TextButton(
        onPressed: onPressed,
        child: isLoading == true ?
        const KLoader() :
        Text(
          label,
          style: Theme.of(context)
              .textTheme
              .subtitle2
              ?.copyWith(color: labelColor ?? AppColors.appColorPrimaryLight),
        ),
        style: TextButton.styleFrom(
            primary: labelColor ?? AppColors.appColorPrimaryLight,
            backgroundColor: backgroundColor ?? AppColors.appColorPrimary,
            shape: RoundedRectangleBorder(
                side: BorderSide(
                    color: outlineColor ?? AppColors.appColorPrimary, width: 1),
                borderRadius:
                    BorderRadius.circular(AppConstants.spacing_standard))),
      ),
    );
  }
}
