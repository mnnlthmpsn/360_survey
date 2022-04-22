import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:survey/utils/colors.dart';
import 'package:survey/utils/constants.dart';
import 'package:survey/utils/helpers.dart';

PreferredSizeWidget KAppBar(String title, String subtitle) {
  return AppBar(
    elevation: 0,
    backgroundColor: Colors.transparent,
    automaticallyImplyLeading: false,
    foregroundColor: AppColors.appTextColorPrimary,
    toolbarHeight: 80,
    title: Builder(builder: (BuildContext context) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          IconButton(onPressed: () => goBack(context), icon: const Icon(Icons.chevron_left)),
          const SizedBox(width: AppConstants.spacing_large),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: AppConstants.spacing_middle),
              Text(title, style: Theme.of(context).textTheme.headline6,),
              Text(subtitle, style: Theme.of(context).textTheme.subtitle2,)
            ],
          )
        ],
      );
    })
  );
}