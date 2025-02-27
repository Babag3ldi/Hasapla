import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_budget_tracking_app/common/color_constants.dart';
import 'package:flutter_budget_tracking_app/json/day_month.dart';
import 'package:flutter_budget_tracking_app/widgets/chart.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../model/budget_model.dart';
// import 'package:flutter_icons/flutter_icons.dart';

/*
Title:StatsScreen
Purpose:StatsScreen
Created By:Kalpesh Khandla
*/

class StatsScreen extends StatefulWidget {
  @override
  _StatsScreenState createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  int activeDay = 3;
  List<BudgetModel> hiveList = [];
  bool showAvg = false;

  @override
  void initState() {
    super.initState();
    getFromHive();
  }

  getFromHive() {
    List bazadan = Hive.box('Budget').get("budgetList", defaultValue: []);
    print("length${bazadan.length}");
    if (bazadan.isNotEmpty) {
      hiveList = List<BudgetModel>.from(bazadan.map((e) => e as BudgetModel));
    }
    jemiBaha();
    jemiBahaGirdeji();
    setState(() {});
  }

  clearDatabase() {
    Hive.box('Budget').clear();
    hiveList = [];
    setState(() {});
  }

  double jemiBaha() {
    double sum = 0;
    for (var index = 0; index < hiveList.length; index++) {
      if (hiveList[index].status == 1)
      sum += hiveList[index].price.isEmpty
          ? 0
          : double.parse(hiveList[index].price);
    }
    return sum;
  }

  double jemiBahaGirdeji() {
    double sum = 0;
    for (var index = 0; index < hiveList.length; index++) {
      if (hiveList[index].status == 0)
        sum += hiveList[index].price.isEmpty
            ? 0
            : double.parse(hiveList[index].price);
    }
    return sum;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: grey.withOpacity(0.05),
      body: getBody(),
    );
  }

  Widget getBody() {
    var size = MediaQuery.of(context).size;

    List expenses = [
      {
        "icon": Icons.arrow_back,
        "color": blue,
        "label": "Girdejiler",
        "cost": "${jemiBaha()} TMT"
      },
      {
        "icon": Icons.arrow_forward,
        "color": red,
        "label": "Çykdajylar",
        "cost": "${jemiBahaGirdeji()} TMT"
      }
    ];
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(color: white, boxShadow: [
              BoxShadow(
                color: grey.withOpacity(0.01),
                spreadRadius: 10,
                blurRadius: 3,
                // changes position of shadow
              ),
            ]),
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 60, right: 20, left: 20, bottom: 25),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Status",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: black),
                      ),
                      InkWell(
                          onTap: () {
                            clearDatabase();
                          },
                          child: Icon(CupertinoIcons.delete))
                    ],
                  ),
                  SizedBox(height: 25),
                  Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: List.generate(months.length, (index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              activeDay = index;
                            });
                          },
                          child: Container(
                            width: (MediaQuery.of(context).size.width - 40) / 6,
                            child: Column(
                              children: [
                                Text(
                                  months[index]['label'],
                                  style: TextStyle(fontSize: 10),
                                ),
                                SizedBox(height: 10),
                                Container(
                                  decoration: BoxDecoration(
                                      color: activeDay == index
                                          ? primary
                                          : black.withOpacity(0.02),
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                          color: activeDay == index
                                              ? primary
                                              : black.withOpacity(0.1))),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 12, right: 12, top: 7, bottom: 7),
                                    child: Text(
                                      months[index]['day'],
                                      style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600,
                                          color: activeDay == index
                                              ? white
                                              : black),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      }))
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Container(
              width: double.infinity,
              height: 250,
              decoration: BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: grey.withOpacity(0.01),
                      spreadRadius: 10,
                      blurRadius: 3,
                      // changes position of shadow
                    ),
                  ]),
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 10,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Umumy Summa",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 13,
                                color: Color(0xff67727d)),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "${jemiBaha()} TMT",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                            ),
                          )
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      child: Container(
                        width: (size.width - 20),
                        height: 150,
                        child: LineChart(mainData()),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          Wrap(
              spacing: 20,
              children: List.generate(expenses.length, (index) {
                return Container(
                  width: (size.width - 60) / 2,
                  height: 170,
                  decoration: BoxDecoration(
                      color: white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: grey.withOpacity(0.01),
                          spreadRadius: 10,
                          blurRadius: 3,
                          // changes position of shadow
                        ),
                      ]),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 25, right: 25, top: 20, bottom: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: expenses[index]['color']),
                          child: Center(
                              child:
                                  Icon(expenses[index]['icon'], color: white)),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              expenses[index]['label'],
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 13,
                                  color: Color(0xff67727d)),
                            ),
                            SizedBox(height: 8),
                            Text(
                              expenses[index]['cost'],
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                );
              }))
        ],
      ),
    );
  }
}
