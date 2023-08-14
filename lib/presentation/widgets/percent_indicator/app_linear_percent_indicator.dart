import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class AppLinearPercentIndicator extends StatelessWidget {
  final double lineHeight;
  final double percent;
  final Color backgroundColor;
  final Color? progressColor;
  final Widget? trailing;
  final EdgeInsets padding;

  const AppLinearPercentIndicator(
      {super.key,
      this.lineHeight = 14.0,
      this.percent = 0.5,
      this.backgroundColor = Colors.grey,
      this.progressColor,
      this.padding = const EdgeInsets.all(8),
      this.trailing});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(ScreenUtil().setWidth(8)),
      child: LinearPercentIndicator(
        animateFromLastPercent: true,
        lineHeight: lineHeight,
        percent: percent,
        backgroundColor: Colors.grey,
        progressColor: Theme.of(context).primaryColor,
        trailing: trailing,
        animation: true,
        animationDuration: 1000,
        barRadius: Radius.circular(ScreenUtil().setWidth(8)),
      ),
    );
  }
}