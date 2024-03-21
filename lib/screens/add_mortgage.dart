import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:mortgage_calc/const/app_styles.dart';
import 'package:intl/intl.dart';
import 'package:mortgage_calc/const/model.dart';
import 'package:provider/provider.dart';

class AddMortGageWidget extends StatefulWidget {
  final VoidCallback? onExit;
  const AddMortGageWidget({super.key, this.onExit});

  @override
  State<AddMortGageWidget> createState() => _AddMortGageWidgetState();
}

class _AddMortGageWidgetState extends State<AddMortGageWidget> {
  final title = TextEditingController();
  final amount = TextEditingController();
  final rate = TextEditingController();
  final term = TextEditingController();
  final datecontroller = TextEditingController();
  bool isAnnuitySelected = true;
  final MaskTextInputFormatter dateMaskFormatter = MaskTextInputFormatter(
      mask: '##.##.####', filter: {"#": RegExp(r'[0-9]')});
  Future<void> _selectDate(BuildContext context) async {
    DateTime currentDate = DateTime.now();

    setState(() {
      final formattedDate = DateFormat('dd.MM.yyyy').format(currentDate);
      datecontroller.text = formattedDate;

      final mortgageProvider =
          Provider.of<MortgageProvider>(context, listen: false);
      mortgageProvider.setSelectedDate(currentDate);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                Icon(Icons.settings)
              ],
            ),
            TextField(
              controller: title,
              cursorColor: Colors.black,
              style: btntext.copyWith(color: Colors.black, fontSize: 14),
              decoration: txtFieldStyle.copyWith(hintText: 'Title'),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: Container(
                    child: TextField(
                      controller: amount,
                      cursorColor: Colors.black,
                      style:
                          btntext.copyWith(color: Colors.black, fontSize: 14),
                      decoration: txtFieldStyle.copyWith(hintText: 'Amount'),
                    ),
                  ),
                ),
                SizedBox(width: 15),
                Expanded(
                  child: Container(
                    child: TextField(
                      controller: rate,
                      cursorColor: Colors.black,
                      style:
                          btntext.copyWith(color: Colors.black, fontSize: 14),
                      decoration: txtFieldStyle.copyWith(hintText: 'Rate'),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: Container(
                    child: TextField(
                      controller: term,
                      cursorColor: Colors.black,
                      style:
                          btntext.copyWith(color: Colors.black, fontSize: 14),
                      decoration: txtFieldStyle.copyWith(hintText: 'Term'),
                    ),
                  ),
                ),
                SizedBox(width: 15),
                Expanded(
                  child: Container(
                    child: TextField(
                      readOnly: true,
                      controller: datecontroller,
                      style:
                          btntext.copyWith(color: Colors.black, fontSize: 14),
                      decoration: txtFieldStyle.copyWith(
                          hintText: 'First Payment Date'),
                      onTap: () {
                        _selectDate(context);
                      },
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 30),
            Text(
              'Payment type',
              style: opacityStyle.copyWith(fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isAnnuitySelected = true;
                    });
                  },
                  child: Container(
                    width: 160,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      color:
                          isAnnuitySelected ? Color(0xffFF9500) : Colors.white,
                    ),
                    child: Center(
                      child: Text(
                        'ANNUITY',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Montserrat',
                          color: isAnnuitySelected
                              ? Colors.white
                              : Color(0xffFF9500),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isAnnuitySelected = false;
                    });
                  },
                  child: Container(
                    width: 160,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      color:
                          isAnnuitySelected ? Colors.white : Color(0xffFF9500),
                    ),
                    child: Center(
                      child: Text(
                        'DIFFERENTIAL',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Montserrat',
                          color: isAnnuitySelected
                              ? Color(0xffFF9500)
                              : Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Spacer(),
            GestureDetector(
              onTap: () {
                if (title.text.isEmpty &&
                    amount.text.isEmpty &&
                    rate.text.isEmpty &&
                    term.text.isEmpty &&
                    datecontroller.text.isEmpty) {
                } else {
                  final mortgageProvider =
                      Provider.of<MortgageProvider>(context, listen: false);
                  final mortgage = Mortgage(
                    alreadyPaid: 0,
                    title: title.text,
                    amount: amount.text,
                    rate: rate.text,
                    term: term.text,
                    date: DateTime.now(),
                  );
                  mortgageProvider.addMortgage(mortgage);
                  Navigator.of(context).pop();
                }
              },
              child: Container(
                height: 62,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: title.text.isEmpty &&
                          amount.text.isEmpty &&
                          rate.text.isEmpty &&
                          term.text.isEmpty &&
                          datecontroller.text.isEmpty
                      ? Color(0xffF9F9F9)
                      : Color(0xffFF9500),
                ),
                child: Center(
                  child: Text(
                    'ADD LOAN',
                    style: btntext.copyWith(
                      fontSize: 13,
                      color: title.text.isEmpty &&
                              amount.text.isEmpty &&
                              rate.text.isEmpty &&
                              term.text.isEmpty &&
                              datecontroller.text.isEmpty
                          ? Color(0xffC1C1C1)
                          : Colors.white,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
