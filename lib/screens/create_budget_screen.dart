import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_budget_tracking_app/common/color_constants.dart';
import 'package:flutter_budget_tracking_app/json/create_budget_json.dart';
import 'package:flutter_budget_tracking_app/main.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../model/budget_model.dart';
import '../widgets/bottom_navigation_bar_widget.dart';

class CreatBudgetScreen extends StatefulWidget {
  @override
  _CreatBudgetScreenState createState() => _CreatBudgetScreenState();
}

class _CreatBudgetScreenState extends State<CreatBudgetScreen> {
  TextEditingController budgetName = TextEditingController();
  TextEditingController budgetPrice = TextEditingController();
  List<BudgetModel> hiveList = [];
  int activeCategory = 0;
  int? status;

  @override
  void initState() {
    super.initState();
    getFromHive();
  }

  addPerson(String image, String category) {
    BudgetModel personModel = BudgetModel(
        id: 0,
        images: image,
        name: budgetName.text,
        price: budgetPrice.text,
        time: DateTime.now(),
        category: category,
        status: status!);
    saveToHive(personModel);
  }

  saveToHive(BudgetModel personModel) {
    hiveList.add(personModel);
    Hive.box('Budget').put("budgetList", hiveList);
    setState(() {});
  }

  getFromHive() {
    List bazadan = Hive.box('Budget').get("budgetList", defaultValue: []);
    if (bazadan.isNotEmpty) {
      hiveList = List<BudgetModel>.from(bazadan.map((e) => e as BudgetModel));
      print("length ${hiveList.length}");
    }
    setState(() {});
  }

  clearDatabase() {
    Hive.box('Budget').clear();
    hiveList = [];
    setState(() {});
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
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(color: white, boxShadow: [
              BoxShadow(
                  color: grey.withOpacity(0.01),
                  spreadRadius: 10,
                  blurRadius: 3)
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
                        "Býudjet dörediň",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: black),
                      ),
                      Row(children: [
                        InkWell(
                            onTap: () {
                              clearDatabase();
                            },
                            child: Icon(CupertinoIcons.delete))
                      ])
                    ],
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
            child: Text(
              "Kategoriýany saýlaň",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: black.withOpacity(0.5)),
            ),
          ),
          SizedBox(height: 20),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
                children: List.generate(categories.length, (index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    activeCategory = index;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 10,
                  ),
                  child: Container(
                    margin: EdgeInsets.only(
                      left: 10,
                    ),
                    width: 150,
                    height: 170,
                    decoration: BoxDecoration(
                        color: white,
                        border: Border.all(
                            width: 2,
                            color: activeCategory == index
                                ? primary
                                : Colors.transparent),
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
                                  color: grey.withOpacity(0.15)),
                              child: Center(
                                child: Image.asset(categories[index]['icon'],
                                    width: 30, height: 30, fit: BoxFit.contain),
                              )),
                          Text(
                            categories[index]['name'],
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
            })),
          ),
          SizedBox(height: 50),
          Row(
            children: [
              Expanded(
                child: ListTile(
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  title: Text("Çykdajy", style: TextStyle(fontSize: 18),),
                  leading: Radio(
                    // visualDensity: const VisualDensity(
                    //     horizontal: VisualDensity
                    //         .minimumDensity,
                    //     vertical: VisualDensity
                    //         .minimumDensity),
                    // materialTapTargetSize:
                    //     MaterialTapTargetSize
                    //         .shrinkWrap,
                    value: 0,
                    groupValue: status,
                    activeColor: const Color(0xFF6200EE),
                    onChanged: (val) {
                      setState(() {
                        status = val as int?;
                      });
                    },
                  ),
                ),
              ),
              Expanded(
                child: ListTile(
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  title: Text("Girdeji", style: TextStyle(fontSize: 18),),
                  leading: Radio(
                    value: 1,
                    groupValue: status,
                    activeColor: const Color(0xFF6200EE),
                    onChanged: (val) {
                      setState(() {
                        status = val as int?;
                      });
                    },
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Býudjetiň ady",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 13,
                      color: Color(0xff67727d)),
                ),
                SizedBox(
                  height: 50,
                  child: TextField(
                    controller: budgetName,
                    cursorColor: black,
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: black),
                    decoration: InputDecoration(
                        hintText: "Býudjetiň adyny giriziň",
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red, width: 5.0),
                        )),
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: (size.width - 140),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Býudjet giriziň",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 13,
                                color: Color(0xff67727d)),
                          ),
                          SizedBox(
                            height: 50,
                            child: TextField(
                              controller: budgetPrice,
                              cursorColor: black,
                              style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  color: black),
                              decoration: InputDecoration(
                                  hintText: "Býudjetin bahasys",
                                  // border: InputBorder.none

                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.red, width: 5.0),
                                  )),
                              keyboardType: TextInputType.number,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 20),
                    InkWell(
                      onTap: () {
                        print("save");
                        if (activeCategory == 0 &&
                            budgetName.text.isEmpty &&
                            budgetPrice.text.isEmpty &&
                            status == null) {
                          var snackBar = SnackBar(
                              content: Text('Maglumatlary doly girizin'));
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          return;
                        }
                        addPerson(categories[activeCategory]['icon'],
                            categories[activeCategory]['name']);
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => BottomNavigationBarWidget()),
                        );
                      },
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                            color: primary,
                            borderRadius: BorderRadius.circular(15)),
                        child: Icon(
                          Icons.arrow_forward,
                          color: white,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
