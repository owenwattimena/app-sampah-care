import 'package:flutter/material.dart';
import 'package:flutter_app/bootstrap/extensions.dart';
import 'package:nylo_framework/nylo_framework.dart';

import '../../bootstrap/helpers.dart';

class StatusCardWidget extends StatelessWidget {
  final int total;
  final String title;
  final Function()? onTap;
  const StatusCardWidget({required this.title,required  this.total, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 70,
          decoration: BoxDecoration(
            color: ThemeColor.get(context).primaryAccent,
            borderRadius:BorderRadius.circular(5)
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('$total').titleLarge(context).setColor(context, (color) => ThemeColor.get(context).background),
              Text('$title').setColor(context, (color) => ThemeColor.get(context).background),
            ],
          ),
        ),
      ),
    );
  }
}
