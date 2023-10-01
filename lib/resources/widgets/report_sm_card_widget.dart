import 'package:flutter/material.dart';
import 'package:flutter_app/bootstrap/extensions.dart';
import 'package:nylo_framework/nylo_framework.dart';

import '../../bootstrap/helpers.dart';

class ReportSmCardWidget extends StatelessWidget {
  final String image, description;
  final DateTime date;
  final String status;
  final Function() onTap;
  const ReportSmCardWidget({this.image = 'public/assets/images/sampah.png', required this.description,required this.status,required this.date, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
            border:
                Border.all(width: 0.3, color: ThemeColor.get(context).textGrey),
            borderRadius: BorderRadius.circular(10)),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              ),
              child: Image.network(
                getEnv('APP_URL') + "/$image",
                width: 70,
                height: 70,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(left: 5),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('${date.toString()}').fontWeightBold(),
                          Text(
                            description,
                            softWrap: false,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ).titleSmall(context).setColor(context,
                              (color) => ThemeColor.get(context).textGrey),
                        ],
                      ),
                      Text(status).titleSmall(context),
                    ]),
              ),
            )
          ],
        ),
      ),
    );
  }
}
