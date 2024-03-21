import 'package:flutter/material.dart';
import 'package:mortgage_calc/const/app_styles.dart';

class ScheduleWidget extends StatefulWidget {
  final int term;
  final int amount;
  final DateTime date;
  const ScheduleWidget(
      {super.key,
      required this.term,
      required this.amount,
      required this.date});

  @override
  State<ScheduleWidget> createState() => _ScheduleWidgetState();
}

class _ScheduleWidgetState extends State<ScheduleWidget> {
  @override
  Widget build(BuildContext context) {
    final monthpay = widget.amount / widget.term;
    List<Color> colors = [Colors.white, Color(0xFFFFFAF2)];
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
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
                  'SCHEDULE',
                  style: btntext.copyWith(
                      color: Colors.black, fontWeight: FontWeight.w800),
                ),
                Spacer(),
                Container(
                  width: 40,
                )
              ],
            ),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Date',
                  style: opacityStyle.copyWith(
                      fontSize: 10, fontWeight: FontWeight.w700),
                ),
                SizedBox(width: 25),
                Text('Amount',
                    style: opacityStyle.copyWith(
                        fontSize: 10, fontWeight: FontWeight.w700)),
                SizedBox(width: 25),
                Text('Debt',
                    style: opacityStyle.copyWith(
                        fontSize: 10, fontWeight: FontWeight.w700))
              ],
            ),
            SizedBox(height: 10),
            Container(
              width: double.infinity,
              height: 1,
              color: Color(0xffF0F0F0),
            ),
            Expanded(
              child: MediaQuery.removePadding(
                removeTop: true,
                context: context,
                child: ListView.builder(
                  itemCount: widget.term,
                  itemBuilder: (context, index) {
                    final currentMonth =
                        widget.date.add(Duration(days: 30 * index));
                    final currentDebt = widget.amount - monthpay * index;
                    final colorIndex = index % colors.length;

                    return Container(
                      width: double.infinity,
                      height: 45,
                      color: colors[colorIndex],
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            '${currentMonth.day}.${currentMonth.month}.${currentMonth.year}',
                            style: contTextMain.copyWith(fontSize: 10),
                          ),
                          SizedBox(width: 15),
                          Text(
                            monthpay.toStringAsFixed(2),
                            style: contTextMain.copyWith(fontSize: 10),
                          ),
                          SizedBox(width: 15),
                          Text(
                            currentDebt.toStringAsFixed(2),
                            style: contTextMain.copyWith(fontSize: 10),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
