import 'package:flutter/material.dart';
import 'package:flutter_budget_tracking_app/common/color_constants.dart';

import '../widgets/bottom_navigation_bar_widget.dart';
import '../widgets/button.dart';
import '../widgets/textfield_const.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController phoneNumberController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double sizeHeight = MediaQuery.of(context).size.height / 100;
    double sizeWidth = MediaQuery.of(context).size.width / 100;
    return Scaffold(
        backgroundColor: white,
        appBar: AppBar(title: Text("Ulgama girmek")),
        body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(children: [
                SizedBox(height: sizeHeight * 8),
                Image.asset('assets/images/gift.png', height: sizeHeight * 15),
                SizedBox(height: sizeHeight * 8),
                Center(child: Text("Hoş geldiňiz! Maglumatlaryňyzy ýazyň")),
                SizedBox(height: sizeHeight * 3.5),
                PhoneTextfieldWidget(
                    controller: phoneNumberController,
                    text: "Gmail",
                    textInputType: TextInputType.emailAddress),
                SizedBox(height: sizeHeight * 2),
                PhoneTextfieldWidget(
                    controller: phoneNumberController,
                    text: "Password",
                    textInputType: TextInputType.text),
                const SizedBox(height: 67),
                ButtonConst(
                    sizeHeight: sizeHeight,
                    sizeWidth: sizeWidth,
                    text: 'Ulgama girmek',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BottomNavigationBarWidget()),
                      );
                    })
              ]),
            )));
  }
}
