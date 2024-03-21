import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:mortgage_calc/const/app_styles.dart';
import 'package:mortgage_calc/const/model.dart';
import 'package:provider/provider.dart';

class AddPaymentWidget extends StatefulWidget {
  final int mortgageIndex;
  final double currentAlreadyPaid;
  final double totalCost;
  final Function(double) updateAlreadyPaid;
  const AddPaymentWidget(
      {super.key,
      required this.currentAlreadyPaid,
      required this.mortgageIndex,
      required this.totalCost,
      required this.updateAlreadyPaid});

  @override
  State<AddPaymentWidget> createState() => _AddPaymentWidgetState();
}

class _AddPaymentWidgetState extends State<AddPaymentWidget> {
  void popWithResult(BuildContext context, dynamic result) {
    Navigator.pop(context, result);
  }

  void _addPayment() async {
    final inputValue = controller.text;
    final newPaymentAmount =
        double.tryParse(inputValue.replaceAll('\$', '')) ?? 0.0;
    final double newAlreadyPaid = widget.currentAlreadyPaid + newPaymentAmount;
    Provider.of<MortgageProvider>(context, listen: false)
        .updateAlreadyPaid(widget.mortgageIndex, newAlreadyPaid);
    await Provider.of<MortgageProvider>(context, listen: false)
        .saveMortgagesToPrefs();
    widget.updateAlreadyPaid(newAlreadyPaid);
    popWithResult(context, newAlreadyPaid);
  }

  TextEditingController controller = TextEditingController(text: '\$');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
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
                  'ADD PAYMENT',
                  style: btntext.copyWith(color: Colors.black),
                ),
                Spacer(),
                Container(
                  width: 40,
                )
              ],
            ),
            Spacer(),
            Center(
              child: TextField(
                controller: controller,
                textAlign: TextAlign.center,
                style: boldstyle.copyWith(
                  fontSize: 60,
                  fontWeight: FontWeight.w700,
                ),
                decoration: InputDecoration(
                  fillColor: Color(0xffF6F6F6),
                  filled: true,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                ),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
              ),
            ),
            Spacer(),
            GestureDetector(
              onTap: () {
                final inputValue = controller.text;
                final newPaymentAmount =
                    double.tryParse(inputValue.replaceAll('\$', '')) ?? 0.0;
                final newAlreadyPaid =
                    widget.currentAlreadyPaid + newPaymentAmount;

                if (newAlreadyPaid <= widget.totalCost) {
                  _addPayment();
                } else {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('Error'),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                                'Payment amount cannot exceed the total cost of the mortgage.'),
                            SizedBox(height: 10),
                            Text(
                              'You need to pay ${widget.totalCost.toStringAsFixed(2)}\$ more to complete the mortgage.',
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
              child: Container(
                height: 62,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Color(0xffFF9500),
                ),
                child: Center(
                  child: Text(
                    'ADD LOAN',
                    style: btntext.copyWith(
                      fontSize: 13,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
