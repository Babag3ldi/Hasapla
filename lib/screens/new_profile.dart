import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_budget_tracking_app/common/color_constants.dart';

class NewProfilePage extends StatefulWidget {
  @override
  State<NewProfilePage> createState() => _NewProfilePageState();
}

class _NewProfilePageState extends State<NewProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(title: Text('Profile')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                height: 110,
                width: 110,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: const Color(0xfff8f8f8),
                    borderRadius: BorderRadius.circular(100)),
                child: Icon(CupertinoIcons.person, size: 80)),
            SizedBox(height: 30),
            profileContainer(() {}, "My Profile", CupertinoIcons.person),
            SizedBox(height: 15),
            profileContainer(() {}, "Invite User", CupertinoIcons.person_add),
            SizedBox(height: 15),
            profileContainer(() {}, "Customer Support", Icons.support_agent),
            SizedBox(height: 15),
            profileContainer(
                () {}, "Privacy policy", Icons.privacy_tip_outlined),
            SizedBox(height: 15),
            profileContainer(() {}, "Log out", Icons.logout)
          ],
        ),
      ),
    );
  }

  InkWell profileContainer(VoidCallback onTap, String text, IconData icon) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: const Color(0xfff8f8f8),
        ),
        child: Row(
          children: [
            Icon(icon),
            SizedBox(width: 10),
            Text(text),
            Spacer(),
            Icon(CupertinoIcons.forward)
          ],
        ),
      ),
    );
  }
}
