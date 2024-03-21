import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mortgage_calc/const/app_styles.dart';
import 'package:mortgage_calc/const/model.dart';
import 'package:mortgage_calc/screens/add_payment.dart';
import 'package:mortgage_calc/screens/details_screen.dart';
import 'package:mortgage_calc/screens/shedule_screen.dart';
import 'package:provider/provider.dart';

class MortgageInfo extends StatefulWidget {
  final String totalCost;
  final String term;
  double alreadyPaid;
  final int mortgageIndex;
  final DateTime date;
  final int rate;
  MortgageInfo({
    Key? key,
    required this.totalCost,
    required this.term,
    required this.alreadyPaid,
    required this.mortgageIndex,
    required this.date,
    required this.rate,
  }) : super(key: key);

  @override
  State<MortgageInfo> createState() => _MortgageInfoState();
}

class _MortgageInfoState extends State<MortgageInfo> {
  void updateAlreadyPaid(double newAlreadyPaid) {
    setState(() {
      widget.alreadyPaid = newAlreadyPaid;
    });
  }

  @override
  Widget build(BuildContext context) {
    final cost = int.tryParse(widget.totalCost)!;
    final term = int.tryParse(widget.term)!;

    final montlypayment = cost / term;
    final rate = widget.rate / 100;

    final remainingPrincipal = cost - widget.alreadyPaid;
    final remainingInterest = remainingPrincipal * rate;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Column(
          children: [
            SizedBox(height: 35),
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.chevron_left),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                Spacer(),
                Text(
                  'ADD MORTGAGE',
                  style: btntext.copyWith(color: Colors.black),
                ),
                Spacer(),
                Icon(
                  Icons.edit,
                  color: Colors.grey,
                )
              ],
            ),
            SizedBox(height: 85),
            Consumer<MortgageProvider>(
              builder: (context, mortgageProvider, child) {
                final List<Mortgage> mortgages = mortgageProvider.mortgages;
                if (mortgages.isEmpty) {
                  return Container();
                }
                final double alreadyPaid =
                    mortgages[widget.mortgageIndex].alreadyPaid;
                final double cost = double.tryParse(widget.totalCost)!;
                final double progress = (alreadyPaid * 100 / cost) / 100;

                return Column(
                  children: [
                    Text(
                      '${(alreadyPaid).toStringAsFixed(2)}\$',
                      style: boldstyle.copyWith(fontWeight: FontWeight.w800),
                    ),
                    Text(
                      'Paid',
                      style: opacityStyle,
                    ),
                    CustomProgressBar(
                      progress: progress,
                      barRadius: 100,
                      barThickness: 15,
                      filledColor: Color(0xFFFF9500),
                      unfilledColor: Color(0xffF6F6F6),
                      shadowColor: Color(0xFFFF9500).withOpacity(0.24),
                      shadowOffset: Offset(4.1, 4.1),
                      shadowBlurRadius: 8.7,
                    ), //
                  ],
                );
              },
            ),
            SizedBox(height: 60),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Current payment',
                  style: contTextMain,
                ),
                Text(
                  '${montlypayment.toStringAsFixed(2)}\$',
                  style: contText,
                )
              ],
            ),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total loan amount',
                  style: contTextMain,
                ),
                Text(
                  '${widget.totalCost}\$',
                  style: contText,
                )
              ],
            ),
            SizedBox(height: 25),
            Container(
              height: 1,
              width: double.infinity,
              color: Color(0xffF6F6F6),
            ),
            SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Paid interest',
                  style: contTextMain,
                ),
                Text(
                  '0',
                  style: contText,
                )
              ],
            ),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Remaining interest',
                  style: contTextMain,
                ),
                Text(
                  '${(remainingInterest).toStringAsFixed(2)}\$',
                  style: contText,
                )
              ],
            ),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total loan amount',
                  style: contTextMain,
                ),
                Text(
                  '${(remainingInterest).toStringAsFixed(2)}\$',
                  style: contText,
                )
              ],
            ),
            SizedBox(height: 25),
            Container(
              height: 1,
              width: double.infinity,
              color: Color(0xffF6F6F6),
            ),
            SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total free',
                  style: contTextMain,
                ),
                Text(
                  '0',
                  style: contText,
                )
              ],
            ),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total Insurance',
                  style: contTextMain,
                ),
                Text(
                  '0',
                  style: contText,
                )
              ],
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => AddPaymentWidget(
                        mortgageIndex: widget.mortgageIndex,
                        currentAlreadyPaid: widget.alreadyPaid,
                        totalCost: double.tryParse(widget.totalCost)!,
                        updateAlreadyPaid: updateAlreadyPaid,
                      ),
                    ));
                  },
                  child: Container(
                    width: 115,
                    height: 55,
                    decoration: BoxDecoration(
                        color: Color(0xffFF9500),
                        borderRadius: BorderRadius.horizontal(
                            left: Radius.circular(25),
                            right: Radius.circular(5))),
                    child: Center(
                        child: Text('Add payment',
                            style: opacityStyle.copyWith(
                                fontWeight: FontWeight.w700,
                                color: Colors.white))),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ScheduleWidget(
                        term: term,
                        amount: cost,
                        date: widget.date,
                      ),
                    ));
                  },
                  child: Container(
                    width: 115,
                    height: 55,
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Color(0xffC1C1C1)),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Center(
                        child: Text(
                      'Schedule',
                      style: opacityStyle.copyWith(fontWeight: FontWeight.w700),
                    )),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => DetailsWidget(),
                    ));
                  },
                  child: Container(
                    width: 115,
                    height: 55,
                    decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Color(0xffC1C1C1)),
                        borderRadius: BorderRadius.horizontal(
                            right: Radius.circular(25),
                            left: Radius.circular(5))),
                    child: Center(
                        child: Text('Details',
                            style: opacityStyle.copyWith(
                                fontWeight: FontWeight.w700))),
                  ),
                )
              ],
            ),
            SizedBox(height: 15),
            GestureDetector(
              onTap: () {
                final mortgageProvider =
                    Provider.of<MortgageProvider>(context, listen: false);
                if (widget.mortgageIndex >= 0 &&
                    widget.mortgageIndex < mortgageProvider.mortgages.length) {
                  Navigator.of(context).pop();
                  mortgageProvider.removeMortage(widget.mortgageIndex);
                } else {
                  print('pizdec');
                  print(widget.mortgageIndex);
                }
              },
              child: Container(
                width: double.infinity,
                height: 52,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7),
                    color: Colors.red.withOpacity(0.02)),
                child: Center(
                  child: Text(
                    'Delete Loan',
                    style: opacityStyle.copyWith(
                        color: Colors.red, fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ),
            SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}

class CustomProgressBar extends StatelessWidget {
  final double progress;
  final double barRadius;
  final double barThickness;
  final Color filledColor;
  final Color unfilledColor;
  final Color shadowColor;
  final Offset shadowOffset;
  final double shadowBlurRadius;

  CustomProgressBar({
    required this.progress,
    required this.barRadius,
    required this.barThickness,
    required this.filledColor,
    required this.unfilledColor,
    required this.shadowColor,
    required this.shadowOffset,
    required this.shadowBlurRadius,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: CustomProgressBarPainter(
        progress: progress,
        barRadius: barRadius,
        barThickness: barThickness,
        filledColor: filledColor,
        unfilledColor: unfilledColor,
        shadowColor: shadowColor,
        shadowOffset: shadowOffset,
        shadowBlurRadius: shadowBlurRadius,
      ),
    );
  }
}

class CustomProgressBarPainter extends CustomPainter {
  final double progress;
  final double barRadius;
  final double barThickness;
  final Color filledColor;
  final Color unfilledColor;
  final Color shadowColor;
  final Offset shadowOffset;
  final double shadowBlurRadius;

  CustomProgressBarPainter({
    required this.progress,
    required this.barRadius,
    required this.barThickness,
    required this.filledColor,
    required this.unfilledColor,
    required this.shadowColor,
    required this.shadowOffset,
    required this.shadowBlurRadius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint unfilledPaint = Paint()
      ..color = unfilledColor
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = barThickness;

    final Paint filledPaint = Paint()
      ..color = filledColor
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = barThickness;

    final Paint shadowPaint = Paint()
      ..color = shadowColor
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = barThickness
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, shadowBlurRadius);

    final Offset center = Offset(size.width / 2, size.height / 2);

    final double sweepAngle = 180 - (progress * 180);

    final Rect rect = Rect.fromCircle(center: center, radius: barRadius);

    // Draw shadow for filled arc
    canvas.drawArc(
      rect,
      pi,
      pi - (pi / 180 * sweepAngle),
      false,
      shadowPaint,
    );

    // Draw unfilled arc
    canvas.drawArc(rect, pi, pi, false, unfilledPaint);

    // Draw filled arc
    canvas.drawArc(
      rect,
      pi,
      pi - (pi / 180 * sweepAngle),
      false,
      filledPaint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
