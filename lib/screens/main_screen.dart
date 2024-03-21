import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:mortgage_calc/const/app_images.dart';
import 'package:mortgage_calc/const/app_styles.dart';
import 'package:mortgage_calc/const/model.dart';
import 'package:mortgage_calc/screens/add_mortgage.dart';
import 'package:mortgage_calc/screens/finance_screen.dart';
import 'package:mortgage_calc/screens/mortgage_info.dart';
import 'package:mortgage_calc/screens/settings.dart';
import 'package:provider/provider.dart';

class MainWidget extends StatefulWidget {
  const MainWidget({super.key});

  @override
  State<MainWidget> createState() => MainWidgetState();
}

class MainWidgetState extends State<MainWidget> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: IndexedStack(
            index: _currentIndex,
            children: [Mortgage(), FinanceWidget(), SettingsWidget()]),
      ),
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Color(0xffC1C1C1),
        selectedItemColor: Color(0xffFF9500),
        selectedLabelStyle:
            TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.w700),
        unselectedLabelStyle:
            TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.w700),
        selectedFontSize: 9,
        unselectedFontSize: 9,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(mortgage),
            activeIcon: SvgPicture.asset(mortgageactive),
            label: 'MORTGAGE',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(finance),
            activeIcon: SvgPicture.asset(financeactive),
            label: 'FINANCE',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(settings),
            activeIcon: SvgPicture.asset(settingsactive),
            label: 'SETTINGS',
          )
        ],
      ),
    );
  }
}

class Mortgage extends StatefulWidget {
  const Mortgage({
    super.key,
  });

  @override
  State<Mortgage> createState() => _MortgageState();
}

class _MortgageState extends State<Mortgage> {
  @override
  Widget build(BuildContext context) {
    final mortgageProvider = Provider.of<MortgageProvider>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 45),
        Text(
          'YOUR MORTGAGES',
          style: boldstyle.copyWith(fontSize: 18),
        ),
        SizedBox(height: 25),
        mortgageProvider.mortgages.isEmpty
            ? Center(child: NoInfo2())
            : Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      showBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return AddMortGageWidget();
                          });
                    },
                    child: Container(
                      width: 40,
                      height: 125,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Color(0xffFF9500),
                      ),
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: SizedBox(
                      height: 125,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: mortgageProvider.mortgages.length,
                        separatorBuilder: (BuildContext context, int index) {
                          return SizedBox(width: 10);
                        },
                        itemBuilder: (BuildContext context, int index) {
                          final mortgage = mortgageProvider.mortgages[index];
                          return GestureDetector(
                            onTap: () {
                              _showMortgageInfo(context, index);
                            },
                            child: Container(
                              width: 245,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(11),
                                color: Color(0xffFAFAFA),
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      mortgage.title,
                                      style: boldstyle.copyWith(fontSize: 13),
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      'Your monthly payment:${(int.tryParse(mortgage.amount)! / int.tryParse(mortgage.term)!).toStringAsFixed(2)}\$',
                                      style: opacityStyle,
                                    ),
                                    Text(
                                      'Already paid: ${mortgage.alreadyPaid}\$',
                                      style: opacityStyle,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
        SizedBox(height: 35),
        Container(
          width: double.infinity,
          height: 1,
          color: Color.fromARGB(255, 193, 193, 193),
        ),
        SizedBox(height: 35),
        Text(
          'Transactions',
          style: opacityStyle,
        ),
        SizedBox(height: 35),
        Expanded(
          child: mortgageProvider.mortgages.isEmpty
              ? Center(child: NoInfo())
              : MediaQuery.removePadding(
                  removeTop: true,
                  context: context,
                  child: ListView.builder(
                    itemCount: mortgageProvider.mortgages.length,
                    itemBuilder: (context, index) {
                      final mortgage = mortgageProvider.mortgages[index];
                      final formattedDate = DateFormat('dd.MM.yyyy | HH:mm')
                          .format(mortgage.date);
                      return Container(
                        height: 75,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  'Payment "${mortgage.title}"',
                                  style: boldstyle.copyWith(fontSize: 12),
                                ),
                                Text(
                                  '${formattedDate}',
                                  style: opacityStyle.copyWith(fontSize: 10),
                                )
                              ],
                            ),
                            Text(
                              '- \$ ${mortgage.amount}',
                              style: btntext.copyWith(color: Color(0xffFF9500)),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ),
        )
      ],
    );
  }

  void _showMortgageInfo(BuildContext context, int index) {
    final mortgageProvider =
        Provider.of<MortgageProvider>(context, listen: false);

    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => MortgageInfo(
        totalCost: mortgageProvider.mortgages[index].amount,
        term: mortgageProvider.mortgages[index].term,
        alreadyPaid: mortgageProvider.mortgages[index].alreadyPaid,
        mortgageIndex: index,
        date: mortgageProvider.mortgages[index].date,
        rate: int.tryParse(mortgageProvider.mortgages[index].rate)!,
      ),
    ));
  }
}

class NoInfo extends StatelessWidget {
  const NoInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('NO TRANSACTIONS YET', style: boldstyle.copyWith(fontSize: 13)),
        SizedBox(height: 7),
        Text(
          'In the future, your mortgage payments will be displayed here',
          textAlign: TextAlign.center,
          style: opacityStyle,
        )
      ],
    );
  }
}

class NoInfo2 extends StatelessWidget {
  const NoInfo2({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showAddMortGage(context);
      },
      child: DottedBorder(
        borderType: BorderType.RRect,
        radius: Radius.circular(15),
        color: Colors.grey,
        strokeWidth: 1,
        dashPattern: [8, 8],
        child: Container(
          height: 125,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(Icons.add),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Add mortgage info',
                      style: btntext.copyWith(color: Colors.black),
                    ),
                    Text(
                      'Add information about your mortgage \nby clicking the "Add Loan" button',
                      style: opacityStyle,
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showAddMortGage(BuildContext context) {
    showBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return AddMortGageWidget();
        });
  }
}
